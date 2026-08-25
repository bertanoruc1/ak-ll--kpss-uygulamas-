// ai-chat — öğrencinin tarayıcıdan (assistant.js) DOĞRUDAN çağırdığı, serbest
// sohbet edebilen yapay zeka asistanı. Eskisi (ai_assistant_ask RPC) sabit
// kalıplara/niyetlere göre çalışan kural tabanlı bir motordu; bu fonksiyon
// gerçek bir Claude modeline (Anthropic Messages API) bağlanıyor, bu yüzden
// önceden tanımlanmış kalıplarla sınırlı değil — serbestçe sohbet edebilir,
// genel konularda soru cevaplayabilir, konu anlatabilir, motive edebilir.
//
// Nasıl çalışır:
//   1) İsteği gönderen kullanıcının kimliğini (JWT'den) doğrular.
//   2) Kullanıcının KENDİ verileriyle (get_homepage + en zayıf/güçlü konu)
//      bir "bağlam" (grounding) hazırlar — böylece model, öğrencinin gerçek
//      performansı hakkında UYDURMAZ, yalnızca burada verilen gerçek
//      sayılara dayanır.
//   3) Bu bağlamı + konuşma geçmişini + yeni mesajı Anthropic Messages
//      API'sine (Claude) gönderir, yanıtı döndürür.
//
// ÖNEMLİ — henüz yapılandırılmadıysa ne olur:
//   ANTHROPIC_API_KEY (ve ANTHROPIC_MODEL) secret olarak tanımlanmadıysa bu
//   fonksiyon 501 + {"error":"llm_not_configured"} döner. assistant.js bunu
//   görünce SESSİZCE eski kural tabanlı ai_assistant_ask RPC'sine geri döner
//   — yani bu fonksiyon deploy edilmeden/yapılandırılmadan önce de asistan
//   sayfası kırılmadan, eski haliyle çalışmaya devam eder.
//
// Deploy: bkz. bu klasördeki README.md (supabase functions deploy ai-chat +
// supabase secrets set ANTHROPIC_API_KEY=... ANTHROPIC_MODEL=...)

import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";

const CORS_HEADERS: Record<string, string> = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
  });
}

const SYSTEM_PROMPT_TEMPLATE = `Sen "KPSS Akıllı" adlı bir sınav hazırlık uygulamasının yapay zeka çalışma
koçusun (Anthropic'in Claude modeli tarafından çalıştırılıyorsun). Görevin
Türkiye'de KPSS'ye (Kamu Personeli Seçme Sınavı) hazırlanan bir öğrenciyle
Türkçe, doğal ve samimi bir dille sohbet etmek — önceden tanımlanmış sabit
kalıplara bağlı değilsin, tıpkı bir insan koç gibi serbestçe konuşabilir,
soruları yorumlayabilir, konu anlatabilir, motive edebilir ve sohbetin
akışını takip edebilirsin.

Öğrencinin GERÇEK güncel verileri (bunlara sadık kal, UYDURMA — bir veri
"bilinmiyor" ise öyle söyle, sayı uydurma):
{{CONTEXT}}

Nasıl davranmalısın:
- Kısa-orta uzunlukta, sohbet diline uygun yanıtlar ver (bu bir mobil sohbet
  kutusu — uzun makaleler yazma, ama soruyu tam ve yararlı şekilde yanıtla).
- Öğrencinin kendi performansıyla ilgili bir şey söylerken SADECE yukarıdaki
  gerçek verilere dayan; veri yoksa "henüz yeterli veri yok" de.
- KPSS içeriğiyle ilgili (Türkçe, Matematik, Tarih, Coğrafya, Vatandaşlık,
  Genel Kültür/Yetenek) soruları doğrudan, doğru ve öz biçimde yanıtlayabilirsin
  — sen artık gerçek bir dil modelisin, sabit bir soru-cevap veritabanı değil.
  Emin olmadığın (özellikle güncel mevzuat, sınav tarihi/başvuru gibi zamana
  bağlı) konularda kesin iddialarda bulunma, öğrenciye uygulamanın Sınav
  Takvimi/Haberler bölümünü veya ÖSYM'nin resmi kaynaklarını kontrol etmesini
  öner.
- Motivasyon, çalışma tekniği, zaman yönetimi gibi konularda sıcak ve
  destekleyici ol; asla küçümseyici veya suçlayıcı olma.
- Sen bir doktor, avukat veya finansal danışman değilsin — bu alanlarda genel
  bilgi verebilirsin ama kesin tavsiye yerine ilgili uzmana yönlendir.
- Bağlamla alakasız genel bir soru sorulursa (ör. genel kültür, günlük konu)
  yine de nazikçe ve doğal şekilde yanıtla — katı bir "sadece KPSS
  konuşabilirim" duvarı örme, tıpkı gerçek bir sohbet asistanı gibi davran.`;

function buildContext(homepage: any, weakStrong: any): string {
  const lines: string[] = [];
  if (homepage?.greeting_name) lines.push(`- Öğrencinin adı: ${homepage.greeting_name}`);
  if (homepage?.exam?.name) {
    lines.push(`- Hazırlandığı sınav: ${homepage.exam.name}`);
    if (typeof homepage.exam.days_left === "number") {
      lines.push(`- Sınava kalan gün: ${homepage.exam.days_left}`);
    }
  } else {
    lines.push("- Sınav tarihi henüz belirlenmemiş görünüyor.");
  }
  if (typeof homepage?.streak === "number") lines.push(`- Güncel çalışma serisi: ${homepage.streak} gün`);
  if (typeof homepage?.xp === "number") lines.push(`- XP: ${homepage.xp}, Seviye: ${homepage.level ?? 1}`);
  if (typeof homepage?.success_rate === "number") lines.push(`- Genel başarı oranı: %${Math.round(homepage.success_rate)}`);
  if (homepage?.today_status) {
    const { done = 0, total = 0 } = homepage.today_status;
    lines.push(`- Bugünkü program: ${done}/${total} görev tamamlandı`);
  }
  if (homepage?.today_priority?.has_priority) {
    lines.push(`- Bugünün öncelikli konusu: ${homepage.today_priority.subject_name} / ${homepage.today_priority.topic_name} (${homepage.today_priority.reason})`);
  }
  const weak = weakStrong?.weakest;
  const strong = weakStrong?.strongest;
  if (weak?.topic) lines.push(`- En zayıf konusu: ${weak.subject} / ${weak.topic} (bilgi skoru: ${weak.score ?? "bilinmiyor"})`);
  if (strong?.topic) lines.push(`- En güçlü konusu: ${strong.subject} / ${strong.topic} (bilgi skoru: ${strong.score ?? "bilinmiyor"})`);
  if (lines.length === 0) lines.push("- Henüz yeterli veri yok (öğrenci daha yeni başlamış olabilir).");
  return lines.join("\n");
}

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { headers: CORS_HEADERS });
  }
  if (req.method !== "POST") {
    return json({ error: "method_not_allowed" }, 405);
  }

  try {
    const anthropicKey = Deno.env.get("ANTHROPIC_API_KEY");
    const anthropicModel = Deno.env.get("ANTHROPIC_MODEL");
    if (!anthropicKey || !anthropicModel) {
      // Henüz kurulmadı — istemci (assistant.js) bunu görünce sessizce eski
      // kural tabanlı ai_assistant_ask RPC'sine geri döner.
      return json({ error: "llm_not_configured" }, 501);
    }

    const authHeader = req.headers.get("Authorization");
    if (!authHeader) return json({ error: "unauthorized" }, 401);

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const anonKey = Deno.env.get("SUPABASE_ANON_KEY")!;
    // Kullanıcının KENDİ JWT'siyle bir client — RLS/auth.uid() bu kullanıcıya
    // göre çalışır, böylece get_homepage()/get_ai_weak_strong_topics() SADECE
    // bu kullanıcının kendi verilerini döndürür (service_role KULLANMIYORUZ).
    const userClient = createClient(supabaseUrl, anonKey, {
      global: { headers: { Authorization: authHeader } },
    });

    const { data: userData, error: userErr } = await userClient.auth.getUser();
    if (userErr || !userData?.user) return json({ error: "unauthorized" }, 401);

    const body = await req.json().catch(() => ({}));
    const message = String(body?.message || "").trim().slice(0, 4000);
    if (!message) return json({ error: "empty_message" }, 400);
    const historyRaw = Array.isArray(body?.history) ? body.history : [];
    // Sadece son birkaç turu al — hem maliyeti hem gecikmeyi sınırlar.
    const history = historyRaw.slice(-16).filter((h: any) => h && (h.role === "user" || h.role === "assistant") && typeof h.text === "string");

    const [{ data: homepage }, { data: weakStrong }] = await Promise.all([
      userClient.rpc("get_homepage").then((r) => r).catch(() => ({ data: null })),
      userClient.rpc("get_ai_weak_strong_topics").then((r) => r).catch(() => ({ data: null })),
    ]);

    const systemPrompt = SYSTEM_PROMPT_TEMPLATE.replace("{{CONTEXT}}", buildContext(homepage, weakStrong));

    const anthropicMessages = [
      ...history.map((h: any) => ({ role: h.role, content: String(h.text).slice(0, 4000) })),
      { role: "user", content: message },
    ];

    const anthropicRes = await fetch("https://api.anthropic.com/v1/messages", {
      method: "POST",
      headers: {
        "content-type": "application/json",
        "x-api-key": anthropicKey,
        "anthropic-version": "2023-06-01",
      },
      body: JSON.stringify({
        model: anthropicModel,
        max_tokens: 800,
        system: systemPrompt,
        messages: anthropicMessages,
      }),
    });

    if (!anthropicRes.ok) {
      const errText = await anthropicRes.text().catch(() => "");
      console.error("Anthropic API error:", anthropicRes.status, errText);
      return json({ error: "llm_upstream_error" }, 502);
    }

    const anthropicData = await anthropicRes.json();
    const reply = (anthropicData?.content || [])
      .filter((block: any) => block?.type === "text")
      .map((block: any) => block.text)
      .join("\n")
      .trim();

    if (!reply) return json({ error: "empty_reply" }, 502);

    return json({ reply });
  } catch (e: any) {
    console.error("ai-chat unexpected error:", e);
    return json({ error: "internal_error" }, 500);
  }
});
