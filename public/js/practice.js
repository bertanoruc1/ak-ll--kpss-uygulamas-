import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js";
import { toast, escapeHtml, DIFFICULTY_LABELS, DIFFICULTY_COLORS, scoreColor } from "./ui.js";

const auth = await requireAuth();
if (!auth) throw new Error("not authenticated");

mountNav("practice.html");

const params = new URLSearchParams(window.location.search);
const topicId = params.get("topic");
const sessionId = params.get("session");

const contentEl = document.getElementById("content");
const errorEl = document.getElementById("error-state");

let topic = null;
const tally = { correct: 0, total: 0 };
let answering = false;
let sessionTarget = null; // Bu oturumda kaç soru çözülünce bitirilecek.
let sessionRow = null; // study_sessions satırı (varsa) — "görev" tamamlama için.
const servedQuestionIds = new Set(); // Sonsuz döngü koruması: aynı soru ikinci kez gelirse oturum bitmiştir.
let finished = false;

function showError() {
  errorEl.classList.remove("hidden");
  contentEl.innerHTML = "";
}

function skeleton() {
  contentEl.innerHTML = `
    <div class="skeleton h-8 w-full mb-3"></div>
    <div class="skeleton h-64 w-full"></div>`;
}

function statsHeader() {
  const pct = tally.total ? Math.round((tally.correct / tally.total) * 100) : 0;
  return `
    <div class="flex items-center justify-between mb-4">
      <div>
        <a href="${topic ? `topic.html?id=${topic.id}` : "subjects.html"}" class="text-sm font-semibold text-indigo-600 hover:underline">← ${topic ? escapeHtml(topic.name) : "Geri"}</a>
        <p class="text-xs text-slate-400 mt-0.5">Soru Çözme Oturumu</p>
      </div>
      <div class="text-right">
        <p class="text-xs font-semibold text-slate-400">Bu oturum</p>
        <p class="text-sm font-bold" style="color:${scoreColor(pct)};">${tally.correct}/${tally.total} · %${pct}</p>
      </div>
    </div>`;
}

async function init() {
  if (!topicId) {
    contentEl.innerHTML = `
      <div class="card p-8 text-center">
        <div class="text-4xl mb-3">🔍</div>
        <p class="text-slate-600 font-medium mb-1">Lütfen bir konu seçin.</p>
        <a href="subjects.html" class="btn-primary inline-block mt-4 px-5 py-2.5">Derslere Git</a>
      </div>`;
    return;
  }

  skeleton();
  errorEl.classList.add("hidden");

  const { data: t } = await supabase.from("topics").select("id, name, subject_id").eq("id", topicId).maybeSingle();
  topic = t;

  await resolveSessionTarget();
  await loadNextQuestion();
}

// Oturumun kaç soruda biteceğini belirle: eğer dashboard'daki günlük plandan
// bir "görev" (study_sessions.id) ile gelindiyse o oturumun question_target'ı;
// aksi hâlde konudaki TOPLAM soru sayısı hedef alınır. Bu, "6 soru varsa bitir"
// davranışının kaynağı — hedefe ulaşınca sonsuz döngü yerine sonuç ekranı gelir.
async function resolveSessionTarget() {
  sessionTarget = null;
  sessionRow = null;

  const { count: totalInTopic } = await supabase
    .from("questions")
    .select("id", { count: "exact", head: true })
    .eq("topic_id", topicId);

  let target = totalInTopic || null;

  if (sessionId) {
    const { data: s } = await supabase
      .from("study_sessions")
      .select("id, question_target, status")
      .eq("id", sessionId)
      .maybeSingle();
    if (s) {
      sessionRow = s;
      if (s.question_target) {
        // Hedef, konudaki gerçek soru sayısını aşamaz (aksi hâlde asla ulaşılamaz).
        target = totalInTopic ? Math.min(s.question_target, totalInTopic) : s.question_target;
      }
    }
  }

  sessionTarget = target && target > 0 ? target : null;
}

async function loadNextQuestion() {
  contentEl.innerHTML = `${statsHeader()}<div class="skeleton h-64 w-full"></div>`;

  const { data: q, error } = await supabase.rpc("get_next_question", { p_topic_id: topicId });

  if (error) {
    toast(error.message || "Soru yüklenemedi.", "error");
    showError();
    return;
  }

  if (!q) {
    contentEl.innerHTML = `
      ${statsHeader()}
      <div class="card p-8 text-center">
        <div class="text-4xl mb-3">🤷</div>
        <p class="text-slate-600 font-medium mb-1">Bu konuda henüz soru eklenmedi.</p>
        <a href="subjects.html" class="btn-secondary inline-block mt-4 px-5 py-2.5">Derslere Dön</a>
      </div>`;
    return;
  }

  // Sonsuz döngü koruması: backend, konudaki tüm sorular bu oturumda
  // cevaplandıysa (24 saatlik hariç tutma listesi tükendiyse) rastgele bir
  // soruyu TEKRAR döndürür. Aynı soru ikinci kez geldiyse artık gösterecek
  // yeni soru kalmamış demektir — döngüye girmek yerine oturumu bitir.
  if (servedQuestionIds.has(q.id)) {
    finishSession();
    return;
  }
  servedQuestionIds.add(q.id);

  renderQuestion(q);
}

function renderQuestion(q) {
  answering = false;
  const startedAt = Date.now();

  contentEl.innerHTML = `
    ${statsHeader()}
    <div class="card p-5 fadeIn">
      <div class="flex items-center justify-between mb-3">
        <span class="badge" style="background:${DIFFICULTY_COLORS[q.difficulty] || "#94a3b8"}1a; color:${DIFFICULTY_COLORS[q.difficulty] || "#64748b"};">${DIFFICULTY_LABELS[q.difficulty] || q.difficulty || ""}</span>
        ${q.kazanim ? `<span class="text-xs text-slate-400">${escapeHtml(q.kazanim)}</span>` : ""}
      </div>
      ${q.image_url ? `<img src="${escapeHtml(q.image_url)}" alt="Soru görseli" class="rounded-xl mb-3 max-h-72 object-contain mx-auto" />` : ""}
      <p class="font-semibold text-slate-900 leading-relaxed whitespace-pre-line">${escapeHtml(q.question_text)}</p>
      <div id="choices" class="space-y-2 mt-4">
        ${(q.choices || []).map((c) => `
          <button class="choice-btn w-full text-left px-4 py-3 rounded-xl border border-slate-200 hover:border-indigo-300 hover:bg-indigo-50/40 transition text-sm font-medium text-slate-700" data-choice="${c.id}">
            ${escapeHtml(c.choice_text)}
          </button>`).join("")}
      </div>
      <div id="result-area" class="mt-4"></div>
    </div>`;

  document.querySelectorAll(".choice-btn").forEach((btn) => {
    btn.addEventListener("click", () => handleAnswer(q, btn, startedAt));
  });
}

async function handleAnswer(q, btn, startedAt) {
  if (answering) return;
  answering = true;

  document.querySelectorAll(".choice-btn").forEach((b) => (b.disabled = true));
  btn.classList.add("opacity-70");

  const timeSpent = Math.round((Date.now() - startedAt) / 1000);
  const { data, error } = await supabase.rpc("submit_answer", {
    p_question_id: q.id,
    p_choice_id: btn.dataset.choice,
    p_time_spent_seconds: timeSpent,
  });

  if (error || !data) {
    toast(error?.message || "Cevap gönderilemedi.", "error");
    document.querySelectorAll(".choice-btn").forEach((b) => (b.disabled = false));
    answering = false;
    return;
  }

  tally.total++;
  if (data.is_correct) tally.correct++;

  document.querySelectorAll(".choice-btn").forEach((b) => {
    const id = b.dataset.choice;
    if (id === data.correct_choice_id) {
      b.classList.add("border-emerald-400", "bg-emerald-50", "text-emerald-700");
      b.innerHTML += ` <span class="float-right">✅</span>`;
    } else if (id === btn.dataset.choice && !data.is_correct) {
      b.classList.add("border-rose-400", "bg-rose-50", "text-rose-700");
      b.innerHTML += ` <span class="float-right">❌</span>`;
    }
  });

  // Update stats header
  const headerWrap = contentEl.querySelector(":scope > div:first-child");
  if (headerWrap) headerWrap.outerHTML = statsHeader();

  const reachedTarget = sessionTarget != null && tally.total >= sessionTarget;
  const resultArea = document.getElementById("result-area");
  resultArea.innerHTML = `
    <div class="rounded-xl p-4 ${data.is_correct ? "bg-emerald-50 border border-emerald-100" : "bg-rose-50 border border-rose-100"} fadeIn">
      <p class="font-bold ${data.is_correct ? "text-emerald-700" : "text-rose-700"}">${data.is_correct ? "🎉 Doğru cevap!" : "😕 Yanlış cevap"}</p>
      ${!data.is_correct ? `<p class="text-sm text-slate-600 mt-1">Doğru cevap: <strong>${escapeHtml(data.correct_choice_text || "")}</strong></p>` : ""}
      <div id="explanation-box" class="mt-3">
        <div class="skeleton h-4 w-2/3"></div>
      </div>
      <button id="next-question-btn" class="btn-primary mt-4 px-5 py-2.5 text-sm">${reachedTarget ? "Bitir ve Sonucu Gör →" : "Sonraki Soru →"}</button>
    </div>`;

  document.getElementById("next-question-btn").addEventListener("click", () => {
    if (reachedTarget) finishSession();
    else loadNextQuestion();
  });

  loadExplanation(q.id);
}

// Oturum hedefine ulaşıldığında (veya gösterilecek yeni soru kalmadığında)
// çağrılır: sonsuz döngü yerine bir sonuç ekranı gösterir ve — dashboard'daki
// günlük plandan bir "görev" ile gelindiyse — o görevi tamamlandı olarak işaretler.
async function finishSession() {
  if (finished) return;
  finished = true;

  const pct = tally.total ? Math.round((tally.correct / tally.total) * 100) : 0;

  contentEl.innerHTML = `
    ${statsHeader()}
    <div class="card p-8 text-center fadeIn">
      <div class="text-5xl mb-3">${pct >= 70 ? "🏆" : pct >= 40 ? "👏" : "💪"}</div>
      <p class="text-xl font-extrabold text-slate-900">Oturum tamamlandı!</p>
      <p class="text-sm text-slate-500 mt-1">${escapeHtml(topic?.name || "")}</p>
      <p class="text-4xl font-extrabold mt-4" style="color:${scoreColor(pct)};">${tally.correct}/${tally.total}</p>
      <p class="text-sm font-semibold text-slate-500 mt-1">%${pct} başarı</p>
      <div class="grid grid-cols-2 gap-3 mt-6">
        <a href="topic.html?id=${topicId}" class="btn-secondary py-2.5 text-sm text-center">Konuya Dön</a>
        <a href="dashboard.html" class="btn-primary py-2.5 text-sm text-center">Panele Dön</a>
      </div>
    </div>`;

  if (sessionId && sessionRow && sessionRow.status !== "done") {
    const { error } = await supabase.rpc("complete_study_session", { p_session_id: sessionId });
    if (error) {
      console.error("complete_study_session failed:", error);
    } else {
      toast("Görev tamamlandı olarak işaretlendi! 🎉", "success");
    }
  }
}

async function loadExplanation(questionId) {
  const box = document.getElementById("explanation-box");
  const { data, error } = await supabase
    .from("questions")
    .select("explanation, detailed_solution, video_solution_url")
    .eq("id", questionId)
    .single();

  if (!box) return;

  if (error || !data) {
    box.innerHTML = "";
    return;
  }

  const parts = [];
  if (data.explanation) parts.push(`<p class="text-sm text-slate-700 leading-relaxed">${escapeHtml(data.explanation)}</p>`);
  if (data.detailed_solution) parts.push(`<p class="text-sm text-slate-600 leading-relaxed mt-2 whitespace-pre-line">${escapeHtml(data.detailed_solution)}</p>`);
  if (data.video_solution_url) parts.push(`<a href="${escapeHtml(data.video_solution_url)}" target="_blank" rel="noopener" class="inline-flex items-center gap-1.5 text-sm font-semibold text-indigo-600 hover:underline mt-2">▶️ Video çözümü izle</a>`);

  box.innerHTML = parts.length ? parts.join("") : `<p class="text-sm text-slate-400 italic">Açıklama eklenmemiş.</p>`;
}

document.getElementById("retry-btn").addEventListener("click", init);

init();
