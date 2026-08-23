import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js";
import { toast, escapeHtml, fmtDate, SESSION_TYPE_LABELS, SESSION_TYPE_ICONS, scoreColor } from "./ui.js";
import { NEWS_CATEGORY_LABELS } from "./config.js";

const auth = await requireAuth();
if (!auth) {
  // requireAuth already redirected.
  throw new Error("not authenticated");
}

mountNav("dashboard.html");

const DAY_LABELS = ["Paz", "Pzt", "Sal", "Çar", "Per", "Cum", "Cmt"];

function timeOfDayGreeting() {
  const h = new Date().getHours();
  if (h < 6) return "İyi geceler";
  if (h < 12) return "Günaydın";
  if (h < 18) return "İyi günler";
  if (h < 23) return "İyi akşamlar";
  return "İyi geceler";
}

function shortTime(t) {
  if (!t) return "";
  if (t.includes("T")) {
    return new Date(t).toLocaleTimeString("tr-TR", { hour: "2-digit", minute: "2-digit" });
  }
  return t.slice(0, 5);
}

function sessionLink(session) {
  const type = session.session_type;
  const topicId = session.topic_id;
  if (type === "soru_cozme") return `practice.html?topic=${topicId}`;
  if (type === "konu_ogrenme") return `topic.html?id=${topicId}`;
  if (type === "tekrar") return `topic.html?id=${topicId}&review=1`;
  return "#";
}

const STATUS_LABELS = { planned: "Planlandı", done: "Tamamlandı", skipped: "Atlandı" };
const STATUS_CLASSES = {
  planned: "bg-indigo-50 text-indigo-700",
  done: "bg-emerald-50 text-emerald-700",
  skipped: "bg-slate-100 text-slate-500",
};

function renderGreeting(data) {
  const box = document.getElementById("greeting-box");
  box.innerHTML = `
    <h1 class="text-2xl font-extrabold text-slate-900">Merhaba, ${escapeHtml(data.greeting_name || "Öğrenci")}!</h1>
    <p class="text-sm text-slate-500 mt-0.5">${timeOfDayGreeting()}, bugün seni bekleyenlere göz at.</p>
    <div class="flex items-center gap-2 mt-2.5">
      <span class="badge bg-orange-50 text-orange-700">🔥 ${data.streak ?? 0} gün seri</span>
      <span class="badge badge-gold">✨ ${data.xp ?? 0} XP</span>
      <span class="badge bg-indigo-50 text-indigo-700">🏅 Seviye ${data.level ?? 1}</span>
    </div>
  `;

  const notifBadge = document.getElementById("notif-badge");
  const unread = data.unread_notifications || 0;
  if (unread > 0) {
    notifBadge.textContent = unread > 99 ? "99+" : String(unread);
    notifBadge.classList.remove("hidden");
  }
}

function renderExamCountdown(data) {
  const el = document.getElementById("exam-countdown");
  const exam = data.exam;
  if (!exam) {
    el.innerHTML = `
      <div class="card p-6 text-center">
        <div class="text-3xl mb-2">📅</div>
        <p class="font-semibold text-slate-700">Sınav takvimi henüz belirlenmedi</p>
        <p class="text-sm text-slate-400 mt-1">Sınav tarihini belirlemek için sınav takvimini incele.</p>
        <a href="exams.html" class="btn-secondary inline-block mt-4 px-4 py-2 text-sm">Sınav Takvimine Git</a>
      </div>`;
    return;
  }
  el.innerHTML = `
    <div class="rounded-2xl p-6 text-white relative overflow-hidden" style="background: linear-gradient(135deg, #4338ca, #7c3aed 55%, #a855f7); box-shadow: 0 20px 44px -12px rgba(76,29,149,.45);">
      <div class="absolute inset-0" style="background: radial-gradient(220px 160px at 100% 0%, rgba(255,255,255,.14), transparent 70%);"></div>
      <div class="relative z-10">
        <p class="text-sm font-medium text-indigo-100 tracking-wide">${escapeHtml(exam.name)}</p>
        <div class="flex items-end gap-2 mt-1">
          <span class="text-5xl font-extrabold leading-none">${exam.days_left}</span>
          <span class="text-lg font-semibold mb-1">gün kaldı</span>
        </div>
        <p class="text-sm text-indigo-100 mt-2">${fmtDate(exam.exam_date)}</p>
      </div>
      <div class="absolute -right-6 -bottom-6 text-8xl opacity-20">🎯</div>
    </div>`;
}

function renderTopNews(data) {
  const el = document.getElementById("top-news");
  const news = data.top_news;
  if (!news) { el.innerHTML = ""; return; }
  const summary = news.summary ? escapeHtml(news.summary).slice(0, 140) + (news.summary.length > 140 ? "…" : "") : "";
  const categoryLabel = NEWS_CATEGORY_LABELS[news.category] || news.category || "";
  el.innerHTML = `
    <div class="card p-4 fadeIn">
      <div class="flex items-start justify-between gap-2">
        <span class="badge bg-indigo-50 text-indigo-700">${escapeHtml(categoryLabel)}</span>
        <a href="news.html" class="text-xs font-semibold text-indigo-600 hover:underline shrink-0">Tümünü Gör →</a>
      </div>
      <p class="font-bold text-slate-900 mt-2">${escapeHtml(news.title)}</p>
      ${summary ? `<p class="text-sm text-slate-500 mt-1">${summary}</p>` : ""}
      ${news.source ? `<p class="text-xs text-slate-400 mt-2">Kaynak: ${escapeHtml(news.source)}</p>` : ""}
    </div>`;
}

function renderTodayStatus(data) {
  const el = document.getElementById("today-status");
  const { done = 0, total = 0 } = data.today_status || {};
  const pct = total > 0 ? Math.round((done / total) * 100) : 0;
  el.innerHTML = `
    <div class="card p-5">
      <div class="flex items-center justify-between mb-2">
        <p class="font-bold text-slate-900">Bugün ${done}/${total} tamamlandı</p>
        <span class="text-sm font-semibold text-indigo-600">%${pct}</span>
      </div>
      <div class="progress-track">
        <div class="progress-fill" style="width:${pct}%; background: linear-gradient(90deg, #6366f1, #7c3aed);"></div>
      </div>
    </div>`;
}

function renderTodayPriority(data) {
  const el = document.getElementById("today-priority");
  const p = data.today_priority;
  if (!p || !p.has_priority) {
    el.innerHTML = `
      <div class="priority-card rounded-2xl p-6">
        <div class="text-3xl mb-2">🎯</div>
        <p class="font-bold text-slate-800">Henüz yeterli veri yok, birkaç soru çöz.</p>
        <a href="subjects.html" class="btn-primary inline-block mt-4 px-5 py-2.5 text-sm">Derslere Git →</a>
      </div>`;
    return;
  }
  el.innerHTML = `
    <div class="priority-card rounded-2xl p-6">
      <div class="flex items-center gap-2 mb-2">
        <span class="text-2xl">⭐</span>
        <span class="badge bg-white text-indigo-700 border border-indigo-100">Bugünün Önceliği</span>
      </div>
      <p class="text-xs font-semibold text-indigo-500 uppercase tracking-wide">${escapeHtml(p.subject_name || "")} · ${escapeHtml(p.topic_name || "")}</p>
      <p class="font-bold text-lg text-slate-900 mt-1 leading-snug">${escapeHtml(p.reason)}</p>
      <a href="practice.html?topic=${p.topic_id}" class="btn-primary inline-block mt-4 px-5 py-2.5 text-sm">Şimdi Çalış →</a>
    </div>`;
}

async function handleGeneratePlan(btn) {
  btn.disabled = true;
  btn.textContent = "Oluşturuluyor...";
  const { error } = await supabase.rpc("generate_study_plan", {});
  if (error) {
    toast(error.message || "Plan oluşturulamadı.", "error");
    btn.disabled = false;
    btn.textContent = "Bugünkü Planı Oluştur";
    return;
  }
  toast("Plan oluşturuldu!", "success");
  window.location.reload();
}

function renderScheduleTimeline(data) {
  const el = document.getElementById("schedule-timeline");
  const sessions = data.today_sessions || [];

  if (sessions.length === 0) {
    el.innerHTML = `
      <div class="card p-6 text-center">
        <div class="text-3xl mb-2">🗓️</div>
        <p class="font-semibold text-slate-700">Bugün için henüz bir plan yok.</p>
        <p class="text-sm text-slate-400 mt-1">Hemen bir çalışma planı oluşturalım.</p>
        <button id="generate-plan-btn" class="btn-primary inline-block mt-4 px-5 py-2.5 text-sm">Bugünkü Planı Oluştur</button>
      </div>`;
    document.getElementById("generate-plan-btn").addEventListener("click", (e) => handleGeneratePlan(e.currentTarget));
    return;
  }

  el.innerHTML = `
    <div class="card p-5">
      <p class="font-bold text-slate-900 mb-4">Bugünün Programı</p>
      <div class="space-y-0">
        ${sessions.map((s, i) => `
          <div class="flex gap-3 relative">
            <div class="flex flex-col items-center">
              <div class="w-3 h-3 rounded-full mt-1.5 shrink-0" style="background: ${s.status === "done" ? "#10b981" : s.status === "skipped" ? "#cbd5e1" : "#6366f1"};"></div>
              ${i < sessions.length - 1 ? '<div class="w-px flex-1 bg-slate-200 my-0.5"></div>' : ""}
            </div>
            <a href="${sessionLink(s)}" class="flex-1 pb-4 group">
              <div class="rounded-xl border border-slate-100 group-hover:border-indigo-200 group-hover:bg-indigo-50/40 transition p-3">
                <div class="flex items-start justify-between gap-2">
                  <div class="flex items-center gap-2 min-w-0">
                    <span class="text-lg shrink-0">${SESSION_TYPE_ICONS[s.session_type] || "📌"}</span>
                    <div class="min-w-0">
                      <p class="text-xs font-semibold text-slate-400">${SESSION_TYPE_LABELS[s.session_type] || s.session_type}</p>
                      <p class="text-sm font-bold text-slate-900 truncate">
                        ${s.subject_icon ? escapeHtml(s.subject_icon) + " " : ""}${escapeHtml(s.subject_name || "")}${s.topic_name ? " · " + escapeHtml(s.topic_name) : ""}
                      </p>
                    </div>
                  </div>
                  <span class="badge ${STATUS_CLASSES[s.status] || "bg-slate-100 text-slate-500"} shrink-0">${STATUS_LABELS[s.status] || s.status}</span>
                </div>
                <div class="flex items-center gap-3 mt-2 text-xs text-slate-500">
                  <span>⏰ ${shortTime(s.planned_start)}${s.planned_end ? "–" + shortTime(s.planned_end) : ""}</span>
                  ${s.duration_minutes ? `<span>⏱ ${s.duration_minutes} dk</span>` : ""}
                  ${s.question_target ? `<span>🎯 ${s.question_target} soru</span>` : ""}
                </div>
              </div>
            </a>
          </div>
        `).join("")}
      </div>
    </div>`;
}

function renderSuccessRate(data) {
  const el = document.getElementById("success-rate");
  const rate = data.success_rate ?? 0;
  el.innerHTML = `
    <div class="card p-5 flex items-center justify-between">
      <div>
        <p class="text-sm font-semibold text-slate-500">Genel Başarı Oranı</p>
        <p class="text-4xl font-extrabold mt-1" style="color: ${scoreColor(rate)};">%${Math.round(rate)}</p>
      </div>
      <div class="text-4xl">📊</div>
    </div>`;
}

function renderWeeklyProgress(data) {
  const el = document.getElementById("weekly-progress");
  const weekly = data.weekly_progress || [];
  const maxMinutes = Math.max(1, ...weekly.map(d => d.minutes || 0));

  el.innerHTML = `
    <div class="card p-5">
      <p class="font-bold text-slate-900 mb-4">Haftalık İlerleme</p>
      <div class="flex items-end justify-between gap-2 h-36">
        ${weekly.map(d => {
          const dt = new Date(d.day);
          const label = DAY_LABELS[dt.getDay()];
          const heightPct = Math.max(4, Math.round(((d.minutes || 0) / maxMinutes) * 100));
          return `
            <div class="flex-1 flex flex-col items-center justify-end h-full">
              <span class="text-[10px] font-semibold text-slate-400 mb-1">${d.questions || 0}s</span>
              <div class="w-full rounded-t-lg" style="height:${heightPct}%; background: linear-gradient(180deg, #7c3aed, #6366f1); min-height: 4px;"></div>
              <span class="text-[11px] font-medium text-slate-500 mt-1.5">${label}</span>
            </div>`;
        }).join("")}
      </div>
    </div>`;
}

function showErrorState() {
  document.getElementById("error-state").classList.remove("hidden");
  ["greeting-box", "exam-countdown", "top-news", "today-status", "today-priority", "schedule-timeline", "success-rate", "weekly-progress"]
    .forEach(id => { document.getElementById(id).innerHTML = ""; });
}

async function loadHomepage() {
  document.getElementById("error-state").classList.add("hidden");
  const { data, error } = await supabase.rpc("get_homepage");
  if (error || !data) {
    toast("Ana sayfa yüklenemedi.", "error");
    showErrorState();
    return;
  }
  renderGreeting(data);
  renderExamCountdown(data);
  renderTopNews(data);
  renderTodayStatus(data);
  renderTodayPriority(data);
  renderScheduleTimeline(data);
  renderSuccessRate(data);
  renderWeeklyProgress(data);
}

document.getElementById("retry-btn").addEventListener("click", loadHomepage);

loadHomepage();
