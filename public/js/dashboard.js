import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js";
import { toast, escapeHtml, fmtDate, SESSION_TYPE_LABELS, SESSION_TYPE_ICONS, scoreColor, countUp } from "./ui.js";
import { NEWS_CATEGORY_LABELS } from "./config.js";

const auth = await requireAuth();
if (!auth) {
  // requireAuth already redirected.
  throw new Error("not authenticated");
}
const { user, student } = auth;

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

function renderHero(data) {
  const el = document.getElementById("hero-card");
  const exam = data.exam;
  const notifBadgeHtml = () => {
    const unread = data.unread_notifications || 0;
    if (!unread) return "";
    return `<span id="notif-badge" class="absolute -top-1.5 -right-1.5 min-w-[20px] h-5 px-1 rounded-full bg-rose-500 text-white text-[11px] font-bold flex items-center justify-center" style="box-shadow: 0 0 0 2px rgba(76,29,149,.55);">${unread > 99 ? "99+" : unread}</span>`;
  };

  el.innerHTML = `
    <div class="rounded-2xl p-6 sm:p-7 text-white relative overflow-hidden" style="background: linear-gradient(135deg, #3730a3, #6d28d9 45%, #a21caf 100%); box-shadow: 0 24px 56px -16px rgba(76,29,149,.5);">
      <div class="absolute inset-0" style="background: radial-gradient(340px 220px at 105% -10%, rgba(255,255,255,.16), transparent 60%), radial-gradient(260px 200px at -10% 110%, rgba(255,255,255,.08), transparent 55%);"></div>
      <div class="absolute -right-8 -bottom-10 text-9xl opacity-[0.08] select-none" style="pointer-events:none;">🎯</div>

      <div class="relative z-10">
        <div class="flex items-start justify-between gap-3">
          <div>
            <p class="text-xs font-semibold text-indigo-200 uppercase tracking-wide">${timeOfDayGreeting()}</p>
            <h1 class="text-2xl sm:text-3xl font-extrabold leading-tight mt-0.5">Merhaba, ${escapeHtml(data.greeting_name || "Öğrenci")} 👋</h1>
          </div>
          <a href="notifications.html" class="relative shrink-0 w-11 h-11 rounded-xl flex items-center justify-center text-xl transition" style="background: rgba(255,255,255,.12); backdrop-filter: blur(6px);">
            🔔${notifBadgeHtml()}
          </a>
        </div>

        <div class="flex items-center gap-2 mt-4 flex-wrap">
          <span class="badge" style="background: rgba(255,255,255,.14); color: #fff;">🔥 <span id="stat-streak">0</span> gün seri</span>
          <span class="badge badge-gold">✨ <span id="stat-xp">0</span> XP</span>
          <span class="badge" style="background: rgba(255,255,255,.14); color: #fff;">🏅 Seviye ${data.level ?? 1}</span>
        </div>

        <div class="mt-5 pt-5" style="border-top: 1px solid rgba(255,255,255,.14);">
          ${exam ? `
            <div class="flex items-end justify-between gap-3 flex-wrap">
              <div>
                <p class="text-xs font-medium text-indigo-200 tracking-wide">${escapeHtml(exam.name)}</p>
                <div class="flex items-end gap-2 mt-1">
                  <span id="stat-days-left" class="text-5xl font-extrabold leading-none">0</span>
                  <span class="text-base font-semibold mb-1 text-indigo-100">gün kaldı</span>
                </div>
              </div>
              <p class="text-xs text-indigo-200">${fmtDate(exam.exam_date)}</p>
            </div>` : `
            <div class="flex items-center gap-3">
              <span class="text-2xl">📅</span>
              <div>
                <p class="text-sm font-semibold">Sınav takvimi henüz belirlenmedi</p>
                <a href="exams.html" class="text-xs font-semibold text-indigo-200 hover:underline">Sınav Takvimine Git →</a>
              </div>
            </div>`}
        </div>
      </div>
    </div>`;

  countUp(document.getElementById("stat-streak"), data.streak ?? 0, { duration: 700 });
  countUp(document.getElementById("stat-xp"), data.xp ?? 0, { duration: 1100 });
  if (exam) countUp(document.getElementById("stat-days-left"), exam.days_left ?? 0, { duration: 1000 });
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
        <span class="text-sm font-semibold text-indigo-600">%<span id="stat-today-pct">0</span></span>
      </div>
      <div class="progress-track">
        <div id="today-progress-fill" class="progress-fill" style="width:0%; background: linear-gradient(90deg, #6366f1, #7c3aed);"></div>
      </div>
    </div>`;
  countUp(document.getElementById("stat-today-pct"), pct, { duration: 700 });
  requestAnimationFrame(() => requestAnimationFrame(() => {
    const fill = document.getElementById("today-progress-fill");
    if (fill) fill.style.width = `${pct}%`;
  }));
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

// ---- Günlük plan ayar modalı ----
// Kullanıcı "Bugünkü Planı Oluştur"a bastığında planı doğrudan varsayılan
// saatlerle oluşturmak yerine, önce başlangıç/bitiş saatini ve günlük çalışma
// süresini seçebileceği bir ekran (modal) açıyoruz. Buradaki değerler
// students.preferred_start_time / preferred_end_time / daily_study_minutes
// alanlarına kaydediliyor — generate_study_plan RPC'si zaten programı bu
// alanlara göre oluşturuyor (bkz. 20240601000050_study_planner.sql).
function closePlanModal() {
  const el = document.getElementById("plan-modal-overlay");
  if (el) el.remove();
  document.removeEventListener("keydown", handlePlanModalKeydown);
}

function handlePlanModalKeydown(e) {
  if (e.key === "Escape") closePlanModal();
}

function openPlanModal() {
  closePlanModal();

  const start = (student?.preferred_start_time || "19:00").slice(0, 5);
  const end = (student?.preferred_end_time || "21:00").slice(0, 5);
  const minutes = student?.daily_study_minutes ?? 120;

  const overlay = document.createElement("div");
  overlay.id = "plan-modal-overlay";
  overlay.className = "fixed inset-0 z-50 flex items-center justify-center p-4";
  overlay.style.background = "rgba(15,10,50,.45)";
  overlay.style.backdropFilter = "blur(3px)";
  overlay.innerHTML = `
    <div class="card p-6 w-full fadeIn" style="max-width: 420px;">
      <p class="text-lg font-extrabold text-slate-900">🗓️ Bugünkü Planını Ayarla</p>
      <p class="text-sm text-slate-500 mt-1">Seçtiğin saat aralığının tamamı, farklı derslerle kapsamlı şekilde doldurulur.</p>

      <div class="grid grid-cols-2 gap-3 mt-5">
        <div>
          <label class="text-xs font-semibold text-slate-600 block mb-1.5">Başlangıç Saati</label>
          <input id="plan-start-time" type="time" class="input" value="${start}" />
        </div>
        <div>
          <label class="text-xs font-semibold text-slate-600 block mb-1.5">Bitiş Saati</label>
          <input id="plan-end-time" type="time" class="input" value="${end}" />
        </div>
      </div>

      <div class="mt-3">
        <label class="text-xs font-semibold text-slate-600 block mb-1.5">Toplam Çalışma Süresi</label>
        <input id="plan-daily-minutes" type="number" min="15" step="5" class="input" value="${minutes}" readonly style="background:#f8f9fb; color:#64748b;" />
        <p class="text-xs text-slate-400 mt-1">Saat aralığından otomatik hesaplanır (en fazla 12 saat).</p>
      </div>

      <div class="grid grid-cols-2 gap-3 mt-5">
        <button id="plan-modal-cancel" type="button" class="btn-secondary py-2.5">Vazgeç</button>
        <button id="plan-modal-submit" type="button" class="btn-primary py-2.5">Planı Oluştur</button>
      </div>
    </div>`;
  document.body.appendChild(overlay);

  const startInput = document.getElementById("plan-start-time");
  const endInput = document.getElementById("plan-end-time");
  const minutesInput = document.getElementById("plan-daily-minutes");

  // Saat aralığı değiştikçe toplam süreyi otomatik hesapla. Bu alan artık
  // salt-okunur (readonly) — backend (generate_study_plan) da toplam süreyi
  // ARTIK ÖNCELİKLE bu saat aralığından hesaplıyor, bu yüzden ikisinin
  // birbirinden kopması (ör. saat değiştirilip süre elle değiştirilmemesi
  // gibi) mümkün değil; gösterge her zaman gerçek plan süresini yansıtır.
  // "input" olayı, mobil zaman seçicilerde "change"den daha güvenilir tetiklenir.
  function syncMinutesFromRange() {
    const [sh, sm] = (startInput.value || "").split(":").map(Number);
    const [eh, em] = (endInput.value || "").split(":").map(Number);
    if ([sh, sm, eh, em].some((n) => Number.isNaN(n))) return;
    let diff = (eh * 60 + em) - (sh * 60 + sm);
    if (diff <= 0) diff += 24 * 60; // gece yarısını geçen aralık
    minutesInput.value = Math.min(diff, 720); // backend de 12 saatte sınırlıyor
  }
  startInput.addEventListener("input", syncMinutesFromRange);
  endInput.addEventListener("input", syncMinutesFromRange);
  startInput.addEventListener("change", syncMinutesFromRange);
  endInput.addEventListener("change", syncMinutesFromRange);
  syncMinutesFromRange();

  overlay.addEventListener("click", (e) => { if (e.target === overlay) closePlanModal(); });
  document.getElementById("plan-modal-cancel").addEventListener("click", closePlanModal);
  document.getElementById("plan-modal-submit").addEventListener("click", (e) => submitPlanModal(e.currentTarget));
  document.addEventListener("keydown", handlePlanModalKeydown);
  startInput.focus();
}

async function submitPlanModal(btn) {
  const preferred_start_time = document.getElementById("plan-start-time").value;
  const preferred_end_time = document.getElementById("plan-end-time").value;
  const daily_study_minutes = Number(document.getElementById("plan-daily-minutes").value);

  if (!preferred_start_time || !preferred_end_time) {
    toast("Lütfen başlangıç ve bitiş saatini seç.", "error");
    return;
  }
  if (!daily_study_minutes || daily_study_minutes < 15) {
    toast("Günlük çalışma süresi en az 15 dakika olmalı.", "error");
    return;
  }

  btn.disabled = true;
  btn.textContent = "Oluşturuluyor...";

  const { error: studentErr } = await supabase
    .from("students")
    .update({ preferred_start_time, preferred_end_time, daily_study_minutes })
    .eq("user_id", user.id);

  if (studentErr) {
    toast(studentErr.message || "Saatler kaydedilemedi.", "error");
    btn.disabled = false;
    btn.textContent = "Planı Oluştur";
    return;
  }

  const { error: planErr } = await supabase.rpc("generate_study_plan", {});
  if (planErr) {
    toast(planErr.message || "Plan oluşturulamadı.", "error");
    btn.disabled = false;
    btn.textContent = "Planı Oluştur";
    return;
  }

  if (student) {
    student.preferred_start_time = preferred_start_time;
    student.preferred_end_time = preferred_end_time;
    student.daily_study_minutes = daily_study_minutes;
  }

  toast("Plan oluşturuldu!", "success");
  closePlanModal();
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
        <p class="text-sm text-slate-400 mt-1">Çalışma saatlerini seç, hemen bir plan oluşturalım.</p>
        <button id="generate-plan-btn" class="btn-primary inline-block mt-4 px-5 py-2.5 text-sm">Bugünkü Planı Oluştur</button>
      </div>`;
    document.getElementById("generate-plan-btn").addEventListener("click", () => openPlanModal());
    return;
  }

  el.innerHTML = `
    <div class="card p-5">
      <div class="flex items-center justify-between mb-4">
        <p class="font-bold text-slate-900">Bugünün Programı</p>
        <button id="replan-btn" class="text-xs font-semibold text-indigo-600 hover:underline">⚙️ Saatleri Ayarla</button>
      </div>
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
  document.getElementById("replan-btn").addEventListener("click", () => openPlanModal());
}

function renderSuccessRate(data) {
  const el = document.getElementById("success-rate");
  const rate = data.success_rate ?? 0;
  el.innerHTML = `
    <div class="card p-5 flex items-center justify-between">
      <div>
        <p class="text-sm font-semibold text-slate-500">Genel Başarı Oranı</p>
        <p class="text-4xl font-extrabold mt-1" style="color: ${scoreColor(rate)};">%<span id="stat-success-rate">0</span></p>
      </div>
      <div class="text-4xl">📊</div>
    </div>`;
  countUp(document.getElementById("stat-success-rate"), Math.round(rate), { duration: 1000 });
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
  ["hero-card", "top-news", "today-status", "today-priority", "schedule-timeline", "success-rate", "weekly-progress"]
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
  renderHero(data);
  renderTopNews(data);
  renderTodayStatus(data);
  renderTodayPriority(data);
  renderScheduleTimeline(data);
  renderSuccessRate(data);
  renderWeeklyProgress(data);
}

document.getElementById("retry-btn").addEventListener("click", loadHomepage);

loadHomepage();
