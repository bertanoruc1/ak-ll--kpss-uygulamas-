import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js?v=3";
import { toast, escapeHtml, scoreColor, LEVEL_LABELS } from "./ui.js?v=2";

const auth = await requireAuth();
if (!auth) throw new Error("not authenticated");
const { user, student } = auth;
// Savunma amaçlı: student satırı her hangi bir nedenle hâlâ eksikse (ör. veritabanı
// migration'ları henüz push edilmemişse), sayfa sonsuz iskelet (skeleton) halinde
// takılı kalmak yerine makul bir varsayılanla devam etsin.
const studentExamType = student?.exam_type || "kpss_lisans";

mountNav("subjects.html");

const params = new URLSearchParams(window.location.search);
const subjectId = params.get("subject");

const contentEl = document.getElementById("content");
const headerEl = document.getElementById("page-header");
const errorEl = document.getElementById("error-state");

function showError() {
  errorEl.classList.remove("hidden");
  contentEl.innerHTML = "";
}

function skeletonGrid() {
  contentEl.innerHTML = `
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
      <div class="skeleton h-32 w-full"></div>
      <div class="skeleton h-32 w-full"></div>
      <div class="skeleton h-32 w-full"></div>
      <div class="skeleton h-32 w-full"></div>
    </div>`;
}

function skeletonList() {
  contentEl.innerHTML = `
    <div class="space-y-2.5">
      <div class="skeleton h-16 w-full"></div>
      <div class="skeleton h-16 w-full"></div>
      <div class="skeleton h-16 w-full"></div>
      <div class="skeleton h-16 w-full"></div>
      <div class="skeleton h-16 w-full"></div>
    </div>`;
}

async function loadSubjectsList() {
  headerEl.innerHTML = `
    <h1 class="text-2xl font-extrabold text-slate-900">Dersler</h1>
    <p class="text-sm text-slate-500 mt-0.5">Sınavına hazırlandığın dersleri ve konularını incele.</p>`;
  skeletonGrid();

  const { data: subjects, error: subjError } = await supabase
    .from("subjects")
    .select("*")
    .eq("exam_type", studentExamType)
    .order("order_index");

  if (subjError) {
    toast("Dersler yüklenemedi.", "error");
    showError();
    return;
  }

  if (!subjects || subjects.length === 0) {
    contentEl.innerHTML = `
      <div class="card p-8 text-center">
        <div class="text-4xl mb-3">📚</div>
        <p class="text-slate-600 font-medium">Henüz ders eklenmemiş.</p>
      </div>`;
    return;
  }

  const subjectIds = subjects.map((s) => s.id);

  const [{ data: topics }, { data: progress }] = await Promise.all([
    supabase.from("topics").select("id, subject_id, status").in("subject_id", subjectIds),
    supabase.from("topic_progress").select("topic_id, knowledge_score").eq("user_id", user.id),
  ]);

  const scoreByTopic = new Map((progress || []).map((p) => [p.topic_id, p.knowledge_score]));
  const topicsBySubject = new Map();
  (topics || []).forEach((t) => {
    if (t.status === "kaldirildi") return;
    if (!topicsBySubject.has(t.subject_id)) topicsBySubject.set(t.subject_id, []);
    topicsBySubject.get(t.subject_id).push(t);
  });

  contentEl.innerHTML = `
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
      ${subjects
        .map((s) => {
          const subjTopics = topicsBySubject.get(s.id) || [];
          const total = subjTopics.length;
          const scores = subjTopics
            .map((t) => scoreByTopic.get(t.id))
            .filter((v) => v != null);
          const completed = subjTopics.filter((t) => (scoreByTopic.get(t.id) ?? 0) >= 60).length;
          const avgScore = scores.length ? Math.round(scores.reduce((a, b) => a + b, 0) / scores.length) : 0;
          const color = s.color || "#14b8a6";
          return `
          <a href="subjects.html?subject=${s.id}" class="card p-5 fadeIn hover:shadow-md transition group">
            <div class="flex items-start justify-between gap-2">
              <div class="w-12 h-12 rounded-xl flex items-center justify-center text-2xl shrink-0" style="background:${color}1a;">${escapeHtml(s.icon || "📘")}</div>
              <span class="text-xs font-semibold text-slate-400 group-hover:text-teal-600 transition">→</span>
            </div>
            <p class="font-bold text-slate-900 mt-3">${escapeHtml(s.name)}</p>
            ${s.description ? `<p class="text-xs text-slate-400 mt-0.5 line-clamp-2">${escapeHtml(s.description)}</p>` : ""}
            <div class="mt-3">
              <div class="flex items-center justify-between mb-1">
                <span class="text-xs font-medium text-slate-500">${completed}/${total} konu tamamlandı</span>
                <span class="text-xs font-semibold" style="color:${scoreColor(avgScore)};">%${avgScore}</span>
              </div>
              <div class="progress-track">
                <div class="progress-fill" style="width:${total ? Math.round((completed / total) * 100) : 0}%; background:${color};"></div>
              </div>
            </div>
          </a>`;
        })
        .join("")}
    </div>`;
}

async function loadTopicsForSubject(id) {
  skeletonList();

  const { data: subject, error: subjError } = await supabase
    .from("subjects")
    .select("*")
    .eq("id", id)
    .single();

  if (subjError || !subject) {
    toast("Ders bulunamadı.", "error");
    showError();
    return;
  }

  headerEl.innerHTML = `
    <a href="subjects.html" class="text-sm font-semibold text-teal-600 hover:underline">← Derslere Dön</a>
    <div class="flex items-center gap-3 mt-3">
      <div class="w-12 h-12 rounded-xl flex items-center justify-center text-2xl shrink-0" style="background:${(subject.color || "#14b8a6")}1a;">${escapeHtml(subject.icon || "📘")}</div>
      <div>
        <h1 class="text-xl font-extrabold text-slate-900">${escapeHtml(subject.name)}</h1>
        ${subject.description ? `<p class="text-sm text-slate-500 mt-0.5">${escapeHtml(subject.description)}</p>` : ""}
      </div>
    </div>`;

  const [{ data: topics, error: topicError }, { data: progress }] = await Promise.all([
    supabase.from("topics").select("*").eq("subject_id", id).order("order_index"),
    supabase.from("topic_progress").select("*").eq("user_id", user.id),
  ]);

  if (topicError) {
    toast("Konular yüklenemedi.", "error");
    showError();
    return;
  }

  const progressByTopic = new Map((progress || []).map((p) => [p.topic_id, p]));
  const visibleTopics = (topics || []).filter((t) => t.status !== "kaldirildi");

  if (visibleTopics.length === 0) {
    contentEl.innerHTML = `
      <div class="card p-8 text-center">
        <div class="text-4xl mb-3">📭</div>
        <p class="text-slate-600 font-medium">Bu derste henüz konu eklenmemiş.</p>
      </div>`;
    return;
  }

  contentEl.innerHTML = `
    <div class="space-y-2.5">
      ${visibleTopics
        .map((t) => {
          const pending = t.status === "icerik_bekliyor";
          const p = progressByTopic.get(t.id);
          const score = p?.knowledge_score ?? 0;
          const level = p?.learning_level;
          const inner = `
            <div class="flex items-center justify-between gap-3">
              <div class="min-w-0 flex-1">
                <div class="flex items-center gap-2 flex-wrap">
                  <p class="font-semibold text-slate-900 truncate">${escapeHtml(t.name)}</p>
                  ${pending ? `<span class="badge bg-slate-100 text-slate-500">İçerik Bekleniyor</span>` : ""}
                  ${level ? `<span class="badge" style="background:${scoreColor(score)}1a; color:${scoreColor(score)};">${LEVEL_LABELS[level] || level}</span>` : ""}
                </div>
                <div class="progress-track mt-2 max-w-xs">
                  <div class="progress-fill" style="width:${score}%; background:${scoreColor(score)};"></div>
                </div>
              </div>
              <span class="text-sm font-semibold shrink-0" style="color:${scoreColor(score)};">%${score}</span>
            </div>`;
          return pending
            ? `<div class="card p-4 opacity-60 cursor-not-allowed">${inner}</div>`
            : `<a href="topic.html?id=${t.id}" class="card p-4 fadeIn block hover:shadow-md transition">${inner}</a>`;
        })
        .join("")}
    </div>`;
}

document.getElementById("retry-btn").addEventListener("click", () => {
  errorEl.classList.add("hidden");
  init();
});

async function init() {
  try {
    if (subjectId) {
      await loadTopicsForSubject(subjectId);
    } else {
      await loadSubjectsList();
    }
  } catch (e) {
    // Beklenmeyen bir hata (ör. bir üstteki savunma da yetmediyse) sayfayı sonsuza
    // kadar iskelet halinde bırakmak yerine en azından görünür bir hata haline getirir.
    console.error("subjects.js init failed:", e);
    toast("Dersler yüklenemedi, tekrar dener misin?", "error");
    showError();
  }
}

init();
