// PWA desteği: (1) service worker'ı her sayfada kayıt eder — bu, hem push
// bildirimlerinin (bkz. push.js) önceden hazır olmasını sağlar hem de
// tarayıcının "yüklenebilir" (installable) saymasının ön şartıdır; (2)
// tarayıcı "beforeinstallprompt" olayını tetiklediğinde ("Ana Ekrana Ekle"
// için hazır) sayfanın üstünde ince, kapatılabilir bir "Uygulamayı Yükle"
// çubuğu gösterir — tarayıcının kendi kurulum arayüzü genelde adres
// çubuğunun taşma menüsünde gizli kalıp fark edilmiyor.
//
// Bu modül import edildiği HER sayfada otomatik çalışır (yan etkili import) —
// bkz. nav.js (mountNav'ı çağıran tüm sayfalar) ve nav.js kullanmayan
// login/register/onboarding/index/admin sayfalarındaki ayrı import'lar.

const INSTALL_DISMISS_KEY = "kpss_install_dismissed_at";
const DISMISS_SNOOZE_MS = 7 * 24 * 60 * 60 * 1000; // 7 gün

function registerServiceWorker() {
  if (!("serviceWorker" in navigator)) return;
  window.addEventListener("load", () => {
    navigator.serviceWorker.register("/sw.js").catch(() => {
      // Sessizce yut: SW kaydı başarısız olsa bile uygulama normal bir web
      // sayfası olarak çalışmaya devam eder, sadece PWA/push avantajları
      // olmaz.
    });
  });
}

function alreadyInstalled() {
  // Standalone modda açılmışsa (yani zaten yüklenmiş app olarak çalışıyorsa)
  // banner'ın hiç anlamı yok.
  return window.matchMedia("(display-mode: standalone)").matches || window.navigator.standalone === true;
}

function recentlyDismissed() {
  const raw = localStorage.getItem(INSTALL_DISMISS_KEY);
  if (!raw) return false;
  const dismissedAt = Number(raw);
  return Number.isFinite(dismissedAt) && Date.now() - dismissedAt < DISMISS_SNOOZE_MS;
}

function showInstallBanner(deferredPrompt) {
  if (document.getElementById("pwa-install-banner")) return;

  const bar = document.createElement("div");
  bar.id = "pwa-install-banner";
  bar.style.cssText = [
    "position:fixed", "top:0", "left:0", "right:0", "z-index:60",
    "display:flex", "align-items:center", "gap:10px",
    "padding:10px 14px",
    "background:linear-gradient(135deg,#0f766e,#0ea5e9 55%,#22d3ee)",
    "color:#fff", "font-family:inherit", "font-size:13px", "font-weight:600",
    "box-shadow:0 4px 14px rgba(15,118,110,.35)",
  ].join(";");
  bar.innerHTML = `
    <span style="flex:1;min-width:0;">KPSS Akıllı'yı telefonuna yükle, daha hızlı aç.</span>
    <button id="pwa-install-btn" style="flex-shrink:0;background:rgba(255,255,255,.95);color:#0f766e;border:none;border-radius:8px;padding:6px 12px;font-weight:700;font-size:12px;cursor:pointer;">Yükle</button>
    <button id="pwa-install-dismiss" aria-label="Kapat" style="flex-shrink:0;background:transparent;border:none;color:#fff;font-size:18px;line-height:1;cursor:pointer;padding:0 2px;">×</button>
  `;
  document.body.prepend(bar);

  document.getElementById("pwa-install-btn").addEventListener("click", async () => {
    bar.remove();
    deferredPrompt.prompt();
    await deferredPrompt.userChoice.catch(() => {});
  });
  document.getElementById("pwa-install-dismiss").addEventListener("click", () => {
    localStorage.setItem(INSTALL_DISMISS_KEY, String(Date.now()));
    bar.remove();
  });
}

function initInstallPrompt() {
  if (alreadyInstalled()) return;
  window.addEventListener("beforeinstallprompt", (event) => {
    event.preventDefault();
    if (recentlyDismissed()) return;
    showInstallBanner(event);
  });
  window.addEventListener("appinstalled", () => {
    document.getElementById("pwa-install-banner")?.remove();
  });
}

registerServiceWorker();
initInstallPrompt();
