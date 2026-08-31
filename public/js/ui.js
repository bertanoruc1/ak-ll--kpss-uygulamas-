export function toast(message, type = "info") {
  const el = document.createElement("div");
  const colors = { success: "bg-emerald-600", error: "bg-rose-600", info: "bg-slate-800" };
  el.className = `fixed bottom-24 md:bottom-6 left-1/2 -translate-x-1/2 ${colors[type] || colors.info} text-white text-sm font-medium px-4 py-2.5 rounded-xl shadow-lg z-50 popIn`;
  el.textContent = message;
  document.body.appendChild(el);
  setTimeout(() => { el.style.opacity = "0"; el.style.transition = "opacity .3s"; setTimeout(() => el.remove(), 300); }, 2500);
}

export function escapeHtml(str) {
  if (str == null) return "";
  return String(str).replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
}

// escapeHtml() metindeki &<>"' karakterlerini kodluyor ama bir URL'nin
// ŞEMASINI (javascript:, data:, vbs: vb.) doğrulamıyor — bir href'e
// escapeHtml(url) yazmak, url "javascript:..." ile başlıyorsa yine de
// tıklanınca kod çalıştırır. safeUrl(), yalnızca http(s) ile başlayan (veya
// şema belirtmeyen göreli) adreslere izin verir, aksi halde zararsız "#"
// döner. Veritabanından gelen (news_items/topic_contents/questions gibi,
// şu an sadece admin tarafından yazılabilen ama gelecekte güven sınırı
// değişebilecek) her url alanı href'e yazılmadan önce bundan geçirilmeli.
export function safeUrl(url) {
  if (!url) return "#";
  const trimmed = String(url).trim();
  if (/^\s*(javascript|data|vbscript|file):/i.test(trimmed)) return "#"; // tehlikeli şemalar
  if (/^https?:\/\//i.test(trimmed)) return escapeHtml(trimmed); // http(s)
  if (/^\/\//.test(trimmed)) return escapeHtml(trimmed); // protokolsüz (//ornek.com)
  if (/^[a-z][a-z0-9+.-]*:/i.test(trimmed)) return "#"; // tanınmayan başka bir şema -> reddet
  return escapeHtml(trimmed); // göreli yol (ör. /topic.html?id=...)
}

export function fmtMinutes(min) {
  if (min == null) return "0dk";
  const h = Math.floor(min / 60), m = min % 60;
  return h > 0 ? `${h}sa ${m}dk` : `${m}dk`;
}

export function fmtDate(d) {
  if (!d) return "—";
  return new Date(d).toLocaleDateString("tr-TR", { day: "numeric", month: "long", year: "numeric" });
}

export function fmtDateTime(d) {
  if (!d) return "—";
  return new Date(d).toLocaleString("tr-TR", { day: "numeric", month: "short", hour: "2-digit", minute: "2-digit" });
}

export function timeAgo(d) {
  const diff = (Date.now() - new Date(d).getTime()) / 1000;
  if (diff < 60) return "az önce";
  if (diff < 3600) return `${Math.floor(diff / 60)} dk önce`;
  if (diff < 86400) return `${Math.floor(diff / 3600)} saat önce`;
  return `${Math.floor(diff / 86400)} gün önce`;
}

export const LEVEL_LABELS = { baslangic: "Başlangıç", gelistirilmeli: "Geliştirilmeli", orta: "Orta", iyi: "İyi", cok_iyi: "Çok İyi" };
export const LEVEL_COLORS = { baslangic: "#dc2626", gelistirilmeli: "#f97316", orta: "#d97706", iyi: "#059669", cok_iyi: "#16a34a" };
export const DIFFICULTY_LABELS = { kolay: "Kolay", orta: "Orta", zor: "Zor" };
export const DIFFICULTY_COLORS = { kolay: "#059669", orta: "#d97706", zor: "#dc2626" };
export const SESSION_TYPE_LABELS = { konu_ogrenme: "Konu Öğrenme", soru_cozme: "Soru Çözme", tekrar: "Tekrar", mola: "Mola" };
// Değerler artık emoji değil, js/icons.js'teki modern SVG ikon setinin isimleri
// (kullanım yerinde icon(SESSION_TYPE_ICONS[type]) ile render edilir).
export const SESSION_TYPE_ICONS = { konu_ogrenme: "book-open-alt", soru_cozme: "pencil", tekrar: "arrow-path", mola: "coffee" };

export function scoreColor(score) {
  if (score == null) return "#94a3b8";
  if (score <= 20) return LEVEL_COLORS.baslangic;
  if (score <= 40) return LEVEL_COLORS.gelistirilmeli;
  if (score <= 60) return LEVEL_COLORS.orta;
  if (score <= 80) return LEVEL_COLORS.iyi;
  return LEVEL_COLORS.cok_iyi;
}

// Animates a number counting up from 0 (or its current value) to `target`.
// Pass a formatter (e.g. v => `%${v}`) to render the value each frame.
export function countUp(el, target, { duration = 900, formatter = (v) => String(v), prefix = "", suffix = "" } = {}) {
  if (!el) return;
  const t = Number(target) || 0;
  if (window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
    el.textContent = `${prefix}${formatter(t)}${suffix}`;
    return;
  }
  const start = performance.now();
  const from = 0;
  function tick(now) {
    const elapsed = Math.min(1, (now - start) / duration);
    const eased = 1 - Math.pow(1 - elapsed, 3); // ease-out cubic
    const current = Math.round(from + (t - from) * eased);
    el.textContent = `${prefix}${formatter(current)}${suffix}`;
    if (elapsed < 1) {
      requestAnimationFrame(tick);
    } else {
      el.classList.add("count-up-flash");
      setTimeout(() => el.classList.remove("count-up-flash"), 650);
    }
  }
  requestAnimationFrame(tick);
}

export function renderMarkdown(md) {
  if (!md) return "";
  let html = escapeHtml(md);
  html = html.replace(/^## (.*)$/gm, "<h3 class='font-bold text-lg mt-4 mb-2'>$1</h3>");
  html = html.replace(/^# (.*)$/gm, "<h2 class='font-extrabold text-xl mt-4 mb-2'>$1</h2>");
  html = html.replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>");
  html = html.replace(/^- (.*)$/gm, "<li class='ml-4 list-disc'>$1</li>");
  html = html.replace(/(<li[\s\S]*?<\/li>)(\n(?!<li))/g, "$1</ul>\n").replace(/(<li)/, "<ul class='space-y-1 my-2'>$1");
  html = html.split("\n\n").map(p => p.startsWith("<h") || p.startsWith("<ul") ? p : `<p class="mb-2 leading-relaxed">${p}</p>`).join("\n");
  return html;
}
