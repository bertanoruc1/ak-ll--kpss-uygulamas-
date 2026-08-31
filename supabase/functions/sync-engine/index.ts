// Data Sync Engine — resmi kaynak sayfalarını periyodik olarak çeker, içerik hash'ler,
// önceki hash ile karşılaştırır ve fark varsa sync_log'a kaydeder. Sınav tarihi gibi
// kritik alanlarda basit regex tabanlı bir tarih tespiti dener; yüksek güven yoksa
// hiçbir zaman otomatik uygulamaz (apply_exam_field_change RPC'si zaten bunu garanti eder).
//
// SOURCE -> DETECT -> VERIFY -> NORMALIZE -> UPDATE -> NOTIFY -> ADAPT
//
// Çağrı şekilleri:
//   POST { "source_id": "<uuid>" }  -> yalnızca o kaynağı senkronize eder (admin "Şimdi Senkronize Et")
//   POST {}                          -> kontrol zamanı gelen tüm aktif kaynakları senkronize eder (pg_cron)
//
// GÜVENLİK (2026-08-30 denetiminde eklendi): Daha önce hiçbir çağıran-doğrulaması
// yoktu — herkese açık anon key ile bile (Supabase'in varsayılan JWT kontrolü
// yalnızca "geçerli BİR JWT mi" der) bu fonksiyon service_role yetkisiyle
// çalıştırılabiliyor, hatta `source_id` verilerek 000-frekans kontrolü bile
// atlatılıp dış sitelere (ÖSYM/MEB) istenildiği kadar zorla istek attırılabiliyordu.
// Şimdi iki geçerli çağıran türü var: (1) pg_cron — `x-cron-secret` header'ı
// CRON_SECRET ortam değişkenine eşit olmalı; (2) admin paneli — çağıranın kendi
// Supabase oturum JWT'si ile giriş yapmış VE is_admin() = true olması gerekir.
// İkisi de sağlanmazsa 401 döner.
// Deploy: supabase secrets set CRON_SECRET=...

import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";

async function isAuthorized(req: Request, supabaseUrl: string, anonKey: string): Promise<boolean> {
  const cronSecret = Deno.env.get("CRON_SECRET");
  const providedSecret = req.headers.get("x-cron-secret");
  if (cronSecret && providedSecret === cronSecret) return true;

  const authHeader = req.headers.get("Authorization");
  if (!authHeader) return false;
  const userClient = createClient(supabaseUrl, anonKey, {
    global: { headers: { Authorization: authHeader } },
  });
  const { data: userData, error: userErr } = await userClient.auth.getUser();
  if (userErr || !userData?.user) return false;
  const { data: isAdminResult, error: adminErr } = await userClient.rpc("is_admin");
  if (adminErr) return false;
  return isAdminResult === true;
}

async function sha256(text: string): Promise<string> {
  const data = new TextEncoder().encode(text);
  const hashBuffer = await crypto.subtle.digest("SHA-256", data);
  return Array.from(new Uint8Array(hashBuffer)).map((b) => b.toString(16).padStart(2, "0")).join("");
}

function normalizeHtml(html: string): string {
  return html
    .replace(/<script[\s\S]*?<\/script>/gi, "")
    .replace(/<style[\s\S]*?<\/style>/gi, "")
    .replace(/<[^>]+>/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

// Bilinen tarih desenlerini (gg.aa.yyyy, "gg Ay yyyy") metinden çıkarmayı dener.
// Bu, YALNIZCA bir "aday değişiklik" sinyali üretir; asla tek başına yeterli güven sayılmaz.
function findDateCandidates(text: string): string[] {
  const monthMap: Record<string, string> = {
    ocak: "01", şubat: "02", subat: "02", mart: "03", nisan: "04", mayıs: "05", mayis: "05",
    haziran: "06", temmuz: "07", ağustos: "08", agustos: "08", eylül: "09", eylul: "09",
    ekim: "10", kasım: "11", kasim: "11", aralık: "12", aralik: "12",
  };
  const results: string[] = [];
  const re1 = /(\d{1,2})\s+(Ocak|Şubat|Subat|Mart|Nisan|Mayıs|Mayis|Haziran|Temmuz|Ağustos|Agustos|Eylül|Eylul|Ekim|Kasım|Kasim|Aralık|Aralik)\s+(\d{4})/gi;
  let m;
  while ((m = re1.exec(text)) !== null) {
    const mon = monthMap[m[2].toLowerCase()];
    if (mon) results.push(`${m[3]}-${mon}-${m[1].padStart(2, "0")}`);
  }
  return [...new Set(results)];
}

Deno.serve(async (req: Request) => {
  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const anonKey = Deno.env.get("SUPABASE_ANON_KEY")!;
    const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

    if (!(await isAuthorized(req, supabaseUrl, anonKey))) {
      return new Response(JSON.stringify({ error: "unauthorized" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }

    const supabase = createClient(supabaseUrl, serviceKey);

    let body: any = {};
    try { body = await req.json(); } catch { /* boş body olabilir */ }

    let sourcesQuery = supabase.from("data_sources").select("*").eq("is_active", true);
    if (body.source_id) {
      sourcesQuery = sourcesQuery.eq("id", body.source_id);
    }
    const { data: sources, error: srcErr } = await sourcesQuery;
    if (srcErr) throw srcErr;

    const now = Date.now();
    const results: any[] = [];

    for (const source of sources ?? []) {
      // Periyodik modda (source_id verilmemiş), yalnızca kontrol zamanı gelmiş kaynakları işle.
      if (!body.source_id && source.last_checked_at) {
        const last = new Date(source.last_checked_at).getTime();
        const dueAt = last + (source.check_frequency_minutes ?? 360) * 60_000;
        if (now < dueAt) continue;
      }

      let status = "no_change";
      let newHash: string | null = null;
      let diffSummary: string | null = null;
      let confidence: number | null = null;

      try {
        const res = await fetch(source.url, { headers: { "User-Agent": "KPSS-Akilli-Platform-SyncEngine/1.0" } });
        const html = await res.text();
        const normalized = normalizeHtml(html);
        newHash = await sha256(normalized);

        if (source.last_content_hash && source.last_content_hash === newHash) {
          status = "no_change";
        } else if (!source.last_content_hash) {
          // İlk kontrol — temel hash'i oluştur, henüz "değişiklik" sayma.
          status = "no_change";
        } else {
          status = "changed";
          const dates = findDateCandidates(normalized);
          diffSummary = dates.length
            ? `İçerik değişti. Metinde bulunan olası tarihler: ${dates.join(", ")}`
            : "İçerik değişti, ancak otomatik olarak tarih deseni tespit edilemedi.";
          // Basit sinyal: birden fazla farklı tarih adayı varsa güven düşük; tek net aday varsa orta.
          confidence = dates.length === 1 ? 0.6 : dates.length > 1 ? 0.35 : 0.2;
        }

        await supabase.rpc("record_sync_check", {
          p_source_id: source.id, p_status: status, p_new_hash: newHash,
          p_diff_summary: diffSummary, p_confidence: confidence,
        });
      } catch (fetchErr) {
        status = "error";
        await supabase.rpc("record_sync_check", {
          p_source_id: source.id, p_status: "error", p_new_hash: null,
          p_diff_summary: String(fetchErr), p_confidence: null,
        });
      }

      results.push({ source_id: source.id, name: source.name, status, confidence });
    }

    return new Response(JSON.stringify({ checked: results.length, results }), {
      headers: { "Content-Type": "application/json" },
    });
  } catch (e) {
    return new Response(JSON.stringify({ error: String(e) }), { status: 500, headers: { "Content-Type": "application/json" } });
  }
});
