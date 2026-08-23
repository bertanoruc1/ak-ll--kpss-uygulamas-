import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js";
import { toast, escapeHtml, fmtMinutes, scoreColor } from "./ui.js";

const auth = await requireAuth();
if (!auth) {
  throw new Error("not authenticated");
}

mountNav("analytics.html");

const contentEl = document.getElementById("content");
const emptyEl = document.getElementById("empty-state");
const errorEl = document.getElementById("error-state");

function statCard(icon, label, value) {
  return `
    <div class="card p-4">
      <div class="text-xl">${icon}</div>
      <p class="text-lg font-extrabold text-slate-900 mt-1 truncate">${value}</p>
      <p class="text-xs text-slate-500">${label}</p>
    </div>`;
}

function compareIndicator(current, previous, { higherIsBetter = true, isPercent = false } = {}) {
  const diff = (current ?? 0) - (previous ?? 0);
  if (diff === 0) return `<span class="text-xs font-medium text-slate-400">— değişim yok</span>`;
  const up = diff > 0;
  const good = higherIsBetter ? up : !up;
  const color = good ? "text-emerald-600" : "text-rose-600";
  const arrow = up ? "▲" : "▼";
  const amount = isPercent ? `%${Math.abs(Math.round(diff))}` : Math.abs(Math.round(diff));
  return `<span class="text-xs font-bold ${color}">${arrow} ${amount}</span>`;
}

function weekCompareRow(label, current, previous, opts) {
  return `
    <div class="flex items-center justify-between py-2.5 border-b border-slate-100 last:border-0">
      <span class="text-sm text-slate-500">${label}</span>
      <div class="flex items-center gap-2">
        <span class="text-xs text-slate-400">${previous}</span>
        <span class="text-xs text-slate-300">→</span>
        <span class="text-sm font-bold text-slate-900">${current}</span>
        ${compareIndicator(opts.currentRaw, opts.previousRaw, opts)}
      </div>
    </div>`;
}

function render(data) {
  const {
    total_questions = 0,
    success_rate = 0,
    best_subject = null,
    worst_subject = null,
    this_week = {},
    last_week = {},
    subject_breakdown = [],
  } = data || {};

  if (!total_questions || total_questions === 0) {
    contentEl.innerHTML = "";
    emptyEl.classList.remove("hidden");
    return;
  }
  emptyEl.classList.add("hidden");

  contentEl.innerHTML = `
    <div class="space-y-5 fadeIn">
      <!-- Genel istatistikler -->
      <div class="grid grid-cols-2 sm:grid-cols-4 gap-3">
        ${statCard("✏️", "Toplam Soru", total_questions)}
        ${statCard("📊", "Başarı Oranı", `%${Math.round(success_rate)}`)}
        ${statCard("🏆", "En İyi Ders", best_subject ? escapeHtml(best_subject) : "—")}
        ${statCard("📌", "Geliştirilmeli", worst_subject ? escapeHtml(worst_subject) : "—")}
      </div>

      <!-- Haftalık karşılaştırma -->
      <div class="card p-5">
        <p class="font-bold text-slate-900 mb-2">Bu Hafta vs Geçen Hafta</p>
        ${weekCompareRow("Çözülen Soru", this_week.questions ?? 0, last_week.questions ?? 0, { currentRaw: this_week.questions, previousRaw: last_week.questions, higherIsBetter: true })}
        ${weekCompareRow("Çalışma Süresi", fmtMinutes(this_week.minutes ?? 0), fmtMinutes(last_week.minutes ?? 0), { currentRaw: this_week.minutes, previousRaw: last_week.minutes, higherIsBetter: true })}
        ${weekCompareRow("Başarı Oranı", `%${Math.round(this_week.success ?? 0)}`, `%${Math.round(last_week.success ?? 0)}`, { currentRaw: this_week.success, previousRaw: last_week.success, higherIsBetter: true, isPercent: true })}
      </div>

      <!-- Ders bazlı kırılım -->
      <div class="card p-5">
        <p class="font-bold text-slate-900 mb-4">Ders Bazlı Performans</p>
        <div class="space-y-4">
          ${subject_breakdown.length === 0
            ? `<p class="text-sm text-slate-400">Henüz ders verisi yok.</p>`
            : subject_breakdown.map((s) => {
                const color = scoreColor(s.avg_score);
                return `
                  <div>
                    <div class="flex items-center justify-between mb-1.5">
                      <span class="text-sm font-semibold text-slate-700 flex items-center gap-1.5">
                        <span>${escapeHtml(s.icon || "📘")}</span>
                        <span>${escapeHtml(s.name)}</span>
                      </span>
                      <span class="text-xs text-slate-400">${s.topic_count ?? 0} konu · %${Math.round(s.avg_score ?? 0)}</span>
                    </div>
                    <div class="progress-track">
                      <div class="progress-fill" style="width:${Math.max(2, Math.round(s.avg_score ?? 0))}%; background:${color};"></div>
                    </div>
                  </div>`;
              }).join("")}
        </div>
      </div>
    </div>`;
}

async function loadAnalytics() {
  errorEl.classList.add("hidden");
  emptyEl.classList.add("hidden");

  const { data, error } = await supabase.rpc("get_analytics");
  if (error) {
    toast("Analiz verileri yüklenemedi.", "error");
    contentEl.innerHTML = "";
    errorEl.classList.remove("hidden");
    return;
  }
  render(data);
}

document.getElementById("retry-btn").addEventListener("click", loadAnalytics);

loadAnalytics();
