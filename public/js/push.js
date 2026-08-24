import { supabase } from "./supabaseClient.js";
import { VAPID_PUBLIC_KEY } from "./config.js";

// Gerçek tarayıcı push bildirimleri (hatırlatıcılar) için abonelik yönetimi.
// "+ Görev Ekle" ile manuel bir görev oluşturulduğunda çağrılır — kullanıcıdan
// bildirim izni ister (daha önce verilmediyse) ve aboneliği veritabanına kaydeder.
// send-reminders adlı Edge Function, pg_cron ile her dakika vadesi gelen
// görevleri bulup bu abonelikler üzerinden gerçek push bildirimi gönderir.

function urlBase64ToUint8Array(base64String) {
  const padding = "=".repeat((4 - (base64String.length % 4)) % 4);
  const base64 = (base64String + padding).replace(/-/g, "+").replace(/_/g, "/");
  const rawData = atob(base64);
  const outputArray = new Uint8Array(rawData.length);
  for (let i = 0; i < rawData.length; i++) {
    outputArray[i] = rawData.charCodeAt(i);
  }
  return outputArray;
}

export function isPushSupported() {
  return "serviceWorker" in navigator && "PushManager" in window && "Notification" in window;
}

// Kullanıcıya bildirim izni sorar (daha önce sorulmadıysa) ve aboneliği
// kaydeder. Başarılıysa true döner; tarayıcı desteklemiyorsa ya da kullanıcı
// izin vermezse false döner (çağıran taraf bunu sessizce yutabilir — manuel
// görev yine de oluşturulmuş olur, sadece hatırlatıcı gönderilemez).
export async function ensurePushSubscription() {
  if (!isPushSupported()) return false;

  try {
    const reg = await navigator.serviceWorker.register("/sw.js");
    await navigator.serviceWorker.ready;

    let permission = Notification.permission;
    if (permission === "default") {
      permission = await Notification.requestPermission();
    }
    if (permission !== "granted") return false;

    let sub = await reg.pushManager.getSubscription();
    if (!sub) {
      sub = await reg.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: urlBase64ToUint8Array(VAPID_PUBLIC_KEY),
      });
    }

    const json = sub.toJSON();
    const { error } = await supabase.rpc("save_push_subscription", {
      p_endpoint: json.endpoint,
      p_p256dh: json.keys?.p256dh,
      p_auth: json.keys?.auth,
    });
    if (error) {
      console.error("save_push_subscription failed:", error);
      return false;
    }
    return true;
  } catch (e) {
    console.error("Push aboneliği kurulamadı:", e);
    return false;
  }
}
