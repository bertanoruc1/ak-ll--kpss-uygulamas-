import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js?v=3";
import { toast, escapeHtml, safeUrl, timeAgo } from "./ui.js?v=3";

const auth = await requireAuth();
if (!auth) throw new Error("not authenticated");
const { user } = auth;

mountNav("mistakes.html");

const contentEl = document.getElementById("content");
const errorEl = document.getElementById("error-state");

function showError() {
  errorEl.classList.remove("hidden");
  contentEl.innerHTML = "";
}

function skeleton() {
  contentEl.innerHTML = `
    <div class="space-y-2.5">
      <div class="skeleton h-20 w-full"></div>
      <div class="skeleton h-20 w-full"></div>
      <div class="skeleton h-20 w-full"></div>
    </div>`;
}

function truncate(str, len) {
  if (!str) return "";
  return str.length > len ? str.slice(0, len) + "…" : str;
}

async function loadMistakes() {
  skeleton();
  errorEl.classList.add("hidden");

  const { data: mistakes, error } = await supabase
    .from("mistakes")
    .select("*, questions(question_text, explanation, detailed_solution, video_solution_url), topics(name, subject_id, subjects(name, icon, color))")
    .eq("user_id", user.id)
    .eq("resolved", false)
    .order("created_at", { ascending: false });

  if (error) {
    toast("Yanlışlar yüklenemedi.", "error");
    showError();
    return;
  }

  if (!mistakes || mistakes.length === 0) {
    contentEl.innerHTML = `
      <div class="card p-10 text-center">
        <div class="text-4xl mb-3">🎉</div>
        <p class="text-slate-700 font-semibold">Harika! Hiç çözülmemiş yanlışın yok 🎉</p>
        <a href="subjects.html" class="btn-secondary inline-block mt-4 px-5 py-2.5">Derslere Git</a>
      </div>`;
    return;
  }

  const groups = new Map();
  for (const m of mistakes) {
    const subjectName = m.topics?.subjects?.name || "Diğer";
    if (!groups.has(subjectName)) {
      groups.set(subjectName, {
        icon: m.topics?.subjects?.icon || "📘",
        color: m.topics?.subjects?.color || "#14b8a6",
        items: [],
      });
    }
    groups.get(subjectName).items.push(m);
  }

  contentEl.innerHTML = Array.from(groups.entries())
    .map(([subjectName, group]) => `
      <div class="mb-6">
        <div class="flex items-center gap-2 mb-2.5">
          <span class="text-lg">${escapeHtml(group.icon)}</span>
          <p class="font-bold text-slate-900">${escapeHtml(subjectName)}</p>
          <span class="badge bg-rose-50 text-rose-600">${group.items.length}</span>
        </div>
        <div class="space-y-2.5">
          ${group.items.map((m) => renderMistakeItem(m)).join("")}
        </div>
      </div>`)
    .join("");

  contentEl.querySelectorAll(".detail-toggle-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      const box = document.getElementById(btn.dataset.target);
      box.classList.toggle("hidden");
      btn.textContent = box.classList.contains("hidden") ? "Detaylı çözümü gör" : "Detaylı çözümü gizle";
    });
  });
}

function renderMistakeItem(m) {
  const q = m.questions || {};
  const topicName = m.topics?.name || "";
  const detailId = `detail-${m.id}`;
  const hasDetail = !!(q.detailed_solution || q.explanation || q.video_solution_url);

  return `
    <div class="card p-4 fadeIn">
      <div class="flex items-start justify-between gap-2">
        <div class="min-w-0">
          <p class="text-xs font-semibold text-teal-500">${escapeHtml(topicName)}</p>
          <p class="text-sm font-medium text-slate-800 mt-1 leading-relaxed">${escapeHtml(truncate(q.question_text || "", 180))}</p>
        </div>
        <span class="text-xs text-slate-400 shrink-0">${timeAgo(m.created_at)}</span>
      </div>

      <div class="flex items-center gap-2 mt-3 flex-wrap">
        <a href="topic.html?id=${m.topic_id}" class="btn-primary px-4 py-2 text-xs">Tekrar Çöz</a>
        ${hasDetail ? `<button class="detail-toggle-btn btn-secondary px-4 py-2 text-xs" data-target="${detailId}">Detaylı çözümü gör</button>` : ""}
      </div>

      ${hasDetail ? `
        <div id="${detailId}" class="hidden mt-3 pt-3 border-t border-slate-100 space-y-2">
          ${q.explanation ? `<p class="text-sm text-slate-700 leading-relaxed">${escapeHtml(q.explanation)}</p>` : ""}
          ${q.detailed_solution ? `<p class="text-sm text-slate-600 leading-relaxed whitespace-pre-line">${escapeHtml(q.detailed_solution)}</p>` : ""}
          ${q.video_solution_url ? `<a href="${safeUrl(q.video_solution_url)}" target="_blank" rel="noopener" class="inline-flex items-center gap-1.5 text-sm font-semibold text-teal-600 hover:underline">▶️ Video çözümü izle</a>` : ""}
        </div>` : ""}
    </div>`;
}

document.getElementById("retry-btn").addEventListener("click", loadMistakes);

loadMistakes();
