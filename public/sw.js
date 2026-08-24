// KPSS Akıllı — Servis Çalışanı (Service Worker)
// TEK amacı: sekme kapalıyken/arka plandayken bile gerçek tarayıcı push
// bildirimlerini (görev hatırlatıcıları) alıp göstermek. Sayfa önbellekleme /
// offline modu YOK — sadece push + bildirim tıklaması.

self.addEventListener("install", (event) => {
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  event.waitUntil(self.clients.claim());
});

self.addEventListener("push", (event) => {
  let data = {};
  try {
    data = event.data ? event.data.json() : {};
  } catch (e) {
    data = { title: "KPSS Akıllı", body: event.data ? event.data.text() : "" };
  }

  const title = data.title || "⏰ KPSS Akıllı Hatırlatıcı";
  const options = {
    body: data.body || "Planladığın görevin zamanı geldi!",
    tag: data.tag || "kpss-reminder",
    renotify: true,
    data: { url: data.url || "/dashboard.html" },
  };

  event.waitUntil(self.registration.showNotification(title, options));
});

self.addEventListener("notificationclick", (event) => {
  event.notification.close();
  const targetUrl = event.notification.data?.url || "/dashboard.html";

  event.waitUntil(
    self.clients.matchAll({ type: "window", includeUncontrolled: true }).then((windowClients) => {
      for (const client of windowClients) {
        if (client.url.includes(self.location.origin) && "focus" in client) {
          client.navigate(targetUrl);
          return client.focus();
        }
      }
      if (self.clients.openWindow) {
        return self.clients.openWindow(targetUrl);
      }
    })
  );
});
