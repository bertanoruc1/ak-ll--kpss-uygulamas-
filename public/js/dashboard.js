import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js";
import { toast, escapeHtml, fmtDate, SESSION_TYPE_LABELS, SESSION_TYPE_ICONS, scoreColor, countUp } from "./ui.js";
import { NEWS_CATEGORY_LABELS } from "./config.js";
import { ensurePushSubscription } from "./push.js";

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

// planned_start/planned_end hem "HH:MM:SS" hem de ISO ("...T...") biçiminde
// gelebiliyor (bkz. shortTime) — sıralama ve çakışma kontrolü için ikisini de
// gün içindeki dakikaya çeviren ortak bir yardımcı.
function toMinutes(t) {
  if (!t) return 0;
  if (t.includes("T")) {
    const d = new Date(t);
    return d.getHours() * 60 + d.getMinutes();
  }
  const [h, m] = t.split(":").map(Number);
  return (Number.isFinite(h) ? h : 0) * 60 + (Number.isFinite(m) ? m : 0);
}

function rangesOverlap(aStart, aEnd, bStart, bEnd) {
  return aStart < bEnd && bStart < aEnd;
}

// "Bugünün Programı" listesinin en güncel (sıralanmış) hâli — hem
// renderScheduleTimeline hem de yeni görev eklerken çakışma kontrolü için
// paylaşılan tek kaynak.
let currentSessions = [];

// Yeni bir [startTime,endTime) aralığının (saat girişleri "HH:MM" formatında)
// mevcut görevlerden hangileriyle çakıştığını döner. "Atlandı" olarak
// işaretlenmiş görevler o saati boşalttığı için kontrole dahil edilmiyor.
function findOverlappingSessions(startTime, endTime, excludeId = null) {
  const newStart = toMinutes(startTime);
  const newEnd = toMinutes(endTime) || newStart;
  return currentSessions.filter((s) => {
    if (excludeId && s.id === excludeId) return false;
    if (s.status === "skipped") return false;
    const sStart = toMinutes(s.planned_start);
    const sEnd = toMinutes(s.planned_end || s.planned_start);
    return rangesOverlap(newStart, newEnd, sStart, sEnd);
  });
}

function sessionLink(session) {
  const type = session.session_type;
  const topicId = session.topic_id;
  // Sorular artık ayrı bir sayfa değil, konu sayfasının (topic.html) içine
  // gömülü — bu yüzden 3 görev türü de aynı sayfaya yönlendiriyor. session
  // id'yi de linkliyoruz ki topic.js hedefe ulaşınca (ör. "6 soru" bitince)
  // bu görevi otomatik "Tamamlandı" olarak işaretleyebilsin.
  if (type === "soru_cozme") return `topic.html?id=${topicId}&session=${session.id}`;
  if (type === "konu_ogrenme") return `topic.html?id=${topicId}&session=${session.id}`;
  if (type === "tekrar") return `topic.html?id=${topicId}&review=1&session=${session.id}`;
  return "#";
}

const STATUS_LABELS = { planned: "Planlandı", done: "Tamamlandı", skipped: "Atlandı" };
const STATUS_CLASSES = {
  planned: "bg-teal-50 text-teal-700",
  done: "bg-emerald-50 text-emerald-700",
  skipped: "bg-slate-100 text-slate-500",
};

function renderHero(data) {
  const el = document.getElementById("hero-card");
  const exam = data.exam;
  const notifBadgeHtml = () => {
    const unread = data.unread_notifications || 0;
    if (!unread) return "";
    return `<span id="notif-badge" class="absolute -top-1.5 -right-1.5 min-w-[20px] h-5 px-1 rounded-full bg-rose-500 text-white text-[11px] font-bold flex items-center justify-center" style="box-shadow: 0 0 0 2px rgba(15,118,110,.55);">${unread > 99 ? "99+" : unread}</span>`;
  };

  el.innerHTML = `
    <div class="rounded-2xl p-6 sm:p-7 text-white relative overflow-hidden" style="background: linear-gradient(135deg, #0f766e, #0284c7 45%, #22d3ee 100%); box-shadow: 0 24px 56px -16px rgba(15,118,110,.5);">
      <div class="absolute inset-0" style="background: radial-gradient(340px 220px at 105% -10%, rgba(255,255,255,.16), transparent 60%), radial-gradient(260px 200px at -10% 110%, rgba(255,255,255,.08), transparent 55%);"></div>
      <div class="absolute -right-8 -bottom-10 text-9xl opacity-[0.08] select-none" style="pointer-events:none;">🎯</div>

      <div class="relative z-10">
        <div class="flex items-start justify-between gap-3">
          <div>
            <p class="text-xs font-semibold text-teal-200 uppercase tracking-wide">${timeOfDayGreeting()}</p>
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
                <p class="text-xs font-medium text-teal-200 tracking-wide">${escapeHtml(exam.name)}</p>
                <div class="flex items-end gap-1.5 mt-1 flex-wrap" id="exam-countdown">
                  <span id="stat-days-left" class="text-5xl font-extrabold leading-none">0</span>
                  <span class="text-base font-semibold mb-1 text-teal-100 mr-1.5">gün</span>
                  <span id="stat-hours-left" class="text-2xl font-extrabold leading-none">00</span>
                  <span class="text-sm font-semibold mb-0.5 text-teal-100 mr-1">sa</span>
                  <span id="stat-minutes-left" class="text-2xl font-extrabold leading-none">00</span>
                  <span class="text-sm font-semibold mb-0.5 text-teal-100 mr-1">dk</span>
                  <span id="stat-seconds-left" class="text-2xl font-extrabold leading-none">00</span>
                  <span class="text-sm font-semibold mb-0.5 text-teal-100">sn kaldı</span>
                </div>
              </div>
              <p class="text-xs text-teal-200">${fmtDate(exam.exam_date)}${exam.exam_time ? " · " + exam.exam_time.slice(0,5) : ""}</p>
            </div>` : `
            <div class="flex items-center gap-3">
              <span class="text-2xl">📅</span>
              <div>
                <p class="text-sm font-semibold">Sınav takvimi henüz belirlenmedi</p>
                <a href="exams.html" class="text-xs font-semibold text-teal-200 hover:underline">Sınav Takvimine Git →</a>
              </div>
            </div>`}
        </div>
      </div>
    </div>`;

  countUp(document.getElementById("stat-streak"), data.streak ?? 0, { duration: 700 });
  countUp(document.getElementById("stat-xp"), data.xp ?? 0, { duration: 1100 });
  if (exam) {
    countUp(document.getElementById("stat-days-left"), exam.days_left_precise ?? exam.days_left ?? 0, { duration: 1000 });
    startExamCountdown(exam.total_seconds_left ?? 0);
  }
}

// Sınava kalan süreyi saniyesine kadar canlı (her saniye) güncelleyen sayaç —
// "heyecanı artırsın" diye eklendi. Sunucudan gelen tek bir anlık değerden
// (total_seconds_left) başlayıp istemci tarafında saniyede bir geri sayar;
// sayfa yeniden yüklendiğinde get_homepage'den taze değer alınır.
let examCountdownTimer = null;
function startExamCountdown(initialTotalSeconds) {
  if (examCountdownTimer) clearInterval(examCountdownTimer);
  let remaining = Math.max(0, Math.floor(initialTotalSeconds));

  function render() {
    const days = Math.floor(remaining / 86400);
    const hours = Math.floor((remaining % 86400) / 3600);
    const minutes = Math.floor((remaining % 3600) / 60);
    const seconds = Math.floor(remaining % 60);
    const daysEl = document.getElementById("stat-days-left");
    const hoursEl = document.getElementById("stat-hours-left");
    const minutesEl = document.getElementById("stat-minutes-left");
    const secondsEl = document.getElementById("stat-seconds-left");
    if (daysEl) daysEl.textContent = String(days);
    if (hoursEl) hoursEl.textContent = String(hours).padStart(2, "0");
    if (minutesEl) minutesEl.textContent = String(minutes).padStart(2, "0");
    if (secondsEl) secondsEl.textContent = String(seconds).padStart(2, "0");
  }

  render();
  examCountdownTimer = setInterval(() => {
    if (remaining <= 0) {
      clearInterval(examCountdownTimer);
      return;
    }
    remaining -= 1;
    render();
  }, 1000);
}

// "Öğrenci sıkılmasın" isteği için: her gün değişen (rastgele değil,
// tarihe göre deterministik — sayfa her yenilendiğinde aynı gün içinde
// zıplamıyor) bir motivasyon/çalışma ipucu kartı. Basit, istemci taraflı —
// ekstra bir sorgu gerektirmiyor, sayfa hep bir şey söylüyor.
const DAILY_TIPS = [
  "Pomodoro tekniğini dene: 25 dakika kesintisiz çalış, 5 dakika mola ver. 4 tur sonunda uzun bir mola hak ettin.",
  "Yanlış yaptığın sorulara dönmek, yeni soru çözmekten çoğu zaman daha değerlidir — aynı hatayı sınavda tekrarlama.",
  "Kısa ama her gün çalışmak, ara sıra yapılan uzun maratonlardan daha kalıcı öğrenme sağlar.",
  "Bir konuyu bitirdikten sonra kendi cümlelerinle özetlemeyi dene — gerçekten anladığını bu şekilde test edersin.",
  "Zor geldiği için ertelediğin konuyu bugün 10 dakikalığına aç. Başlamak, bitirmekten daha zordur.",
  "Sesli tekrar (kendi kendine anlatmak), sessiz okumaktan çok daha etkili bir hatırlama yöntemidir.",
  "Uyku, öğrendiklerini kalıcı hafızaya taşır — gece geç saatlere kadar çalışmak yerine düzenli uyumaya öncelik ver.",
  "Bugün çözdüğün sorulardan en çok hangi konuda zorlandığını fark ettiysen, yarının ilk işi o olsun.",
  "Küçük hedefler koy: '3 saat çalışacağım' yerine '20 soru çözeceğim' daha somut ve motive edicidir.",
  "Sınav gününe kaç gün kaldığını biliyorsun — bugünü, o günden geriye saydığında pişman olmayacağın şekilde geçir.",
  "Zayıf olduğun konuları gizlemek yerine öne çıkar: en çok puanı, en zayıf konunu güçlendirerek kazanırsın.",
  "Bir soruyu yanlış yaptığında sadece doğru cevabı değil, neden yanlış düşündüğünü de not al.",
  "Telefonunu erişemeyeceğin bir mesafeye koyup 25 dakika çalışmayı dene — dikkat dağınıklığının çoğu oradan gelir.",
  "Haftalık ilerlemene bak: küçük görünen günlük adımlar, hafta sonunda büyük bir fark yaratıyor.",
  "Bugün moralin düşükse bile 5 soru çözmek, hiç çözmemekten sonsuz kat daha iyidir.",
];

function dayOfYear(d) {
  const start = new Date(d.getFullYear(), 0, 0);
  const diff = d - start;
  return Math.floor(diff / 86400000);
}

function renderDailyTip() {
  const el = document.getElementById("daily-tip");
  if (!el) return;
  const tip = DAILY_TIPS[dayOfYear(new Date()) % DAILY_TIPS.length];
  el.innerHTML = `
    <div class="card p-4 flex items-start gap-3" style="background: linear-gradient(135deg, #fef3c7, #fce7f3 120%);">
      <div class="text-2xl shrink-0">💡</div>
      <div class="min-w-0">
        <p class="text-xs font-bold text-amber-700 uppercase tracking-wide mb-0.5">Günün İpucu</p>
        <p class="text-sm text-slate-700 leading-relaxed">${escapeHtml(tip)}</p>
      </div>
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
        <span class="badge bg-teal-50 text-teal-700">${escapeHtml(categoryLabel)}</span>
        <a href="news.html" class="text-xs font-semibold text-teal-600 hover:underline shrink-0">Tümünü Gör →</a>
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
        <span class="text-sm font-semibold text-teal-600">%<span id="stat-today-pct">0</span></span>
      </div>
      <div class="progress-track">
        <div id="today-progress-fill" class="progress-fill" style="width:0%; background: linear-gradient(90deg, #14b8a6, #0ea5e9);"></div>
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
        <span class="badge bg-white text-teal-700 border border-teal-100">Bugünün Önceliği</span>
      </div>
      <p class="text-xs font-semibold text-teal-500 uppercase tracking-wide">${escapeHtml(p.subject_name || "")} · ${escapeHtml(p.topic_name || "")}</p>
      <p class="font-bold text-lg text-slate-900 mt-1 leading-snug">${escapeHtml(p.reason)}</p>
      <a href="topic.html?id=${p.topic_id}" class="btn-primary inline-block mt-4 px-5 py-2.5 text-sm">Şimdi Çalış →</a>
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

// ---- "+ Görev Ekle" (manuel görev) modalı ----
// Kullanıcı kendi görevini kendi belirlesin istiyor: "bugün Matematik'te
// EBOB-EKOK'a çalışacağım, 12:00-14:00" gibi. create_manual_session RPC'si
// bunu study_sessions'a is_manual=true olarak ekliyor; buradan da
// ensurePushSubscription() ile bildirim izni isteniyor ki görev zamanı
// gelince (send-reminders Edge Function, her dakika pg_cron ile) gerçek bir
// push bildirimi + uygulama içi 🔔 bildirimi gönderilebilsin.
const TASK_SESSION_TYPES = ["konu_ogrenme", "soru_cozme", "tekrar", "mola"];
let taskSubjectsCache = null;

function closeTaskModal() {
  const el = document.getElementById("task-modal-overlay");
  if (el) el.remove();
  document.removeEventListener("keydown", handleTaskModalKeydown);
}

function handleTaskModalKeydown(e) {
  if (e.key === "Escape") closeTaskModal();
}

async function loadTaskSubjects() {
  if (taskSubjectsCache) return taskSubjectsCache;
  const examType = student?.exam_type || "kpss_lisans";
  const { data, error } = await supabase
    .from("subjects")
    .select("id, name, icon")
    .eq("exam_type", examType)
    .order("order_index");
  if (error) {
    taskSubjectsCache = [];
  } else {
    taskSubjectsCache = data || [];
  }
  return taskSubjectsCache;
}

async function openTaskModal() {
  closeTaskModal();

  const overlay = document.createElement("div");
  overlay.id = "task-modal-overlay";
  overlay.className = "fixed inset-0 z-50 flex items-center justify-center p-4";
  overlay.style.background = "rgba(15,10,50,.45)";
  overlay.style.backdropFilter = "blur(3px)";
  overlay.innerHTML = `
    <div class="card p-6 w-full fadeIn" style="max-width: 440px; max-height: 88vh; overflow-y: auto;">
      <p class="text-lg font-extrabold text-slate-900">📝 Bugün Yapılacak Görev Ekle</p>
      <p class="text-sm text-slate-500 mt-1">Ne zaman, hangi derste, hangi konuya çalışacağını belirle — saati gelince sana hatırlatalım.</p>

      <div class="mt-5">
        <label class="text-xs font-semibold text-slate-600 block mb-1.5">Görev Türü</label>
        <select id="task-type" class="input">
          ${TASK_SESSION_TYPES.map((t) => `<option value="${t}">${SESSION_TYPE_ICONS[t] || ""} ${SESSION_TYPE_LABELS[t] || t}</option>`).join("")}
        </select>
      </div>

      <div class="mt-3" id="task-subject-wrap">
        <label class="text-xs font-semibold text-slate-600 block mb-1.5">Ders</label>
        <select id="task-subject" class="input">
          <option value="">Yükleniyor…</option>
        </select>
      </div>

      <div class="mt-3" id="task-topic-wrap">
        <label class="text-xs font-semibold text-slate-600 block mb-1.5">Konu <span class="text-slate-400 font-normal">(opsiyonel)</span></label>
        <select id="task-topic" class="input">
          <option value="">Konu seçilmedi</option>
        </select>
      </div>

      <div class="grid grid-cols-2 gap-3 mt-3">
        <div>
          <label class="text-xs font-semibold text-slate-600 block mb-1.5">Başlangıç Saati</label>
          <input id="task-start-time" type="time" class="input" />
        </div>
        <div>
          <label class="text-xs font-semibold text-slate-600 block mb-1.5">Bitiş Saati</label>
          <input id="task-end-time" type="time" class="input" />
        </div>
      </div>
      <p id="task-overlap-warning" class="hidden text-xs font-semibold text-rose-600 mt-2 flex items-start gap-1">⚠️ <span></span></p>

      <div class="mt-3" id="task-question-target-wrap">
        <label class="text-xs font-semibold text-slate-600 block mb-1.5">Hedef Soru Sayısı <span class="text-slate-400 font-normal">(opsiyonel)</span></label>
        <input id="task-question-target" type="number" min="1" step="1" class="input" placeholder="ör. 20" />
      </div>

      <div class="grid grid-cols-2 gap-3 mt-5">
        <button id="task-modal-cancel" type="button" class="btn-secondary py-2.5">Vazgeç</button>
        <button id="task-modal-submit" type="button" class="btn-primary py-2.5">Görevi Oluştur</button>
      </div>
    </div>`;
  document.body.appendChild(overlay);

  const typeSelect = document.getElementById("task-type");
  const subjectSelect = document.getElementById("task-subject");
  const topicSelect = document.getElementById("task-topic");
  const subjectWrap = document.getElementById("task-subject-wrap");
  const topicWrap = document.getElementById("task-topic-wrap");
  const questionTargetWrap = document.getElementById("task-question-target-wrap");

  function syncFieldsForType() {
    const isMola = typeSelect.value === "mola";
    subjectWrap.classList.toggle("hidden", isMola);
    topicWrap.classList.toggle("hidden", isMola);
    questionTargetWrap.classList.toggle("hidden", typeSelect.value !== "soru_cozme");
  }
  typeSelect.addEventListener("change", syncFieldsForType);
  syncFieldsForType();

  // Kullanıcı saat girerken anlık çakışma uyarısı — kaydetmeden ÖNCE, o gün
  // için zaten planlanmış görevlerle çakışıp çakışmadığını gösterir.
  const startTimeInput = document.getElementById("task-start-time");
  const endTimeInput = document.getElementById("task-end-time");
  const overlapWarningEl = document.getElementById("task-overlap-warning");
  const submitBtnEl = document.getElementById("task-modal-submit");
  function updateOverlapWarning() {
    if (submitBtnEl) { submitBtnEl.dataset.overlapConfirmed = "0"; submitBtnEl.textContent = "Görevi Oluştur"; }
    const st = startTimeInput.value, et = endTimeInput.value;
    if (!st || !et || !overlapWarningEl) { overlapWarningEl?.classList.add("hidden"); return; }
    const conflicts = findOverlappingSessions(st, et);
    if (conflicts.length > 0) {
      const names = conflicts.map((c) => c.subject_name || SESSION_TYPE_LABELS[c.session_type] || "bir görev").join(", ");
      overlapWarningEl.querySelector("span").textContent = `Bu saat aralığı şununla çakışıyor: ${names}`;
      overlapWarningEl.classList.remove("hidden");
    } else {
      overlapWarningEl.classList.add("hidden");
    }
  }
  startTimeInput.addEventListener("input", updateOverlapWarning);
  endTimeInput.addEventListener("input", updateOverlapWarning);

  async function loadTopicsForSubject(subjectId) {
    if (!subjectId) {
      topicSelect.innerHTML = `<option value="">Konu seçilmedi</option>`;
      return;
    }
    topicSelect.innerHTML = `<option value="">Yükleniyor…</option>`;
    const { data, error } = await supabase
      .from("topics")
      .select("id, name")
      .eq("subject_id", subjectId)
      .order("order_index");
    if (error || !data) {
      topicSelect.innerHTML = `<option value="">Konu seçilmedi</option>`;
      return;
    }
    topicSelect.innerHTML =
      `<option value="">Konu seçilmedi</option>` +
      data.map((t) => `<option value="${t.id}">${escapeHtml(t.name)}</option>`).join("");
  }

  const subjects = await loadTaskSubjects();
  if (subjects.length === 0) {
    subjectSelect.innerHTML = `<option value="">Ders bulunamadı</option>`;
  } else {
    subjectSelect.innerHTML = subjects
      .map((s) => `<option value="${s.id}">${s.icon ? escapeHtml(s.icon) + " " : ""}${escapeHtml(s.name)}</option>`)
      .join("");
    await loadTopicsForSubject(subjectSelect.value);
  }
  subjectSelect.addEventListener("change", () => loadTopicsForSubject(subjectSelect.value));

  overlay.addEventListener("click", (e) => { if (e.target === overlay) closeTaskModal(); });
  document.getElementById("task-modal-cancel").addEventListener("click", closeTaskModal);
  document.getElementById("task-modal-submit").addEventListener("click", (e) => submitTaskModal(e.currentTarget));
  document.addEventListener("keydown", handleTaskModalKeydown);
}

async function submitTaskModal(btn) {
  const sessionType = document.getElementById("task-type").value;
  const subjectId = document.getElementById("task-subject").value || null;
  const topicId = document.getElementById("task-topic").value || null;
  const startTime = document.getElementById("task-start-time").value;
  const endTime = document.getElementById("task-end-time").value;
  const questionTargetRaw = document.getElementById("task-question-target").value;
  const questionTarget = sessionType === "soru_cozme" && questionTargetRaw ? Number(questionTargetRaw) : null;

  if (sessionType !== "mola" && !subjectId) {
    toast("Lütfen bir ders seç.", "error");
    return;
  }
  if (!startTime || !endTime) {
    toast("Lütfen başlangıç ve bitiş saatini seç.", "error");
    return;
  }

  // Çakışma varsa ilk tıklamada engelle, kullanıcıya göster; bilerek "yine de
  // ekle" derse (butona ikinci kez basarsa) devam et.
  const conflicts = findOverlappingSessions(startTime, endTime);
  if (conflicts.length > 0 && btn.dataset.overlapConfirmed !== "1") {
    const names = conflicts.map((c) => c.subject_name || SESSION_TYPE_LABELS[c.session_type] || "bir görev").join(", ");
    toast(`⚠️ Bu saatler şununla çakışıyor: ${names}. Yine de eklemek için tekrar "Görevi Oluştur"a bas.`, "error");
    btn.dataset.overlapConfirmed = "1";
    btn.textContent = "Yine de Ekle";
    return;
  }

  btn.disabled = true;
  btn.textContent = "Oluşturuluyor...";

  const { error } = await supabase.rpc("create_manual_session", {
    p_subject_id: sessionType === "mola" ? null : subjectId,
    p_topic_id: sessionType === "mola" ? null : topicId,
    p_session_type: sessionType,
    p_planned_start: startTime,
    p_planned_end: endTime,
    p_question_target: questionTarget,
    p_plan_date: new Date().toISOString().slice(0, 10),
  });

  if (error) {
    toast(error.message || "Görev oluşturulamadı.", "error");
    btn.disabled = false;
    btn.textContent = "Görevi Oluştur";
    return;
  }

  // Görev zamanı gelince hatırlatıcı gönderebilmek için push aboneliğini
  // kur (izin daha önce verilmediyse tarayıcı burada soracak). Kullanıcı
  // izin vermese/tarayıcı desteklemese bile görev zaten oluşturuldu — bu
  // adım sessizce başarısız olabilir, görevi engellemez.
  ensurePushSubscription().catch(() => {});

  toast("Görev eklendi! Saati gelince hatırlatacağız.", "success");
  closeTaskModal();
  loadHomepage();
}

async function deleteManualTask(sessionId, btn) {
  if (btn) btn.disabled = true;
  const { error } = await supabase.rpc("delete_manual_session", { p_session_id: sessionId });
  if (error) {
    toast(error.message || "Görev silinemedi.", "error");
    if (btn) btn.disabled = false;
    return;
  }
  toast("Görev silindi.", "success");
  loadHomepage();
}

function renderScheduleTimeline(data) {
  const el = document.getElementById("schedule-timeline");
  // Backend zaten planned_start sırasına göre veriyor olsa da, manuel
  // eklenen görevler (create_manual_session) listeye ekleniş sırasına göre
  // gelebiliyordu — bu yüzden istemci tarafında da HER ZAMAN başlangıç
  // saatine göre artan sırada göster (array.sort). Kullanıcı yeni görev
  // eklediğinde loadHomepage() zaten baştan çağrılıp bu fonksiyon yeniden
  // çalıştığı için sıralama otomatik olarak güncel kalır.
  const sessions = [...(data.today_sessions || [])].sort(
    (a, b) => toMinutes(a.planned_start) - toMinutes(b.planned_start)
  );
  // Görev ekleme modalındaki anlık çakışma kontrolü için en güncel (sıralı)
  // listeyi paylaşılan değişkende sakla.
  currentSessions = sessions;

  // Sıralanmış listede ardışık görevlerin saat aralıkları çakışıyor mu diye
  // kontrol et — "Atlandı" olanlar o saati boşalttığı için sayılmıyor.
  const overlapIds = new Set();
  for (let i = 0; i < sessions.length - 1; i++) {
    const a = sessions[i];
    const b = sessions[i + 1];
    if (a.status === "skipped" || b.status === "skipped") continue;
    const overlap = rangesOverlap(
      toMinutes(a.planned_start), toMinutes(a.planned_end || a.planned_start),
      toMinutes(b.planned_start), toMinutes(b.planned_end || b.planned_start)
    );
    if (overlap) { overlapIds.add(a.id); overlapIds.add(b.id); }
  }

  if (sessions.length === 0) {
    el.innerHTML = `
      <div class="card p-6 text-center">
        <div class="text-3xl mb-2">🗓️</div>
        <p class="font-semibold text-slate-700">Bugün için henüz bir plan yok.</p>
        <p class="text-sm text-slate-400 mt-1">Çalışma saatlerini seç, hemen bir plan oluşturalım.</p>
        <div class="flex items-center justify-center gap-2.5 mt-4 flex-wrap">
          <button id="generate-plan-btn" class="btn-primary inline-block px-5 py-2.5 text-sm">Bugünkü Planı Oluştur</button>
          <button id="add-task-btn" class="btn-secondary inline-block px-5 py-2.5 text-sm">📝 Bugün Yapılacak Ekle</button>
        </div>
      </div>`;
    document.getElementById("generate-plan-btn").addEventListener("click", () => openPlanModal());
    document.getElementById("add-task-btn").addEventListener("click", () => openTaskModal());
    return;
  }

  el.innerHTML = `
    <div class="card p-5">
      <div class="flex items-center justify-between mb-4 gap-2 flex-wrap">
        <p class="font-bold text-slate-900">Bugünün Programı</p>
        <div class="flex items-center gap-3">
          <button id="add-task-btn" class="text-xs font-semibold text-teal-600 hover:underline">📝 Bugün Yapılacak Ekle</button>
          <button id="replan-btn" class="text-xs font-semibold text-teal-600 hover:underline">⚙️ Saatleri Ayarla</button>
        </div>
      </div>
      <div class="space-y-0">
        ${sessions.map((s, i) => `
          <div class="flex gap-3 relative">
            <div class="flex flex-col items-center">
              <div class="w-3 h-3 rounded-full mt-1.5 shrink-0" style="background: ${s.status === "done" ? "#10b981" : s.status === "skipped" ? "#cbd5e1" : "#14b8a6"};"></div>
              ${i < sessions.length - 1 ? '<div class="w-px flex-1 bg-slate-200 my-0.5"></div>' : ""}
            </div>
            <div class="flex-1 pb-4 flex items-start gap-1.5">
              <a href="${sessionLink(s)}" class="flex-1 group min-w-0">
                <div class="rounded-xl border ${overlapIds.has(s.id) ? "border-rose-200 bg-rose-50/40" : "border-slate-100"} group-hover:border-teal-200 group-hover:bg-teal-50/40 transition p-3">
                  <div class="flex items-start justify-between gap-2">
                    <div class="flex items-center gap-2 min-w-0">
                      <span class="text-lg shrink-0">${SESSION_TYPE_ICONS[s.session_type] || "📌"}</span>
                      <div class="min-w-0">
                        <p class="text-xs font-semibold text-slate-400">${SESSION_TYPE_LABELS[s.session_type] || s.session_type}${s.is_manual ? " · kendi eklediğin görev" : ""}</p>
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
                  ${overlapIds.has(s.id) ? `<p class="text-xs font-semibold text-rose-600 mt-2 flex items-center gap-1">⚠️ Bu görev, saat olarak başka bir görevle çakışıyor</p>` : ""}
                </div>
              </a>
              ${s.is_manual ? `<button class="delete-task-btn shrink-0 mt-3 w-8 h-8 rounded-lg flex items-center justify-center text-slate-400 hover:text-rose-600 hover:bg-rose-50 transition" data-session-id="${s.id}" title="Görevi sil">🗑️</button>` : ""}
            </div>
          </div>
        `).join("")}
      </div>
    </div>`;
  document.getElementById("replan-btn").addEventListener("click", () => openPlanModal());
  document.getElementById("add-task-btn").addEventListener("click", () => openTaskModal());
  el.querySelectorAll(".delete-task-btn").forEach((btn) => {
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      e.stopPropagation();
      deleteManualTask(btn.dataset.sessionId, btn);
    });
  });
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
              <div class="w-full rounded-t-lg" style="height:${heightPct}%; background: linear-gradient(180deg, #0ea5e9, #14b8a6); min-height: 4px;"></div>
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
  renderDailyTip();
  renderTopNews(data);
  renderTodayStatus(data);
  renderTodayPriority(data);
  renderScheduleTimeline(data);
  renderSuccessRate(data);
  renderWeeklyProgress(data);
}

document.getElementById("retry-btn").addEventListener("click", loadHomepage);

loadHomepage();
