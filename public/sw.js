// KPSS Akıllı — Servis Çalışanı (Service Worker)
// İki işi var: (1) sekme kapalıyken/arka plandayken bile gerçek tarayıcı push
// bildirimlerini (görev hatırlatıcıları) almak/göstermek — bu kısım hiç
// değişmedi; (2) PWA'nın (manifest.json ile birlikte) "yüklenebilir" olması
// ve temel bir offline dayanıklılık sağlaması için hafif bir önbellekleme.
//
// Önbellekleme stratejisi bilinçli olarak basit tutuldu: Supabase'e bağlı
// dinamik sayfa içeriğini (ders/soru verisi vb.) ÖNBELLEKLEMİYORUZ — bu,
// bayat verinin kullanıcıya gösterilmesi gibi zor hatalara yol açar. Sadece
// statik dosyalar (CSS/JS/ikonlar) cache-first, sayfa gezinmeleri
// (navigation) ise network-first + offline'da son başarılı sürüme dönüş.
// ÖNEMLİ: Statik dosyalarda (CSS/JS) her deploy sonrası CACHE_NAME'i
// artır (v2, v3, ...) — aksi halde eski sürümler bazı kullanıcılarda
// (özellikle background-fetch tamamlanana kadar) bir süre önbellekten
// sunulmaya devam edebilir. activate handler'ı eski isimli cache'i zaten
// otomatik siliyor, sadece bu sabiti güncellemek yeterli.
const CACHE_NAME = "kpss-akilli-shell-v2";
const STATIC_EXTENSIONS = [".css", ".js", ".png", ".svg", ".woff", ".woff2"];

self.addEventListener("install", (event) => {
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    Promise.all([
      self.clients.claim(),
      caches.keys().then((keys) =>
        Promise.all(keys.filter((k) => k !== CACHE_NAME).map((k) => caches.delete(k)))
      ),
    ])
  );
});

self.addEventListener("fetch", (event) => {
  const req = event.request;
  if (req.method !== "GET") return;
  const url = new URL(req.url);
  if (url.origin !== self.location.origin) return; // Supabase/CDN isteklerine dokunma

  // Sayfa gezinmeleri (ör. bir linke tıklama, doğrudan URL açma): önce ağı
  // dene (her zaman en güncel HTML'i göster), sadece tamamen offline'sa
  // önbellekten (varsa) dön.
  if (req.mode === "navigate") {
    event.respondWith(
      fetch(req)
        .then((res) => {
          const copy = res.clone();
          caches.open(CACHE_NAME).then((c) => c.put(req, copy));
          return res;
        })
        .catch(() => caches.match(req).then((cached) => cached || caches.match("/dashboard.html")))
    );
    return;
  }

  // Statik dosyalar: önce önbellek (hızlı + offline'da da çalışır), arka
  // planda ağdan tazele.
  if (STATIC_EXTENSIONS.some((ext) => url.pathname.endsWith(ext))) {
    event.respondWith(
      caches.match(req).then((cached) => {
        const network = fetch(req)
          .then((res) => {
            const copy = res.clone();
            caches.open(CACHE_NAME).then((c) => c.put(req, copy));
            return res;
          })
          .catch(() => cached);
        return cached || network;
      })
    );
  }
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
