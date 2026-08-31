import { signOut } from "./auth.js";
import { icon } from "./icons.js";
import "./pwa.js"; // her mountNav() kullanan sayfada service worker'ı kaydet + yükleme banner'ını etkinleştir

// NOT: "Sorular" artık ayrı bir bölüm/sekme değil — her konunun içeriğiyle
// birlikte, konu sayfasının (topic.html) içine gömülü olarak sunuluyor.
// "Dersler"e girip bir konu seçtiğinde hem konu anlatımını hem de soru
// çözme bölümünü aynı sayfada bulursun.
//
// İkonlar artık emoji değil, "./icons.js" içindeki modern SVG çizgi ikon
// setinden isimle referans veriliyor (currentColor ile boyanıyor, böylece
// hover/active renk geçişlerini otomatik miras alıyor).
const LINKS = [
  { href: "dashboard.html", icon: "home", label: "Ana Sayfa" },
  { href: "subjects.html", icon: "book-open", label: "Dersler" },
  { href: "mistakes.html", icon: "x-circle", label: "Yanlışlarım" },
  { href: "news.html", icon: "newspaper", label: "Haberler" },
  { href: "exams.html", icon: "calendar", label: "Sınav Takvimi" },
  { href: "analytics.html", icon: "chart-bar", label: "Analiz" },
  { href: "notifications.html", icon: "bell", label: "Bildirimler" },
  { href: "assistant.html", icon: "sparkles", label: "AI Asistan" },
  { href: "profile.html", icon: "user", label: "Profil" },
];

// Mobil alt gezinme (4 ana sekme)
const BOTTOM_LINKS = [
  { href: "dashboard.html", icon: "home", label: "Ana Sayfa" },
  { href: "subjects.html", icon: "book-open", label: "Dersler" },
  { href: "exams.html", icon: "calendar", label: "Plan" },
  { href: "profile.html", icon: "user", label: "Profil" },
];

function mountAmbientBackground() {
  if (document.querySelector(".ambient-orbs")) return; // already mounted (or page navigated via bfcache)
  const layer = document.createElement("div");
  layer.className = "ambient-orbs";
  layer.setAttribute("aria-hidden", "true");
  layer.innerHTML = `
    <span class="ambient-orb ambient-orb-1"></span>
    <span class="ambient-orb ambient-orb-2"></span>
    <span class="ambient-orb ambient-orb-3"></span>`;
  document.body.prepend(layer);
}

export function mountNav(activeHref) {
  mountAmbientBackground();
  const sidebar = document.getElementById("sidebar");
  const bottomnav = document.getElementById("bottomnav");

  if (sidebar) {
    sidebar.innerHTML = `
      <div class="h-full flex flex-col">
        <div class="px-5 py-6 nav-brand">
          <div class="nav-brand-mark">${icon("target", { size: 20 })}</div>
          <div>
            <div class="font-extrabold text-base text-slate-900 leading-tight">KPSS Akıllı</div>
            <div class="text-[11px] font-semibold text-teal-400 uppercase tracking-wide">Öğrenci Platformu</div>
          </div>
        </div>
        <nav class="flex-1 px-3 space-y-1 overflow-y-auto">
          ${LINKS.map(l => `
            <a href="${l.href}" class="nav-link ${activeHref === l.href ? "active" : ""}">
              <span class="nav-icon-chip">${icon(l.icon, { size: 18 })}</span><span>${l.label}</span>
            </a>`).join("")}
        </nav>
        <div class="px-3 pb-5 pt-2 border-t border-slate-100 mt-2">
          <button id="sidebar-signout" type="button" class="nav-link w-full text-rose-500 hover:bg-rose-50 hover:text-rose-600">
            <span class="nav-icon-chip">${icon("logout", { size: 18 })}</span><span>Çıkış Yap</span>
          </button>
        </div>
      </div>`;
    document.getElementById("sidebar-signout")?.addEventListener("click", () => signOut());
  }

  if (bottomnav) {
    bottomnav.innerHTML = `
      <div class="grid grid-cols-4">
        ${BOTTOM_LINKS.map(l => `
          <a href="${l.href}" class="bottom-link ${activeHref === l.href ? "active" : ""}">
            <span class="bottom-icon">${icon(l.icon, { size: 21 })}</span><span>${l.label}</span>
          </a>`).join("")}
      </div>`;
  }
}
