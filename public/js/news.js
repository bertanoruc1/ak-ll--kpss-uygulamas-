import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js";
import { toast, escapeHtml, timeAgo, fmtDateTime } from "./ui.js";
import { NEWS_CATEGORY_LABELS } from "./config.js";

// Kategori rozetleri için renk paleti (koyu metin / açık zemin eşleşmeleri)
const CATEGORY_COLORS = {
  osym: "bg-indigo-50 text-indigo-700",
  kpss: "bg-violet-50 text-violet-700",
  basvuru: "bg-sky-50 text-sky-700",
  sinav_takvimi: "bg-amber-50 text-amber-700",
  kilavuz: "bg-teal-50 text-teal-700",
  sonuc: "bg-emerald-50 text-emerald-700",
  tercih: "bg-fuchsia-50 text-fuchsia-700",
  yerlestirme: "bg-cyan-50 text-cyan-700",
  mufredat: "bg-orange-50 text-orange-700",
  ders: "bg-lime-50 text-lime-700",
  genel_egitim: "bg-slate-100 text-slate-700",
  onemli_duyuru: "bg-rose-50 text-rose-700",
};

let allNews = [];
let activeCategory = "all";

const listEl = document.getElementById("news-list");
const emptyEl = document.getElementById("empty-state");
const errorEl = document.getElementById("error-state");
const chipsEl = document.getElementById("category-chips");
const retryBtn = document.getElementById("retry-btn");

function renderChips() {
  const categoriesPresent = [...new Set(allNews.map((n) => n.category))];
  const chips = [
    { key: "all", label: "Tümü" },
    ...categoriesPresent
      .filter((c) => NEWS_CATEGORY_LABELS[c])
      .map((c) => ({ key: c, label: NEWS_CATEGORY_LABELS[c] })),
  ];

  chipsEl.innerHTML = chips
    .map((c) => {
      const isActive = c.key === activeCategory;
      return `
        <button
          data-category="${c.key}"
          class="chip-btn shrink-0 px-3.5 py-1.5 rounded-full text-sm font-semibold border transition ${
            isActive
              ? "bg-indigo-600 text-white border-indigo-600 shadow-sm"
              : "bg-white text-slate-600 border-slate-200 hover:bg-slate-50"
          }"
        >${escapeHtml(c.label)}</button>`;
    })
    .join("");

  chipsEl.querySelectorAll(".chip-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      activeCategory = btn.dataset.category;
      renderChips();
      renderList();
    });
  });
}

function sourceTrustBadge(trust) {
  if (trust === "resmi") {
    return `<span class="badge bg-emerald-50 text-emerald-700">✓ Resmi Kaynak</span>`;
  }
  if (trust === "destekleyici") {
    return `<span class="badge bg-slate-100 text-slate-600">Destekleyici Kaynak</span>`;
  }
  return "";
}

function newsCard(item) {
  const catColor = CATEGORY_COLORS[item.category] || "bg-slate-100 text-slate-700";
  const catLabel = NEWS_CATEGORY_LABELS[item.category] || item.category;
  const published = item.published_at || item.created_at;

  return `
    <article class="card p-5 fadeIn">
      <div class="flex flex-wrap items-center gap-2 mb-3">
        <span class="badge ${catColor}">${escapeHtml(catLabel)}</span>
        ${sourceTrustBadge(item.source_trust)}
        <span class="text-xs text-slate-400 ml-auto" title="${escapeHtml(fmtDateTime(published))}">${escapeHtml(timeAgo(published))}</span>
      </div>
      <h3 class="text-lg font-bold text-slate-900 leading-snug mb-1.5">${escapeHtml(item.title)}</h3>
      ${item.summary ? `<p class="text-sm text-slate-600 leading-relaxed mb-3">${escapeHtml(item.summary)}</p>` : ""}
      <div class="flex flex-wrap items-center justify-between gap-2 pt-3 border-t border-slate-100">
        <span class="text-xs font-medium text-slate-400">${escapeHtml(item.source || "Kaynak belirtilmemiş")}</span>
        ${
          item.source_url
            ? `<a href="${escapeHtml(item.source_url)}" target="_blank" rel="noopener" class="inline-flex items-center gap-1 text-sm font-semibold text-indigo-600 hover:text-indigo-700">Resmi kaynağı görüntüle →</a>`
            : ""
        }
      </div>
    </article>`;
}

function renderList() {
  const filtered =
    activeCategory === "all" ? allNews : allNews.filter((n) => n.category === activeCategory);

  if (allNews.length === 0) {
    listEl.innerHTML = "";
    listEl.classList.add("hidden");
    emptyEl.classList.remove("hidden");
    return;
  }

  emptyEl.classList.add("hidden");
  listEl.classList.remove("hidden");

  if (filtered.length === 0) {
    listEl.innerHTML = `
      <div class="card p-8 text-center">
        <div class="text-4xl mb-3">🔍</div>
        <p class="text-slate-600 font-medium">Bu kategoride haber bulunamadı.</p>
      </div>`;
    return;
  }

  listEl.innerHTML = filtered.map(newsCard).join("");
}

function showError() {
  listEl.classList.add("hidden");
  emptyEl.classList.add("hidden");
  errorEl.classList.remove("hidden");
}

function showSkeleton() {
  errorEl.classList.add("hidden");
  emptyEl.classList.add("hidden");
  listEl.classList.remove("hidden");
  listEl.innerHTML = `
    <div class="skeleton h-40 w-full"></div>
    <div class="skeleton h-40 w-full"></div>
    <div class="skeleton h-40 w-full"></div>`;
}

async function loadNews() {
  showSkeleton();
  chipsEl.innerHTML = "";
  errorEl.classList.add("hidden");

  const { data, error } = await supabase
    .from("news_items")
    .select("*")
    .eq("is_learning_content", false)
    .order("published_at", { ascending: false });

  if (error) {
    console.error(error);
    showError();
    toast("Haberler yüklenemedi.", "error");
    return;
  }

  allNews = data || [];
  activeCategory = "all";
  renderChips();
  renderList();
}

async function init() {
  const auth = await requireAuth();
  if (!auth) return;

  mountNav("news.html");
  await loadNews();
}

retryBtn?.addEventListener("click", loadNews);

init();
