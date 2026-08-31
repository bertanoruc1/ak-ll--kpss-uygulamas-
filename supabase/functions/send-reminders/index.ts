// send-reminders — her dakika pg_cron ile tetiklenir (bkz.
// supabase/migrations/20240601000290_manual_tasks_push_and_ai_upgrade.sql
// dosyasının sonundaki cron.schedule bloğu).
//
// Akış:
//   1) claim_due_reminders() RPC'sini service_role ile çağırır — bu, vadesi
//      (planlanan başlangıç saati) son 1-3 dakika içinde geçmiş, henüz
//      hatırlatılmamış görevleri bulur, ATOMİK olarak reminder_sent=true
//      işaretler (tekrar gönderilmesin diye) ve alıcının push abonelik
//      bilgileriyle birlikte döner.
//   2) Her abonelik için gerçek bir Web Push bildirimi gönderir (VAPID).
//   3) Aynı zamanda uygulama içi bir bildirim de ekler (notify_user ile) —
//      böylece push izni vermemiş/almamış kullanıcılar da 🔔 Bildirimler
//      sayfasında görevi görebilir.
//   4) 404/410 (abonelik artık geçersiz) dönen push hedeflerini veritabanından siler.
//
// Deploy:
//   supabase functions deploy send-reminders
//   supabase secrets set VAPID_PUBLIC_KEY=... VAPID_PRIVATE_KEY=... VAPID_SUBJECT=mailto:...
//   supabase secrets set CRON_SECRET=...
// (Tam talimat: bkz. bu klasördeki README.md)
//
// GÜVENLİK (2026-08-30 denetiminde eklendi): Bu fonksiyon yalnızca pg_cron
// tarafından tetiklenmesi gereken, hiçbir kullanıcı arayüzünden çağrılmayan
// bir arka plan işidir. Daha önce hiçbir çağıran-doğrulaması yoktu — Supabase
// platformunun varsayılan JWT doğrulaması yalnızca "geçerli BİR Supabase JWT'si
// mi" diye bakar, herkese açık anon key de geçerli bir JWT'dir; yani pratikte
// İNTERNETTEKİ HERKES bu fonksiyonu doğrudan çağırıp service_role yetkisiyle
// push bildirimi gönderilmesini tetikleyebiliyordu. Şimdi, cron job'ının
// gönderdiği `x-cron-secret` header'ının `CRON_SECRET` ortam değişkenine eşit
// olması zorunlu; eşleşmezse 401 döner.
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";
import webpush from "npm:web-push@3.6.7";

const SESSION_TYPE_LABELS: Record<string, string> = {
  konu_ogrenme: "Konu Çalışma",
  soru_cozme: "Soru Çözme",
  tekrar: "Tekrar",
  mola: "Mola",
};

Deno.serve(async (req: Request) => {
  try {
    const cronSecret = Deno.env.get("CRON_SECRET");
    const providedSecret = req.headers.get("x-cron-secret");
    if (!cronSecret || providedSecret !== cronSecret) {
      return new Response(JSON.stringify({ error: "unauthorized" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const vapidPublic = Deno.env.get("VAPID_PUBLIC_KEY");
    const vapidPrivate = Deno.env.get("VAPID_PRIVATE_KEY");
    const vapidSubject = Deno.env.get("VAPID_SUBJECT") || "mailto:destek@example.com";

    const supabase = createClient(supabaseUrl, serviceKey);

    const { data: due, error: dueError } = await supabase.rpc("claim_due_reminders");
    if (dueError) {
      console.error("claim_due_reminders failed:", dueError);
      return new Response(JSON.stringify({ error: dueError.message }), { status: 500 });
    }

    const rows = (due || []) as any[];
    if (rows.length === 0) {
      return new Response(JSON.stringify({ ok: true, sent: 0 }), { status: 200 });
    }

    if (vapidPublic && vapidPrivate) {
      webpush.setVapidDetails(vapidSubject, vapidPublic, vapidPrivate);
    }

    let sent = 0;
    let inAppOnly = 0;
    const expiredEndpoints: string[] = [];

    for (const row of rows) {
      const typeLabel = SESSION_TYPE_LABELS[row.r_session_type] || row.r_session_type;
      const what = row.r_topic_name
        ? `${row.r_subject_name ? row.r_subject_name + " · " : ""}${row.r_topic_name}`
        : row.r_subject_name || "Planladığın görev";
      const title = `⏰ ${typeLabel} zamanı!`;
      const body = `${what} için ayırdığın saat geldi. Şimdi başlayabilirsin.`;

      // Uygulama içi bildirim (push izni olmasa bile herkes görsün diye).
      const { error: notifyError } = await supabase.rpc("notify_user", {
        p_user_id: row.r_user_id,
        p_event_type: "STUDY_TIME",
        p_priority: "onemli",
        p_title: title,
        p_body: body,
        p_related_id: row.r_session_id,
      });
      if (notifyError) console.error("notify_user failed:", notifyError);

      if (row.r_endpoint && vapidPublic && vapidPrivate) {
        try {
          await webpush.sendNotification(
            {
              endpoint: row.r_endpoint,
              keys: { p256dh: row.r_p256dh, auth: row.r_auth_key },
            },
            JSON.stringify({ title, body, url: "/dashboard.html", tag: `session-${row.r_session_id}` })
          );
          sent++;
        } catch (pushErr: any) {
          const status = pushErr?.statusCode;
          if (status === 404 || status === 410) {
            expiredEndpoints.push(row.r_endpoint);
          } else {
            console.error("web-push send failed:", pushErr?.message || pushErr);
          }
        }
      } else {
        inAppOnly++;
      }
    }

    if (expiredEndpoints.length > 0) {
      await supabase.from("push_subscriptions").delete().in("endpoint", expiredEndpoints);
    }

    return new Response(
      JSON.stringify({ ok: true, claimed: rows.length, push_sent: sent, in_app_only: inAppOnly, expired_removed: expiredEndpoints.length }),
      { status: 200 }
    );
  } catch (e: any) {
    console.error("send-reminders unexpected error:", e);
    return new Response(JSON.stringify({ error: String(e?.message || e) }), { status: 500 });
  }
});
