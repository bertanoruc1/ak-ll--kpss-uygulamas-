import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js?v=2";
import { toast, escapeHtml, fmtDate } from "./ui.js?v=2";
import { EXAM_TYPE_LABELS } from "./config.js";

const auth = await requireAuth();
if (!auth) {
  throw new Error("not authenticated");
}
const { student } = auth;

mountNav("exams.html");

const ownEl = document.getElementById("own-exams");
const otherSection = document.getElementById("other-exams-section");
const otherEl = document.getElementById("other-exams");
const emptyEl = document.getElementById("empty-state");
const errorEl = document.getElementById("error-state");

function daysLeftLabel(examDate) {
  if (!examDate) {
    return `<p class="text-sm font-semibold text-slate-400 mt-1">Tarih henüz doğrulanmadı</p>`;
  }
  const days = Math.ceil((new Date(examDate) - new Date()) / 86400000);
  const label = days < 0 ? "Geçti" : days === 0 ? "Bugün" : `${days} gün kaldı`;
  return `
    <div class="flex items-end gap-2 mt-1">
      <span class="text-4xl font-extrabold leading-none">${days >= 0 ? days : "—"}</span>
      <span class="text-sm font-semibold mb-1 opacity-90">${days >= 0 ? "gün kaldı" : label}</span>
    </div>`;
}

function examCard(exam, isOwn) {
  const typeLabel = EXAM_TYPE_LABELS[exam.exam_type] || exam.exam_type;
  const lowConfidence = exam.confidence != null && exam.confidence < 0.7;
  const hasWindow = exam.application_start || exam.application_end;

  return `
    <div class="card p-5 fadeIn ${isOwn ? "ring-2 ring-teal-500" : ""}">
      <div class="flex items-start justify-between gap-3">
        <div class="min-w-0">
          <span class="badge bg-teal-50 text-teal-700">${escapeHtml(typeLabel)}</span>
          <p class="font-bold text-slate-900 mt-2 truncate">${escapeHtml(exam.name)}</p>
          ${exam.exam_date ? `<p class="text-sm text-slate-500 mt-0.5">${fmtDate(exam.exam_date)}</p>` : ""}
        </div>
        ${isOwn ? `<span class="badge bg-sky-50 text-sky-700 shrink-0">Senin Sınavın</span>` : ""}
      </div>

      <div class="mt-3 ${exam.exam_date ? "rounded-xl p-4 text-white" : ""}" ${exam.exam_date ? `style="background: linear-gradient(135deg, #0f766e, #0ea5e9 55%, #22d3ee);"` : ""}>
        ${daysLeftLabel(exam.exam_date)}
      </div>

      ${hasWindow ? `
        <div class="mt-3 text-sm text-slate-600 flex items-center gap-2">
          <span>📝</span>
          <span>Başvuru: ${fmtDate(exam.application_start)} – ${fmtDate(exam.application_end)}</span>
        </div>` : ""}

      ${exam.late_application_date ? `
        <div class="mt-1 text-sm text-slate-500 flex items-center gap-2">
          <span>⏳</span>
          <span>Geç başvuru: ${fmtDate(exam.late_application_date)}</span>
        </div>` : ""}

      ${exam.result_date ? `
        <div class="mt-1 text-sm text-slate-500 flex items-center gap-2">
          <span>📣</span>
          <span>Sonuç: ${fmtDate(exam.result_date)}</span>
        </div>` : ""}

      ${lowConfidence ? `<p class="text-xs text-amber-600 font-medium mt-3">⚠️ Bu bilgi henüz tam doğrulanmadı</p>` : ""}

      ${exam.source_url ? `<a href="${escapeHtml(exam.source_url)}" target="_blank" rel="noopener" class="text-sm font-semibold text-teal-600 hover:underline mt-3 inline-block">Resmi kaynağı görüntüle →</a>` : ""}
    </div>`;
}

async function loadExams() {
  errorEl.classList.add("hidden");
  emptyEl.classList.add("hidden");
  otherSection.classList.add("hidden");

  const { data, error } = await supabase
    .from("exams")
    .select("*")
    .eq("is_active", true)
    .order("exam_date", { ascending: true, nullsFirst: false });

  if (error) {
    toast("Sınav takvimi yüklenemedi.", "error");
    ownEl.innerHTML = "";
    errorEl.classList.remove("hidden");
    return;
  }

  const exams = data || [];
  if (exams.length === 0) {
    ownEl.innerHTML = "";
    emptyEl.classList.remove("hidden");
    return;
  }

  const myType = student?.exam_type;
  const own = myType ? exams.filter((e) => e.exam_type === myType) : [];
  const others = myType ? exams.filter((e) => e.exam_type !== myType) : exams;

  ownEl.innerHTML = own.length > 0
    ? own.map((e) => examCard(e, true)).join("")
    : `<div class="card p-6 text-center text-sm text-slate-500">Kendi sınav türün için henüz takvim bilgisi yok.</div>`;

  if (others.length > 0) {
    otherEl.innerHTML = others.map((e) => examCard(e, false)).join("");
    otherSection.classList.remove("hidden");
  }
}

document.getElementById("retry-btn").addEventListener("click", loadExams);

loadExams();
