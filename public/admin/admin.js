import { supabase } from "../js/supabaseClient.js";
import { requireAuth, signOut } from "../js/auth.js";
import { toast, escapeHtml, fmtDate, fmtDateTime, timeAgo } from "../js/ui.js";
import { EXAM_TYPE_LABELS, NEWS_CATEGORY_LABELS, NOTIFICATION_PRIORITY_LABELS } from "../js/config.js";

// Gerçek KPSS sınavı her zaman 5 şıklıdır (A-E) — bkz. 20240601000330
// migration (mevcut soru bankasına eksik olan 5. şıkkı ekledi) ve
// practiceEngine.js'deki CHOICE_LETTERS. Admin panelinden eklenen yeni
// sorular da baştan 5 şıklı olsun diye burada da aynı sabit kullanılıyor.
const CHOICE_LETTERS = ["A", "B", "C", "D", "E"];

// ---------------------------------------------------------------------------
// Bootstrap
// ---------------------------------------------------------------------------

const auth = await requireAuth({ requireAdmin: true, requireOnboarding: false });
if (!auth) {
  throw new Error("not authenticated");
}

document.getElementById("logout-btn").addEventListener("click", signOut);

const tabsEl = document.getElementById("tabs");
const contentEl = document.getElementById("tab-content");

const EVENT_TYPE_LABELS = {
  NEW_OFFICIAL_NEWS: "Yeni Resmi Haber",
  EXAM_DATE_CHANGED: "Sınav Tarihi Değişti",
  APPLICATION_STARTED: "Başvurular Başladı",
  APPLICATION_DEADLINE_APPROACHING: "Başvuru Süresi Yaklaşıyor",
  EXAM_DATE_APPROACHING: "Sınav Tarihi Yaklaşıyor",
  CURRICULUM_CHANGED: "Müfredat Değişti",
  NEW_TOPIC_ADDED: "Yeni Konu Eklendi",
  STUDY_TIME: "Çalışma Zamanı",
  MISSED_STUDY: "Çalışma Kaçırıldı",
  REVIEW_DUE: "Tekrar Zamanı",
};

const DIFFICULTY_LABELS = { kolay: "Kolay", orta: "Orta", zor: "Zor" };
const TOPIC_STATUS_LABELS = {
  icerik_bekliyor: "İçerik Bekliyor",
  active: "Aktif",
  kaldirildi: "Kaldırıldı",
};
const SYNC_STATUS_COLORS = { no_change: "#64748b", changed: "#d97706", error: "#dc2626", pending_review: "#d97706" };

const TABS = [
  { id: "overview", label: "Genel Bakış", icon: "📊" },
  { id: "exams", label: "Sınav Takvimi", icon: "📅" },
  { id: "curriculum", label: "Müfredat", icon: "📚" },
  { id: "questions", label: "Sorular", icon: "❓" },
  { id: "news", label: "Haberler", icon: "📰" },
  { id: "aiqueue", label: "AI Onay Kuyruğu", icon: "🤖" },
  { id: "sync", label: "Veri Kaynakları", icon: "🔄" },
  { id: "audit", label: "Audit Log", icon: "🧾" },
  { id: "students", label: "Öğrenciler", icon: "🎓" },
  { id: "notify", label: "Bildirim Gönder", icon: "🔔" },
];

const state = { tab: "overview" };

function skeletonRows(n = 4, h = "h-16") {
  return `<div class="space-y-2.5">${Array.from({ length: n }).map(() => `<div class="skeleton ${h} w-full"></div>`).join("")}</div>`;
}

function optionsHtml(map, selected, includeEmpty) {
  let out = includeEmpty ? `<option value="">— Seçiniz —</option>` : "";
  out += Object.entries(map).map(([k, v]) => `<option value="${escapeHtml(k)}" ${k === selected ? "selected" : ""}>${escapeHtml(v)}</option>`).join("");
  return out;
}

function badge(text, color) {
  return `<span class="badge" style="background:${color}1a; color:${color};">${escapeHtml(text)}</span>`;
}

function toDateInputValue(v) {
  if (!v) return "";
  return new Date(v).toISOString().slice(0, 10);
}

function renderTabsNav() {
  tabsEl.innerHTML = TABS.map(
    (t) => `<button data-tab="${t.id}" class="tab-btn px-3 py-2.5 border-b-2 whitespace-nowrap transition ${
      state.tab === t.id ? "border-teal-600 text-teal-600 font-bold" : "border-transparent text-slate-500 hover:text-slate-700"
    }">${t.icon} ${t.label}</button>`
  ).join("");
  tabsEl.querySelectorAll(".tab-btn").forEach((b) => b.addEventListener("click", () => switchTab(b.dataset.tab)));
}

function switchTab(id) {
  state.tab = id;
  renderTabsNav();
  renderActiveTab();
}

async function renderActiveTab() {
  contentEl.innerHTML = skeletonRows(5, "h-24");
  const renderer = RENDERERS[state.tab];
  try {
    await renderer(contentEl);
  } catch (err) {
    console.error(err);
    toast(err.message || "Beklenmeyen bir hata oluştu.", "error");
    contentEl.innerHTML = `<div class="card p-8 text-center text-slate-500">Bir şeyler ters gitti. Sekmeyi tekrar açmayı deneyin.</div>`;
  }
}

// ---------------------------------------------------------------------------
// 1) Genel Bakış
// ---------------------------------------------------------------------------

async function renderOverview(root) {
  root.innerHTML = `<div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4">${skeletonRows(1, "h-28")}${skeletonRows(1, "h-28")}${skeletonRows(1, "h-28")}${skeletonRows(1, "h-28")}${skeletonRows(1, "h-28")}</div>`;

  const todayStart = new Date();
  todayStart.setHours(0, 0, 0, 0);

  const [
    { count: studentCount },
    { count: answersToday },
    { count: newsCount },
    { count: pendingReviewCount },
    { count: aiPendingCount },
  ] = await Promise.all([
    supabase.from("students").select("*", { count: "exact", head: true }),
    supabase.from("user_answers").select("*", { count: "exact", head: true }).gte("answered_at", todayStart.toISOString()),
    supabase.from("news_items").select("*", { count: "exact", head: true }),
    supabase.from("admin_audit_log").select("*", { count: "exact", head: true }).eq("action", "pending_review"),
    supabase.from("ai_content_queue").select("*", { count: "exact", head: true }).eq("status", "ai_generated"),
  ]);

  const cards = [
    { label: "Toplam Öğrenci", value: studentCount ?? 0, icon: "🎓" },
    { label: "Bugün Çözülen Soru", value: answersToday ?? 0, icon: "✏️" },
    { label: "Toplam Haber", value: newsCount ?? 0, icon: "📰" },
    { label: "Bekleyen Senkron İncelemesi", value: pendingReviewCount ?? 0, icon: "🔍" },
    { label: "Bekleyen AI İçerik", value: aiPendingCount ?? 0, icon: "🤖" },
  ];

  root.innerHTML = `
    <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4 fadeIn">
      ${cards.map((c) => `
        <div class="card p-5">
          <div class="text-2xl">${c.icon}</div>
          <p class="text-2xl font-extrabold text-slate-900 mt-2">${c.value}</p>
          <p class="text-xs text-slate-500 mt-1">${escapeHtml(c.label)}</p>
        </div>`).join("")}
    </div>`;
}

// ---------------------------------------------------------------------------
// 2) Sınav Takvimi
// ---------------------------------------------------------------------------

const examState = { list: [], editingId: null, showNew: false };

const EXAM_TEXT_FIELDS = ["name", "source", "source_url"];
const EXAM_DATE_FIELDS = ["exam_date", "application_start", "application_end", "late_application_date", "result_date"];

async function renderExamsTab(root) {
  root.innerHTML = skeletonRows(5, "h-32");
  const { data, error } = await supabase.from("exams").select("*").order("exam_date", { ascending: true, nullsFirst: false });
  if (error) {
    toast(error.message, "error");
    root.innerHTML = `<div class="card p-8 text-center text-slate-500">Sınavlar yüklenemedi.</div>`;
    return;
  }
  examState.list = data || [];
  drawExamsTab(root);
}

function drawExamsTab(root) {
  root.innerHTML = `
    <div class="flex items-center justify-between mb-4">
      <h2 class="text-lg font-bold text-slate-900">Sınav Takvimi</h2>
      <button id="exam-new-btn" class="btn-primary px-4 py-2 text-sm">+ Yeni Sınav</button>
    </div>
    <div id="exam-new-form-wrap">${examState.showNew ? examNewFormHtml() : ""}</div>
    <div class="space-y-4 mt-4">
      ${examState.list.map((e) => examCardHtml(e)).join("") || `<div class="card p-8 text-center text-slate-500">Henüz sınav eklenmemiş.</div>`}
    </div>`;

  document.getElementById("exam-new-btn").addEventListener("click", () => {
    examState.showNew = !examState.showNew;
    drawExamsTab(root);
  });

  if (examState.showNew) {
    const form = document.getElementById("exam-new-form");
    form.addEventListener("submit", (ev) => handleExamCreate(ev, root));
    document.getElementById("exam-new-cancel").addEventListener("click", () => {
      examState.showNew = false;
      drawExamsTab(root);
    });
  }

  examState.list.forEach((e) => {
    document.getElementById(`exam-edit-btn-${e.id}`)?.addEventListener("click", () => {
      examState.editingId = examState.editingId === e.id ? null : e.id;
      drawExamsTab(root);
    });
    if (examState.editingId === e.id) {
      document.getElementById(`exam-edit-form-${e.id}`).addEventListener("submit", (ev) => handleExamSave(ev, e, root));
      document.getElementById(`exam-edit-cancel-${e.id}`).addEventListener("click", () => {
        examState.editingId = null;
        drawExamsTab(root);
      });
    }
  });
}

function examNewFormHtml() {
  return `
    <form id="exam-new-form" class="card p-5 mb-4 space-y-3">
      <h3 class="font-bold text-slate-900">Yeni Sınav Ekle</h3>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <input name="name" required class="input" placeholder="Sınav adı" />
        <select name="exam_type" required class="input">${optionsHtml(EXAM_TYPE_LABELS, "", true)}</select>
        <label class="text-xs text-slate-500">Sınav Tarihi<input name="exam_date" type="date" class="input mt-1" /></label>
        <label class="text-xs text-slate-500">Sonuç Tarihi<input name="result_date" type="date" class="input mt-1" /></label>
        <label class="text-xs text-slate-500">Başvuru Başlangıç<input name="application_start" type="date" class="input mt-1" /></label>
        <label class="text-xs text-slate-500">Başvuru Bitiş<input name="application_end" type="date" class="input mt-1" /></label>
        <label class="text-xs text-slate-500">Geç Başvuru Tarihi<input name="late_application_date" type="date" class="input mt-1" /></label>
        <input name="source" class="input" placeholder="Kaynak (örn. ÖSYM)" />
        <input name="source_url" class="input sm:col-span-2" placeholder="Kaynak URL" />
      </div>
      <div class="flex items-center gap-4">
        <label class="text-sm flex items-center gap-2"><input type="checkbox" name="is_active" checked /> Aktif</label>
        <label class="text-xs text-slate-500 flex items-center gap-2">Güven Skoru <input name="confidence" type="number" min="0" max="1" step="0.01" value="1" class="input w-24" /></label>
      </div>
      <div class="flex gap-2">
        <button type="submit" class="btn-primary px-4 py-2 text-sm">Kaydet</button>
        <button type="button" id="exam-new-cancel" class="btn-secondary px-4 py-2 text-sm">Vazgeç</button>
      </div>
    </form>`;
}

function examCardHtml(e) {
  const typeLabel = EXAM_TYPE_LABELS[e.exam_type] || e.exam_type;
  const isEditing = examState.editingId === e.id;
  return `
    <div class="card p-5 fadeIn">
      <div class="flex items-start justify-between gap-3">
        <div class="min-w-0">
          <span class="badge bg-teal-50 text-teal-700">${escapeHtml(typeLabel)}</span>
          ${!e.is_active ? `<span class="badge bg-slate-100 text-slate-500 ml-1">Pasif</span>` : ""}
          <p class="font-bold text-slate-900 mt-2">${escapeHtml(e.name)}</p>
        </div>
        <button id="exam-edit-btn-${e.id}" class="btn-secondary px-3 py-1.5 text-xs shrink-0">${isEditing ? "Kapat" : "Düzenle"}</button>
      </div>
      <div class="grid grid-cols-2 sm:grid-cols-3 gap-x-4 gap-y-1 text-sm text-slate-600 mt-3">
        <div>📅 Sınav: <strong>${fmtDate(e.exam_date)}</strong></div>
        <div>📣 Sonuç: <strong>${fmtDate(e.result_date)}</strong></div>
        <div>📝 Başvuru: <strong>${fmtDate(e.application_start)} – ${fmtDate(e.application_end)}</strong></div>
        <div>⏳ Geç Başvuru: <strong>${fmtDate(e.late_application_date)}</strong></div>
        <div>🎯 Güven: <strong>%${Math.round((e.confidence ?? 1) * 100)}</strong></div>
        <div>🔢 Versiyon: <strong>${e.version ?? 1}</strong></div>
        <div>🕓 Son Doğrulama: <strong>${e.last_verified_at ? timeAgo(e.last_verified_at) : "—"}</strong></div>
        <div class="col-span-2 sm:col-span-3">🔗 Kaynak: <strong>${escapeHtml(e.source || "—")}</strong> ${e.source_url ? `· <a href="${escapeHtml(e.source_url)}" target="_blank" rel="noopener" class="text-teal-600 hover:underline">bağlantı</a>` : ""}</div>
      </div>
      ${isEditing ? examEditFormHtml(e) : ""}
    </div>`;
}

function examEditFormHtml(e) {
  return `
    <form id="exam-edit-form-${e.id}" class="mt-4 pt-4 border-t border-slate-100 space-y-3">
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <input name="name" required class="input" value="${escapeHtml(e.name || "")}" placeholder="Sınav adı" />
        <select name="exam_type" class="input">${optionsHtml(EXAM_TYPE_LABELS, e.exam_type)}</select>
        <label class="text-xs text-slate-500">Sınav Tarihi<input name="exam_date" type="date" class="input mt-1" value="${toDateInputValue(e.exam_date)}" /></label>
        <label class="text-xs text-slate-500">Sonuç Tarihi<input name="result_date" type="date" class="input mt-1" value="${toDateInputValue(e.result_date)}" /></label>
        <label class="text-xs text-slate-500">Başvuru Başlangıç<input name="application_start" type="date" class="input mt-1" value="${toDateInputValue(e.application_start)}" /></label>
        <label class="text-xs text-slate-500">Başvuru Bitiş<input name="application_end" type="date" class="input mt-1" value="${toDateInputValue(e.application_end)}" /></label>
        <label class="text-xs text-slate-500">Geç Başvuru Tarihi<input name="late_application_date" type="date" class="input mt-1" value="${toDateInputValue(e.late_application_date)}" /></label>
        <input name="source" class="input" placeholder="Kaynak" value="${escapeHtml(e.source || "")}" />
        <input name="source_url" class="input sm:col-span-2" placeholder="Kaynak URL" value="${escapeHtml(e.source_url || "")}" />
      </div>
      <div class="flex items-center gap-4">
        <label class="text-sm flex items-center gap-2"><input type="checkbox" name="is_active" ${e.is_active ? "checked" : ""} /> Aktif</label>
        <label class="text-xs text-slate-500 flex items-center gap-2">Güven Skoru <input name="confidence" type="number" min="0" max="1" step="0.01" value="${e.confidence ?? 1}" class="input w-24" /></label>
      </div>
      <div class="flex gap-2">
        <button type="submit" class="btn-primary px-4 py-2 text-sm">Değişiklikleri Kaydet</button>
        <button type="button" id="exam-edit-cancel-${e.id}" class="btn-secondary px-4 py-2 text-sm">Vazgeç</button>
      </div>
    </form>`;
}

async function handleExamCreate(ev, root) {
  ev.preventDefault();
  const fd = new FormData(ev.target);
  const payload = {
    name: fd.get("name"),
    exam_type: fd.get("exam_type"),
    exam_date: fd.get("exam_date") || null,
    application_start: fd.get("application_start") || null,
    application_end: fd.get("application_end") || null,
    late_application_date: fd.get("late_application_date") || null,
    result_date: fd.get("result_date") || null,
    source: fd.get("source") || null,
    source_url: fd.get("source_url") || null,
    confidence: fd.get("confidence") ? Number(fd.get("confidence")) : 1,
    is_active: fd.get("is_active") === "on",
    version: 1,
  };
  const submitBtn = ev.target.querySelector('button[type="submit"]');
  submitBtn.disabled = true;
  const { error } = await supabase.from("exams").insert([payload]);
  submitBtn.disabled = false;
  if (error) {
    toast(error.message, "error");
    return;
  }
  toast("Sınav eklendi.", "success");
  examState.showNew = false;
  await renderExamsTab(root);
}

async function handleExamSave(ev, original, root) {
  ev.preventDefault();
  const fd = new FormData(ev.target);
  const submitBtn = ev.target.querySelector('button[type="submit"]');
  submitBtn.disabled = true;

  const changes = [];
  for (const f of EXAM_TEXT_FIELDS) {
    const newVal = (fd.get(f) || "").trim();
    const oldVal = (original[f] || "").trim();
    if (newVal !== oldVal) changes.push([f, newVal]);
  }
  for (const f of EXAM_DATE_FIELDS) {
    const newVal = fd.get(f) || "";
    const oldVal = toDateInputValue(original[f]);
    if (newVal !== oldVal) changes.push([f, newVal]);
  }
  const newType = fd.get("exam_type");
  if (newType !== original.exam_type) changes.push(["exam_type", newType]);

  const newConfidence = fd.get("confidence") ? Number(fd.get("confidence")) : 1;
  if (Math.abs(newConfidence - (original.confidence ?? 1)) > 0.0001) changes.push(["confidence", String(newConfidence)]);

  const newActive = fd.get("is_active") === "on";
  if (newActive !== !!original.is_active) changes.push(["is_active", String(newActive)]);

  if (changes.length === 0) {
    toast("Değişiklik yapılmadı.", "info");
    submitBtn.disabled = false;
    return;
  }

  for (const [field, value] of changes) {
    const { error } = await supabase.rpc("apply_exam_field_change", {
      p_exam_id: original.id,
      p_field_name: field,
      p_new_value: value,
      p_source: "Admin Paneli",
      p_source_url: null,
      p_confidence: 1.0,
      p_applied_by: "admin",
    });
    if (error) {
      toast(`"${field}" alanı güncellenemedi: ${error.message}`, "error");
      submitBtn.disabled = false;
      return;
    }
  }

  toast(`${changes.length} alan güncellendi.`, "success");
  examState.editingId = null;
  submitBtn.disabled = false;
  await renderExamsTab(root);
}

// ---------------------------------------------------------------------------
// 3) Müfredat
// ---------------------------------------------------------------------------

const curriculumState = { subjects: [], topicsBySubject: new Map(), showNewSubject: false, newTopicFor: null, editingTopic: null };

async function renderCurriculumTab(root) {
  root.innerHTML = skeletonRows(4, "h-40");
  const { data: subjects, error: sErr } = await supabase.from("subjects").select("*").order("exam_type").order("order_index");
  if (sErr) {
    toast(sErr.message, "error");
    root.innerHTML = `<div class="card p-8 text-center text-slate-500">Dersler yüklenemedi.</div>`;
    return;
  }
  curriculumState.subjects = subjects || [];
  const subjectIds = curriculumState.subjects.map((s) => s.id);
  curriculumState.topicsBySubject = new Map();
  if (subjectIds.length) {
    const { data: topics, error: tErr } = await supabase.from("topics").select("*").in("subject_id", subjectIds).order("name");
    if (tErr) {
      toast(tErr.message, "error");
    } else {
      (topics || []).forEach((t) => {
        if (!curriculumState.topicsBySubject.has(t.subject_id)) curriculumState.topicsBySubject.set(t.subject_id, []);
        curriculumState.topicsBySubject.get(t.subject_id).push(t);
      });
    }
  }
  drawCurriculumTab(root);
}

function drawCurriculumTab(root) {
  root.innerHTML = `
    <div class="flex items-center justify-between mb-4">
      <h2 class="text-lg font-bold text-slate-900">Müfredat</h2>
      <button id="subj-new-btn" class="btn-primary px-4 py-2 text-sm">+ Yeni Ders Ekle</button>
    </div>
    <div id="subj-new-form-wrap">${curriculumState.showNewSubject ? subjectNewFormHtml() : ""}</div>
    <div class="space-y-4 mt-4">
      ${curriculumState.subjects.map((s) => subjectCardHtml(s)).join("") || `<div class="card p-8 text-center text-slate-500">Henüz ders eklenmemiş.</div>`}
    </div>`;

  document.getElementById("subj-new-btn").addEventListener("click", () => {
    curriculumState.showNewSubject = !curriculumState.showNewSubject;
    drawCurriculumTab(root);
  });
  if (curriculumState.showNewSubject) {
    document.getElementById("subj-new-form").addEventListener("submit", (ev) => handleSubjectCreate(ev, root));
    document.getElementById("subj-new-cancel").addEventListener("click", () => {
      curriculumState.showNewSubject = false;
      drawCurriculumTab(root);
    });
  }

  curriculumState.subjects.forEach((s) => {
    document.getElementById(`topic-new-btn-${s.id}`)?.addEventListener("click", () => {
      curriculumState.newTopicFor = curriculumState.newTopicFor === s.id ? null : s.id;
      drawCurriculumTab(root);
    });
    if (curriculumState.newTopicFor === s.id) {
      document.getElementById(`topic-new-form-${s.id}`).addEventListener("submit", (ev) => handleTopicCreate(ev, s, root));
      document.getElementById(`topic-new-cancel-${s.id}`).addEventListener("click", () => {
        curriculumState.newTopicFor = null;
        drawCurriculumTab(root);
      });
    }
    (curriculumState.topicsBySubject.get(s.id) || []).forEach((t) => {
      document.getElementById(`topic-edit-btn-${t.id}`)?.addEventListener("click", () => {
        curriculumState.editingTopic = curriculumState.editingTopic === t.id ? null : t.id;
        drawCurriculumTab(root);
      });
      document.getElementById(`topic-remove-btn-${t.id}`)?.addEventListener("click", () => handleTopicRemove(t, root));
      if (curriculumState.editingTopic === t.id) {
        document.getElementById(`topic-edit-form-${t.id}`).addEventListener("submit", (ev) => handleTopicSave(ev, t, root));
        document.getElementById(`topic-edit-cancel-${t.id}`).addEventListener("click", () => {
          curriculumState.editingTopic = null;
          drawCurriculumTab(root);
        });
      }
    });
  });
}

function subjectNewFormHtml() {
  return `
    <form id="subj-new-form" class="card p-5 mb-4 space-y-3">
      <h3 class="font-bold text-slate-900">Yeni Ders Ekle</h3>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <input name="id" class="input" placeholder="ID (boş bırakılırsa otomatik)" />
        <select name="exam_type" required class="input">${optionsHtml(EXAM_TYPE_LABELS, "", true)}</select>
        <input name="name" required class="input" placeholder="Ders adı" />
        <input name="slug" required class="input" placeholder="slug (örn. genel-yetenek)" />
        <input name="icon" class="input" placeholder="İkon (emoji)" />
        <input name="color" class="input" placeholder="Renk (#14b8a6)" />
        <input name="weight" type="number" step="0.01" class="input" placeholder="Ağırlık" />
        <input name="order_index" type="number" class="input" placeholder="Sıra" />
      </div>
      <div class="flex gap-2">
        <button type="submit" class="btn-primary px-4 py-2 text-sm">Kaydet</button>
        <button type="button" id="subj-new-cancel" class="btn-secondary px-4 py-2 text-sm">Vazgeç</button>
      </div>
    </form>`;
}

async function handleSubjectCreate(ev, root) {
  ev.preventDefault();
  const fd = new FormData(ev.target);
  const payload = {
    exam_type: fd.get("exam_type"),
    name: fd.get("name"),
    slug: fd.get("slug"),
    icon: fd.get("icon") || null,
    color: fd.get("color") || null,
    weight: fd.get("weight") ? Number(fd.get("weight")) : null,
    order_index: fd.get("order_index") ? Number(fd.get("order_index")) : null,
  };
  const id = (fd.get("id") || "").trim();
  if (id) payload.id = id;

  const submitBtn = ev.target.querySelector('button[type="submit"]');
  submitBtn.disabled = true;
  const { error } = await supabase.from("subjects").insert([payload]);
  submitBtn.disabled = false;
  if (error) {
    toast(error.message, "error");
    return;
  }
  toast("Ders eklendi.", "success");
  curriculumState.showNewSubject = false;
  await renderCurriculumTab(root);
}

function subjectCardHtml(s) {
  const topics = curriculumState.topicsBySubject.get(s.id) || [];
  const isNewTopic = curriculumState.newTopicFor === s.id;
  return `
    <div class="card p-5 fadeIn">
      <div class="flex items-center justify-between gap-3">
        <div class="flex items-center gap-3 min-w-0">
          <div class="w-10 h-10 rounded-xl flex items-center justify-center text-xl shrink-0" style="background:${s.color || "#14b8a6"}1a;">${escapeHtml(s.icon || "📘")}</div>
          <div class="min-w-0">
            <p class="font-bold text-slate-900 truncate">${escapeHtml(s.name)}</p>
            <p class="text-xs text-slate-400">${escapeHtml(EXAM_TYPE_LABELS[s.exam_type] || s.exam_type)} · ağırlık ${s.weight ?? "—"} · sıra ${s.order_index ?? "—"}</p>
          </div>
        </div>
        <button id="topic-new-btn-${s.id}" class="btn-secondary px-3 py-1.5 text-xs shrink-0">${isNewTopic ? "Kapat" : "+ Konu Ekle"}</button>
      </div>
      ${isNewTopic ? topicNewFormHtml(s) : ""}
      <div class="mt-4 divide-y divide-slate-100">
        ${topics.map((t) => topicRowHtml(t)).join("") || `<p class="text-sm text-slate-400 py-3">Bu derse ait konu yok.</p>`}
      </div>
    </div>`;
}

function topicNewFormHtml(s) {
  return `
    <form id="topic-new-form-${s.id}" class="mt-3 p-4 bg-slate-50 rounded-xl space-y-2">
      <input name="name" required class="input" placeholder="Konu adı" />
      <textarea name="kazanim_text" class="input" rows="2" placeholder="Kazanım metni"></textarea>
      <input name="weight" type="number" step="0.01" class="input" placeholder="Ağırlık" />
      <div class="flex gap-2">
        <button type="submit" class="btn-primary px-4 py-2 text-sm">Ekle</button>
        <button type="button" id="topic-new-cancel-${s.id}" class="btn-secondary px-4 py-2 text-sm">Vazgeç</button>
      </div>
    </form>`;
}

async function handleTopicCreate(ev, subject, root) {
  ev.preventDefault();
  const fd = new FormData(ev.target);
  const submitBtn = ev.target.querySelector('button[type="submit"]');
  submitBtn.disabled = true;
  const { error } = await supabase.rpc("apply_curriculum_change", {
    p_change_type: "added",
    p_subject_id: subject.id,
    p_name: fd.get("name"),
    p_kazanim_text: fd.get("kazanim_text") || null,
    p_weight: fd.get("weight") ? Number(fd.get("weight")) : null,
    p_applied_by: "admin",
  });
  submitBtn.disabled = false;
  if (error) {
    toast(error.message, "error");
    return;
  }
  toast("Konu eklendi.", "success");
  curriculumState.newTopicFor = null;
  await renderCurriculumTab(root);
}

function topicRowHtml(t) {
  const isEditing = curriculumState.editingTopic === t.id;
  return `
    <div class="py-3">
      <div class="flex items-start justify-between gap-3">
        <div class="min-w-0">
          <p class="font-semibold text-slate-800 text-sm">${escapeHtml(t.name)}</p>
          ${t.kazanim_text ? `<p class="text-xs text-slate-500 mt-0.5">${escapeHtml(t.kazanim_text)}</p>` : ""}
          <div class="flex items-center gap-2 mt-1">
            <span class="badge bg-slate-100 text-slate-500">${escapeHtml(TOPIC_STATUS_LABELS[t.status] || t.status)}</span>
            <span class="text-xs text-slate-400">ağırlık ${t.weight ?? "—"}</span>
          </div>
        </div>
        <div class="flex gap-2 shrink-0">
          <button id="topic-edit-btn-${t.id}" class="btn-secondary px-3 py-1.5 text-xs">${isEditing ? "Kapat" : "Düzenle"}</button>
          <button id="topic-remove-btn-${t.id}" class="btn-secondary px-3 py-1.5 text-xs text-rose-600">Kaldır</button>
        </div>
      </div>
      ${isEditing ? topicEditFormHtml(t) : ""}
    </div>`;
}

function topicEditFormHtml(t) {
  return `
    <form id="topic-edit-form-${t.id}" class="mt-3 p-4 bg-slate-50 rounded-xl space-y-2">
      <input name="name" required class="input" value="${escapeHtml(t.name || "")}" placeholder="Konu adı" />
      <textarea name="kazanim_text" class="input" rows="2" placeholder="Kazanım metni">${escapeHtml(t.kazanim_text || "")}</textarea>
      <input name="weight" type="number" step="0.01" class="input" value="${t.weight ?? ""}" placeholder="Ağırlık" />
      <div class="flex gap-2">
        <button type="submit" class="btn-primary px-4 py-2 text-sm">Değişiklikleri Kaydet</button>
        <button type="button" id="topic-edit-cancel-${t.id}" class="btn-secondary px-4 py-2 text-sm">Vazgeç</button>
      </div>
    </form>`;
}

async function handleTopicSave(ev, original, root) {
  ev.preventDefault();
  const fd = new FormData(ev.target);
  const submitBtn = ev.target.querySelector('button[type="submit"]');
  submitBtn.disabled = true;

  const calls = [];
  const newName = (fd.get("name") || "").trim();
  if (newName !== (original.name || "")) {
    calls.push({ p_change_type: "renamed", p_topic_id: original.id, p_name: newName, p_applied_by: "admin" });
  }
  const newKazanim = fd.get("kazanim_text") || "";
  if (newKazanim !== (original.kazanim_text || "")) {
    calls.push({ p_change_type: "kazanim_changed", p_topic_id: original.id, p_kazanim_text: newKazanim, p_applied_by: "admin" });
  }
  const newWeight = fd.get("weight") ? Number(fd.get("weight")) : null;
  if (newWeight !== (original.weight ?? null)) {
    calls.push({ p_change_type: "weight_changed", p_topic_id: original.id, p_weight: newWeight, p_applied_by: "admin" });
  }

  if (calls.length === 0) {
    toast("Değişiklik yapılmadı.", "info");
    submitBtn.disabled = false;
    return;
  }

  for (const params of calls) {
    const { error } = await supabase.rpc("apply_curriculum_change", params);
    if (error) {
      toast(error.message, "error");
      submitBtn.disabled = false;
      return;
    }
  }
  toast("Konu güncellendi.", "success");
  curriculumState.editingTopic = null;
  submitBtn.disabled = false;
  await renderCurriculumTab(root);
}

async function handleTopicRemove(t, root) {
  if (!confirm(`"${t.name}" konusunu kaldırmak istediğinize emin misiniz?`)) return;
  const { error } = await supabase.rpc("apply_curriculum_change", {
    p_change_type: "removed",
    p_topic_id: t.id,
    p_applied_by: "admin",
  });
  if (error) {
    toast(error.message, "error");
    return;
  }
  toast("Konu kaldırıldı.", "success");
  await renderCurriculumTab(root);
}

// ---------------------------------------------------------------------------
// 4) Sorular
// ---------------------------------------------------------------------------

const questionsState = { subjects: [], topics: [], selectedTopic: "", questions: [], choicesByQuestion: new Map(), showNew: false };

async function renderQuestionsTab(root) {
  root.innerHTML = skeletonRows(3, "h-24");
  const [{ data: subjects, error: sErr }, { data: topics, error: tErr }] = await Promise.all([
    supabase.from("subjects").select("id, name").order("name"),
    supabase.from("topics").select("id, name, subject_id").order("name"),
  ]);
  if (sErr || tErr) {
    toast((sErr || tErr).message, "error");
    root.innerHTML = `<div class="card p-8 text-center text-slate-500">Konular yüklenemedi.</div>`;
    return;
  }
  questionsState.subjects = subjects || [];
  questionsState.topics = topics || [];
  drawQuestionsTab(root);
}

function topicOptionsGrouped(selected) {
  const bySubject = new Map();
  questionsState.topics.forEach((t) => {
    if (!bySubject.has(t.subject_id)) bySubject.set(t.subject_id, []);
    bySubject.get(t.subject_id).push(t);
  });
  return questionsState.subjects.map((s) => {
    const ts = bySubject.get(s.id) || [];
    if (!ts.length) return "";
    return `<optgroup label="${escapeHtml(s.name)}">${ts.map((t) => `<option value="${t.id}" ${t.id === selected ? "selected" : ""}>${escapeHtml(t.name)}</option>`).join("")}</optgroup>`;
  }).join("");
}

function drawQuestionsTab(root) {
  root.innerHTML = `
    <div class="flex flex-wrap items-center justify-between gap-3 mb-4">
      <h2 class="text-lg font-bold text-slate-900">Sorular</h2>
      <div class="flex items-center gap-2">
        <select id="q-topic-select" class="input w-64">
          <option value="">— Konu seçin —</option>
          ${topicOptionsGrouped(questionsState.selectedTopic)}
        </select>
        <button id="q-new-btn" class="btn-primary px-4 py-2 text-sm">+ Yeni Soru</button>
      </div>
    </div>
    <div id="q-new-form-wrap">${questionsState.showNew ? questionNewFormHtml() : ""}</div>
    <div id="q-list" class="space-y-3 mt-4"></div>`;

  document.getElementById("q-topic-select").addEventListener("change", (ev) => {
    questionsState.selectedTopic = ev.target.value;
    loadQuestionsForTopic(root);
  });
  document.getElementById("q-new-btn").addEventListener("click", () => {
    questionsState.showNew = !questionsState.showNew;
    drawQuestionsTab(root);
  });
  if (questionsState.showNew) {
    document.getElementById("q-new-form").addEventListener("submit", (ev) => handleQuestionCreate(ev, root));
    document.getElementById("q-new-cancel").addEventListener("click", () => {
      questionsState.showNew = false;
      drawQuestionsTab(root);
    });
  }

  if (questionsState.selectedTopic) {
    loadQuestionsForTopic(root);
  } else {
    document.getElementById("q-list").innerHTML = `<div class="card p-8 text-center text-slate-500">Soruları görmek için bir konu seçin.</div>`;
  }
}

function questionNewFormHtml() {
  return `
    <form id="q-new-form" class="card p-5 mb-4 space-y-3">
      <h3 class="font-bold text-slate-900">Yeni Soru Ekle</h3>
      <select name="topic_id" required class="input">
        <option value="">— Konu seçin —</option>
        ${topicOptionsGrouped(questionsState.selectedTopic)}
      </select>
      <select name="difficulty" required class="input">${optionsHtml(DIFFICULTY_LABELS, "orta")}</select>
      <textarea name="question_text" required class="input" rows="3" placeholder="Soru metni"></textarea>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <input name="kazanim" class="input" placeholder="Kazanım" />
        <input name="kaynak" class="input" placeholder="Kaynak" />
      </div>
      <textarea name="explanation" class="input" rows="2" placeholder="Açıklama"></textarea>
      <textarea name="detailed_solution" class="input" rows="2" placeholder="Detaylı çözüm"></textarea>
      <input name="video_solution_url" class="input" placeholder="Video çözüm URL" />
      <div class="space-y-2">
        <p class="text-xs font-semibold text-slate-500">Şıklar (5 şık, gerçek KPSS formatı — doğru olanı işaretleyin)</p>
        ${CHOICE_LETTERS.map((letter, i) => `
          <div class="flex items-center gap-2">
            <input type="radio" name="correct_choice" value="${i}" ${i === 0 ? "checked" : ""} required />
            <input name="choice_${i}" required class="input" placeholder="Şık ${letter}" />
          </div>`).join("")}
      </div>
      <div class="flex gap-2">
        <button type="submit" class="btn-primary px-4 py-2 text-sm">Kaydet</button>
        <button type="button" id="q-new-cancel" class="btn-secondary px-4 py-2 text-sm">Vazgeç</button>
      </div>
    </form>`;
}

async function handleQuestionCreate(ev, root) {
  ev.preventDefault();
  const fd = new FormData(ev.target);
  const submitBtn = ev.target.querySelector('button[type="submit"]');
  submitBtn.disabled = true;

  const questionPayload = {
    topic_id: fd.get("topic_id"),
    difficulty: fd.get("difficulty"),
    question_text: fd.get("question_text"),
    kazanim: fd.get("kazanim") || null,
    kaynak: fd.get("kaynak") || null,
    explanation: fd.get("explanation") || null,
    detailed_solution: fd.get("detailed_solution") || null,
    video_solution_url: fd.get("video_solution_url") || null,
  };

  const { data: inserted, error: qErr } = await supabase.from("questions").insert([questionPayload]).select("id").single();
  if (qErr) {
    toast(qErr.message, "error");
    submitBtn.disabled = false;
    return;
  }

  const correctIdx = Number(fd.get("correct_choice"));
  const choices = CHOICE_LETTERS.map((_, i) => ({
    question_id: inserted.id,
    choice_text: fd.get(`choice_${i}`),
    is_correct: i === correctIdx,
    order_index: i,
  }));
  const { error: cErr } = await supabase.from("question_choices").insert(choices);
  submitBtn.disabled = false;
  if (cErr) {
    toast(cErr.message, "error");
    return;
  }

  toast("Soru eklendi.", "success");
  questionsState.showNew = false;
  questionsState.selectedTopic = questionPayload.topic_id;
  drawQuestionsTab(root);
}

async function loadQuestionsForTopic(root) {
  const listEl = document.getElementById("q-list");
  listEl.innerHTML = skeletonRows(3, "h-28");

  const { data: questions, error: qErr } = await supabase
    .from("questions")
    .select("*")
    .eq("topic_id", questionsState.selectedTopic)
    .order("created_at", { ascending: false });
  if (qErr) {
    toast(qErr.message, "error");
    listEl.innerHTML = `<div class="card p-8 text-center text-slate-500">Sorular yüklenemedi.</div>`;
    return;
  }
  questionsState.questions = questions || [];
  questionsState.choicesByQuestion = new Map();

  const ids = questionsState.questions.map((q) => q.id);
  if (ids.length) {
    const { data: choices, error: cErr } = await supabase.from("question_choices").select("*").in("question_id", ids);
    if (cErr) {
      toast(cErr.message, "error");
    } else {
      (choices || []).forEach((c) => {
        if (!questionsState.choicesByQuestion.has(c.question_id)) questionsState.choicesByQuestion.set(c.question_id, []);
        questionsState.choicesByQuestion.get(c.question_id).push(c);
      });
    }
  }

  if (!questionsState.questions.length) {
    listEl.innerHTML = `<div class="card p-8 text-center text-slate-500">Bu konuda henüz soru yok.</div>`;
    return;
  }

  listEl.innerHTML = questionsState.questions.map((q) => {
    const choices = [...(questionsState.choicesByQuestion.get(q.id) || [])].sort((a, b) => a.order_index - b.order_index);
    return `
      <div class="card p-5 fadeIn">
        <div class="flex items-start justify-between gap-3">
          <div class="min-w-0">
            <span class="badge bg-teal-50 text-teal-700">${escapeHtml(DIFFICULTY_LABELS[q.difficulty] || q.difficulty)}</span>
            ${q.kazanim ? `<span class="text-xs text-slate-400 ml-2">${escapeHtml(q.kazanim)}</span>` : ""}
            ${choices.length !== 5 ? `<span class="badge bg-amber-50 text-amber-700 ml-2">${choices.length} şık</span>` : ""}
            <p class="font-semibold text-slate-900 mt-2 whitespace-pre-line">${escapeHtml(q.question_text)}</p>
          </div>
          <button data-qid="${q.id}" class="q-delete-btn btn-secondary px-3 py-1.5 text-xs text-rose-600 shrink-0">Sil</button>
        </div>
        <div class="mt-3 space-y-1">
          ${choices.map((c, i) => `
            <div class="text-sm px-3 py-1.5 rounded-lg ${c.is_correct ? "bg-emerald-50 text-emerald-700 font-semibold" : "bg-slate-50 text-slate-600"}">
              ${CHOICE_LETTERS[i] || ""}) ${c.is_correct ? "✓ " : ""}${escapeHtml(c.choice_text)}
            </div>`).join("")}
        </div>
        ${q.kaynak ? `<p class="text-xs text-slate-400 mt-2">Kaynak: ${escapeHtml(q.kaynak)}</p>` : ""}
      </div>`;
  }).join("");

  listEl.querySelectorAll(".q-delete-btn").forEach((btn) => {
    btn.addEventListener("click", () => handleQuestionDelete(btn.dataset.qid, root));
  });
}

async function handleQuestionDelete(id, root) {
  if (!confirm("Bu soruyu silmek istediğinize emin misiniz?")) return;
  await supabase.from("question_choices").delete().eq("question_id", id);
  const { error } = await supabase.from("questions").delete().eq("id", id);
  if (error) {
    toast(error.message, "error");
    return;
  }
  toast("Soru silindi.", "success");
  loadQuestionsForTopic(root);
}

// ---------------------------------------------------------------------------
// 5) Haberler
// ---------------------------------------------------------------------------

const newsState = { list: [], showNew: false };
const AI_CONTENT_TYPE_LABELS = { flashcard: "Bilgi Kartı", summary: "Özet", question: "Soru" };

async function renderNewsTab(root) {
  root.innerHTML = skeletonRows(4, "h-28");
  const { data, error } = await supabase.from("news_items").select("*").order("created_at", { ascending: false }).limit(100);
  if (error) {
    toast(error.message, "error");
    root.innerHTML = `<div class="card p-8 text-center text-slate-500">Haberler yüklenemedi.</div>`;
    return;
  }
  newsState.list = data || [];
  drawNewsTab(root);
}

function drawNewsTab(root) {
  root.innerHTML = `
    <div class="flex items-center justify-between mb-4">
      <h2 class="text-lg font-bold text-slate-900">Haberler</h2>
      <button id="news-new-btn" class="btn-primary px-4 py-2 text-sm">+ Yeni Haber</button>
    </div>
    <div id="news-new-form-wrap">${newsState.showNew ? newsNewFormHtml() : ""}</div>
    <div class="space-y-3 mt-4">
      ${newsState.list.map((n) => newsRowHtml(n)).join("") || `<div class="card p-8 text-center text-slate-500">Henüz haber eklenmemiş.</div>`}
    </div>`;

  document.getElementById("news-new-btn").addEventListener("click", () => {
    newsState.showNew = !newsState.showNew;
    drawNewsTab(root);
  });
  if (newsState.showNew) {
    document.getElementById("news-new-form").addEventListener("submit", (ev) => handleNewsCreate(ev, root));
    document.getElementById("news-new-cancel").addEventListener("click", () => {
      newsState.showNew = false;
      drawNewsTab(root);
    });
  }
  newsState.list.forEach((n) => {
    document.getElementById(`news-draft-btn-${n.id}`)?.addEventListener("click", () => handleGenerateDraft(n));
  });
}

function newsNewFormHtml() {
  return `
    <form id="news-new-form" class="card p-5 mb-4 space-y-3">
      <h3 class="font-bold text-slate-900">Yeni Haber Ekle</h3>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <select name="category" required class="input">${optionsHtml(NEWS_CATEGORY_LABELS, "", true)}</select>
        <select name="source_trust" required class="input">
          <option value="resmi">Resmi</option>
          <option value="destekleyici">Destekleyici</option>
        </select>
      </div>
      <input name="title" required class="input" placeholder="Başlık" />
      <textarea name="summary" class="input" rows="2" placeholder="Özet"></textarea>
      <textarea name="body" class="input" rows="4" placeholder="İçerik"></textarea>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <input name="source" class="input" placeholder="Kaynak" />
        <input name="source_url" class="input" placeholder="Kaynak URL" />
      </div>
      <label class="text-sm flex items-center gap-2"><input type="checkbox" name="is_learning_content" /> Öğrenme içeriği olarak işaretle</label>
      <div class="flex gap-2">
        <button type="submit" class="btn-primary px-4 py-2 text-sm">Kaydet</button>
        <button type="button" id="news-new-cancel" class="btn-secondary px-4 py-2 text-sm">Vazgeç</button>
      </div>
    </form>`;
}

async function handleNewsCreate(ev, root) {
  ev.preventDefault();
  const fd = new FormData(ev.target);
  const payload = {
    category: fd.get("category"),
    title: fd.get("title"),
    summary: fd.get("summary") || null,
    body: fd.get("body") || null,
    source: fd.get("source") || null,
    source_url: fd.get("source_url") || null,
    source_trust: fd.get("source_trust"),
    is_learning_content: fd.get("is_learning_content") === "on",
  };
  const submitBtn = ev.target.querySelector('button[type="submit"]');
  submitBtn.disabled = true;
  const { error } = await supabase.from("news_items").insert([payload]);
  submitBtn.disabled = false;
  if (error) {
    toast(error.message, "error");
    return;
  }
  toast("Haber eklendi.", "success");
  newsState.showNew = false;
  await renderNewsTab(root);
}

function newsRowHtml(n) {
  return `
    <div class="card p-4 fadeIn">
      <div class="flex items-start justify-between gap-3">
        <div class="min-w-0">
          <span class="badge bg-teal-50 text-teal-700">${escapeHtml(NEWS_CATEGORY_LABELS[n.category] || n.category)}</span>
          ${n.source_trust ? `<span class="badge ${n.source_trust === "resmi" ? "bg-emerald-50 text-emerald-700" : "bg-amber-50 text-amber-700"} ml-1">${n.source_trust === "resmi" ? "Resmi" : "Destekleyici"}</span>` : ""}
          ${n.is_learning_content ? `<span class="badge bg-sky-50 text-sky-700 ml-1">Öğrenme İçeriği</span>` : ""}
          <p class="font-bold text-slate-900 mt-2">${escapeHtml(n.title)}</p>
          ${n.summary ? `<p class="text-sm text-slate-500 mt-1">${escapeHtml(n.summary)}</p>` : ""}
          <p class="text-xs text-slate-400 mt-1">${fmtDateTime(n.created_at)} ${n.source ? "· " + escapeHtml(n.source) : ""}</p>
        </div>
      </div>
      <div class="flex items-center gap-2 mt-3 pt-3 border-t border-slate-100">
        <select id="news-draft-type-${n.id}" class="input w-40 text-xs py-1.5">
          ${optionsHtml(AI_CONTENT_TYPE_LABELS, "flashcard")}
        </select>
        <button id="news-draft-btn-${n.id}" data-news-id="${n.id}" class="btn-secondary px-3 py-1.5 text-xs">Taslak Oluştur</button>
      </div>
    </div>`;
}

async function handleGenerateDraft(n) {
  const contentType = document.getElementById(`news-draft-type-${n.id}`).value;
  const btn = document.getElementById(`news-draft-btn-${n.id}`);
  btn.disabled = true;
  const { error } = await supabase.rpc("generate_ai_draft_from_news", { p_news_id: n.id, p_content_type: contentType });
  btn.disabled = false;
  if (error) {
    toast(error.message, "error");
    return;
  }
  toast("Taslak oluşturuldu, AI Onay Kuyruğu sekmesinde incele.", "success");
}

// ---------------------------------------------------------------------------
// 6) AI Onay Kuyruğu
// ---------------------------------------------------------------------------

const aiQueueState = { list: [] };

async function renderAiQueueTab(root) {
  root.innerHTML = skeletonRows(3, "h-32");
  const { data, error } = await supabase
    .from("ai_content_queue")
    .select("*, news_items(title)")
    .eq("status", "ai_generated")
    .order("id", { ascending: false });
  if (error) {
    toast(error.message, "error");
    root.innerHTML = `<div class="card p-8 text-center text-slate-500">AI kuyruğu yüklenemedi.</div>`;
    return;
  }
  aiQueueState.list = data || [];
  drawAiQueueTab(root);
}

function draftPreviewHtml(item) {
  const d = item.draft_content || {};
  if (item.content_type === "flashcard") {
    return `<p class="text-sm"><strong>Ön yüz:</strong> ${escapeHtml(d.front || "")}</p><p class="text-sm mt-1"><strong>Arka yüz:</strong> ${escapeHtml(d.back || "")}</p>`;
  }
  if (item.content_type === "summary") {
    return `<p class="text-sm">${escapeHtml(d.summary || "")}</p>`;
  }
  if (item.content_type === "question") {
    return `<p class="text-sm"><strong>Soru:</strong> ${escapeHtml(d.question_text || "")}</p>${d.source_hint ? `<p class="text-xs text-slate-400 mt-1">İpucu: ${escapeHtml(d.source_hint)}</p>` : ""}`;
  }
  return `<pre class="text-xs bg-slate-50 rounded-lg p-3 overflow-auto">${escapeHtml(JSON.stringify(d, null, 2))}</pre>`;
}

function drawAiQueueTab(root) {
  root.innerHTML = `
    <div class="card p-4 mb-4 bg-amber-50 border-amber-200 text-amber-800 text-sm font-medium">
      ⚠️ AI tarafından oluşturulan içerik, siz onaylamadan asla öğrencilere gösterilmez.
    </div>
    <div id="ai-queue-list" class="space-y-3">
      ${aiQueueState.list.map((item) => `
        <div id="ai-item-${item.id}" class="card p-5 fadeIn">
          <div class="flex items-start justify-between gap-3">
            <div class="min-w-0">
              <span class="badge bg-sky-50 text-sky-700">${escapeHtml(AI_CONTENT_TYPE_LABELS[item.content_type] || item.content_type)}</span>
              <p class="text-xs text-slate-400 mt-1">Kaynak haber: ${escapeHtml(item.news_items?.title || "—")}</p>
              <div class="mt-2">${draftPreviewHtml(item)}</div>
            </div>
          </div>
          <div class="flex gap-2 mt-4 pt-3 border-t border-slate-100">
            <button data-id="${item.id}" class="ai-approve-btn btn-primary px-4 py-2 text-sm">Onayla</button>
            <button data-id="${item.id}" class="ai-reject-btn btn-secondary px-4 py-2 text-sm text-rose-600">Reddet</button>
          </div>
        </div>`).join("") || `<div class="card p-8 text-center text-slate-500">Bekleyen AI içeriği yok.</div>`}
    </div>`;

  root.querySelectorAll(".ai-approve-btn").forEach((btn) => btn.addEventListener("click", () => handleAiAction(btn.dataset.id, "approve", root)));
  root.querySelectorAll(".ai-reject-btn").forEach((btn) => btn.addEventListener("click", () => handleAiAction(btn.dataset.id, "reject", root)));
}

async function handleAiAction(id, action, root) {
  const rpcName = action === "approve" ? "approve_ai_content" : "reject_ai_content";
  const { error } = await supabase.rpc(rpcName, { p_id: id });
  if (error) {
    toast(error.message, "error");
    return;
  }
  toast(action === "approve" ? "İçerik onaylandı ve yayınlandı." : "İçerik reddedildi.", "success");
  aiQueueState.list = aiQueueState.list.filter((i) => String(i.id) !== String(id));
  drawAiQueueTab(root);
}

// ---------------------------------------------------------------------------
// 7) Veri Kaynakları / Sync Monitor
// ---------------------------------------------------------------------------

async function renderSyncTab(root) {
  root.innerHTML = skeletonRows(4, "h-20");
  await loadSyncTab(root);
}

async function loadSyncTab(root) {
  const [{ data: sources, error: srcErr }, { data: log, error: logErr }] = await Promise.all([
    supabase.from("data_sources").select("*").order("name"),
    supabase.from("sync_log").select("*, data_sources(name)").order("checked_at", { ascending: false }).limit(30),
  ]);
  if (srcErr || logErr) {
    toast((srcErr || logErr).message, "error");
    root.innerHTML = `<div class="card p-8 text-center text-slate-500">Veri kaynakları yüklenemedi.</div>`;
    return;
  }

  root.innerHTML = `
    <div class="flex items-center justify-between mb-4">
      <h2 class="text-lg font-bold text-slate-900">Veri Kaynakları</h2>
      <button id="sync-all-btn" class="btn-primary px-4 py-2 text-sm">🔄 Tümünü Senkronize Et</button>
    </div>
    <div class="space-y-3">
      ${(sources || []).map((s) => sourceRowHtml(s)).join("") || `<div class="card p-8 text-center text-slate-500">Kayıtlı veri kaynağı yok.</div>`}
    </div>

    <h3 class="text-base font-bold text-slate-900 mt-8 mb-3">Son Aktiviteler</h3>
    <div class="card overflow-x-auto">
      <table class="w-full text-sm">
        <thead class="bg-slate-50 text-slate-500 text-xs uppercase">
          <tr>
            <th class="text-left px-4 py-2">Kaynak</th>
            <th class="text-left px-4 py-2">Kontrol Zamanı</th>
            <th class="text-left px-4 py-2">Durum</th>
            <th class="text-left px-4 py-2">Özet</th>
            <th class="text-left px-4 py-2">Güven</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-slate-100">
          ${(log || []).map((l) => `
            <tr>
              <td class="px-4 py-2 font-medium text-slate-700">${escapeHtml(l.data_sources?.name || "—")}</td>
              <td class="px-4 py-2 text-slate-500">${fmtDateTime(l.checked_at)}</td>
              <td class="px-4 py-2">${badge(l.status || "—", SYNC_STATUS_COLORS[l.status] || "#64748b")}</td>
              <td class="px-4 py-2 text-slate-500">${escapeHtml(l.diff_summary || "—")}</td>
              <td class="px-4 py-2 text-slate-500">${l.confidence != null ? `%${Math.round(l.confidence * 100)}` : "—"}</td>
            </tr>`).join("") || `<tr><td colspan="5" class="px-4 py-6 text-center text-slate-400">Aktivite kaydı yok.</td></tr>`}
        </tbody>
      </table>
    </div>`;

  document.getElementById("sync-all-btn").addEventListener("click", () => handleSyncNow(null, root));
  root.querySelectorAll(".sync-now-btn").forEach((btn) => btn.addEventListener("click", () => handleSyncNow(btn.dataset.id, root)));
}

function sourceRowHtml(s) {
  const statusColor = SYNC_STATUS_COLORS[s.last_status] || "#64748b";
  return `
    <div class="card p-4 flex flex-wrap items-center justify-between gap-3">
      <div class="min-w-0">
        <p class="font-bold text-slate-900">${escapeHtml(s.name)}</p>
        <a href="${escapeHtml(s.url || "#")}" target="_blank" rel="noopener" class="text-xs text-teal-600 hover:underline truncate block max-w-md">${escapeHtml(s.url || "—")}</a>
        <div class="flex items-center gap-2 mt-1.5">
          <span class="badge bg-slate-100 text-slate-600">${escapeHtml(s.source_type || "—")}</span>
          ${badge(s.last_status || "bilinmiyor", statusColor)}
          <span class="text-xs text-slate-400">${s.last_checked_at ? timeAgo(s.last_checked_at) : "Hiç kontrol edilmedi"}</span>
        </div>
      </div>
      <button data-id="${s.id}" class="sync-now-btn btn-secondary px-4 py-2 text-sm shrink-0">Şimdi Senkronize Et</button>
    </div>`;
}

async function handleSyncNow(sourceId, root) {
  const body = sourceId ? { source_id: sourceId } : {};
  const btn = sourceId
    ? document.querySelector(`.sync-now-btn[data-id="${sourceId}"]`)
    : document.getElementById("sync-all-btn");
  if (btn) btn.disabled = true;

  const { data, error } = await supabase.functions.invoke("sync-engine", { body });

  if (btn) btn.disabled = false;
  if (error) {
    toast(error.message || "Senkronizasyon başarısız oldu.", "error");
    return;
  }
  const summary = typeof data === "object" ? JSON.stringify(data) : String(data);
  toast(`Senkronizasyon tamamlandı: ${summary}`, "success");
  await loadSyncTab(root);
}

// ---------------------------------------------------------------------------
// 8) Audit Log
// ---------------------------------------------------------------------------

const auditState = { list: [], expanded: new Set() };

async function renderAuditTab(root) {
  root.innerHTML = skeletonRows(6, "h-12");
  const { data, error } = await supabase.from("admin_audit_log").select("*").order("created_at", { ascending: false }).limit(100);
  if (error) {
    toast(error.message, "error");
    root.innerHTML = `<div class="card p-8 text-center text-slate-500">Audit log yüklenemedi.</div>`;
    return;
  }
  auditState.list = data || [];
  drawAuditTab(root);
}

function drawAuditTab(root) {
  root.innerHTML = `
    <h2 class="text-lg font-bold text-slate-900 mb-4">Audit Log</h2>
    <div class="card overflow-x-auto">
      <table class="w-full text-sm">
        <thead class="bg-slate-50 text-slate-500 text-xs uppercase">
          <tr>
            <th class="text-left px-4 py-2">Zaman</th>
            <th class="text-left px-4 py-2">Aktör</th>
            <th class="text-left px-4 py-2">Eylem</th>
            <th class="text-left px-4 py-2">Tablo</th>
            <th class="text-left px-4 py-2">Kayıt</th>
            <th class="text-left px-4 py-2"></th>
          </tr>
        </thead>
        <tbody class="divide-y divide-slate-100">
          ${auditState.list.map((row) => auditRowsHtml(row)).join("") || `<tr><td colspan="6" class="px-4 py-6 text-center text-slate-400">Kayıt yok.</td></tr>`}
        </tbody>
      </table>
    </div>`;

  auditState.list.forEach((row) => {
    document.getElementById(`audit-toggle-${row.id}`)?.addEventListener("click", () => {
      if (auditState.expanded.has(row.id)) auditState.expanded.delete(row.id);
      else auditState.expanded.add(row.id);
      drawAuditTab(root);
    });
  });
}

function auditRowsHtml(row) {
  const isExpanded = auditState.expanded.has(row.id);
  const actorColor = row.actor_type === "admin" ? "#14b8a6" : "#0891b2";
  const idShort = row.record_id ? String(row.record_id).slice(0, 8) + "…" : "—";
  const main = `
    <tr>
      <td class="px-4 py-2 text-slate-500 whitespace-nowrap">${fmtDateTime(row.created_at)}</td>
      <td class="px-4 py-2">${badge(row.actor_type || "—", actorColor)}</td>
      <td class="px-4 py-2 font-medium text-slate-700">${escapeHtml(row.action || "—")}</td>
      <td class="px-4 py-2 text-slate-500">${escapeHtml(row.table_name || "—")}</td>
      <td class="px-4 py-2 text-slate-400 font-mono text-xs">${escapeHtml(idShort)}</td>
      <td class="px-4 py-2"><button id="audit-toggle-${row.id}" class="text-teal-600 text-xs font-semibold hover:underline">${isExpanded ? "Gizle" : "Detay"}</button></td>
    </tr>`;
  const detail = isExpanded ? `
    <tr>
      <td colspan="6" class="px-4 py-3 bg-slate-50">
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
          <div>
            <p class="text-xs font-bold text-slate-400 mb-1">ESKİ (OLD)</p>
            <pre class="text-xs bg-white border border-slate-200 rounded-lg p-3 overflow-auto max-h-64">${escapeHtml(JSON.stringify(row.old_data ?? null, null, 2))}</pre>
          </div>
          <div>
            <p class="text-xs font-bold text-slate-400 mb-1">YENİ (NEW)</p>
            <pre class="text-xs bg-white border border-slate-200 rounded-lg p-3 overflow-auto max-h-64">${escapeHtml(JSON.stringify(row.new_data ?? null, null, 2))}</pre>
          </div>
        </div>
      </td>
    </tr>` : "";
  return main + detail;
}

// ---------------------------------------------------------------------------
// 9) Öğrenciler
// ---------------------------------------------------------------------------

const studentsState = { list: [], search: "" };

async function renderStudentsTab(root) {
  root.innerHTML = skeletonRows(6, "h-12");
  const { data: students, error: sErr } = await supabase.from("students").select("*, profiles(full_name, email)");
  if (sErr) {
    toast(sErr.message, "error");
    root.innerHTML = `<div class="card p-8 text-center text-slate-500">Öğrenciler yüklenemedi.</div>`;
    return;
  }
  const userIds = (students || []).map((s) => s.user_id).filter(Boolean);
  let gamiByUser = new Map();
  if (userIds.length) {
    const { data: gami, error: gErr } = await supabase.from("user_gamification").select("user_id, current_streak, xp").in("user_id", userIds);
    if (gErr) toast(gErr.message, "error");
    gamiByUser = new Map((gami || []).map((g) => [g.user_id, g]));
  }
  studentsState.list = (students || []).map((s) => ({ ...s, gami: gamiByUser.get(s.user_id) }));
  drawStudentsTab(root);
}

function drawStudentsTab(root) {
  const q = studentsState.search.trim().toLowerCase();
  const filtered = q
    ? studentsState.list.filter((s) => (s.profiles?.full_name || "").toLowerCase().includes(q) || (s.profiles?.email || "").toLowerCase().includes(q))
    : studentsState.list;

  root.innerHTML = `
    <div class="flex items-center justify-between mb-4 gap-3">
      <h2 class="text-lg font-bold text-slate-900">Öğrenciler (${studentsState.list.length})</h2>
      <input id="student-search" class="input max-w-xs" placeholder="İsim veya e-posta ara..." value="${escapeHtml(studentsState.search)}" />
    </div>
    <div class="card overflow-x-auto">
      <table class="w-full text-sm">
        <thead class="bg-slate-50 text-slate-500 text-xs uppercase">
          <tr>
            <th class="text-left px-4 py-2">İsim</th>
            <th class="text-left px-4 py-2">E-posta</th>
            <th class="text-left px-4 py-2">Sınav Türü</th>
            <th class="text-left px-4 py-2">Hedef Puan</th>
            <th class="text-left px-4 py-2">Onboarding</th>
            <th class="text-left px-4 py-2">Seri</th>
            <th class="text-left px-4 py-2">XP</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-slate-100">
          ${filtered.map((s) => `
            <tr>
              <td class="px-4 py-2 font-medium text-slate-700">${escapeHtml(s.profiles?.full_name || "İsimsiz")}</td>
              <td class="px-4 py-2 text-slate-500">${escapeHtml(s.profiles?.email || "—")}</td>
              <td class="px-4 py-2">${s.exam_type ? badge(EXAM_TYPE_LABELS[s.exam_type] || s.exam_type, "#14b8a6") : "—"}</td>
              <td class="px-4 py-2 text-slate-500">${s.target_score ?? "—"}</td>
              <td class="px-4 py-2">${s.onboarding_completed ? badge("Tamamlandı", "#059669") : badge("Devam ediyor", "#d97706")}</td>
              <td class="px-4 py-2 text-slate-500">🔥 ${s.gami?.current_streak ?? 0}</td>
              <td class="px-4 py-2 text-slate-500">✨ ${s.gami?.xp ?? 0}</td>
            </tr>`).join("") || `<tr><td colspan="7" class="px-4 py-6 text-center text-slate-400">Sonuç bulunamadı.</td></tr>`}
        </tbody>
      </table>
    </div>`;

  const searchInput = document.getElementById("student-search");
  searchInput.addEventListener("input", (ev) => {
    studentsState.search = ev.target.value;
    drawStudentsTab(root);
    document.getElementById("student-search").focus();
    document.getElementById("student-search").selectionStart = document.getElementById("student-search").value.length;
  });
}

// ---------------------------------------------------------------------------
// 10) Bildirim Gönder
// ---------------------------------------------------------------------------

async function renderNotifyTab(root) {
  root.innerHTML = `
    <h2 class="text-lg font-bold text-slate-900 mb-4">Bildirim Gönder</h2>
    <form id="notify-form" class="card p-5 space-y-3 max-w-2xl">
      <input name="title" required class="input" placeholder="Başlık" />
      <textarea name="body" class="input" rows="3" placeholder="Mesaj"></textarea>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <label class="text-xs text-slate-500">Öncelik
          <select name="priority" class="input mt-1">${optionsHtml(NOTIFICATION_PRIORITY_LABELS, "onemli")}</select>
        </label>
        <label class="text-xs text-slate-500">Olay Türü
          <select name="event_type" class="input mt-1">${optionsHtml(EVENT_TYPE_LABELS, "NEW_OFFICIAL_NEWS")}</select>
        </label>
      </div>
      <label class="text-xs text-slate-500">Hedef Kitle
        <select name="exam_type" class="input mt-1">
          <option value="">Tümü</option>
          ${optionsHtml(EXAM_TYPE_LABELS, "")}
        </select>
      </label>
      <button type="submit" class="btn-primary px-5 py-2.5 text-sm">Gönder</button>
    </form>`;

  document.getElementById("notify-form").addEventListener("submit", handleNotifySubmit);
}

async function handleNotifySubmit(ev) {
  ev.preventDefault();
  const fd = new FormData(ev.target);
  const submitBtn = ev.target.querySelector('button[type="submit"]');
  submitBtn.disabled = true;

  const examType = fd.get("exam_type") || null;
  let query = supabase.from("students").select("user_id");
  if (examType) query = query.eq("exam_type", examType);
  const { data: students, error: sErr } = await query;
  if (sErr) {
    toast(sErr.message, "error");
    submitBtn.disabled = false;
    return;
  }
  const userIds = [...new Set((students || []).map((s) => s.user_id).filter(Boolean))];
  if (!userIds.length) {
    toast("Hedef kitlede öğrenci bulunamadı.", "info");
    submitBtn.disabled = false;
    return;
  }

  const rows = userIds.map((uid) => ({
    user_id: uid,
    title: fd.get("title"),
    body: fd.get("body") || null,
    priority: fd.get("priority"),
    event_type: fd.get("event_type"),
  }));

  const { error } = await supabase.from("notifications").insert(rows);
  submitBtn.disabled = false;
  if (error) {
    toast(error.message, "error");
    return;
  }
  toast(`${userIds.length} öğrenciye bildirim gönderildi.`, "success");
  ev.target.reset();
}

// ---------------------------------------------------------------------------
// Router table + init
// ---------------------------------------------------------------------------

const RENDERERS = {
  overview: renderOverview,
  exams: renderExamsTab,
  curriculum: renderCurriculumTab,
  questions: renderQuestionsTab,
  news: renderNewsTab,
  aiqueue: renderAiQueueTab,
  sync: renderSyncTab,
  audit: renderAuditTab,
  students: renderStudentsTab,
  notify: renderNotifyTab,
};

renderTabsNav();
renderActiveTab();
