import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js";
import { toast, escapeHtml, scoreColor, renderMarkdown, LEVEL_LABELS, DIFFICULTY_LABELS, DIFFICULTY_COLORS } from "./ui.js";

const auth = await requireAuth();
if (!auth) throw new Error("not authenticated");
const { user } = auth;

mountNav("subjects.html");

const params = new URLSearchParams(window.location.search);
const topicId = params.get("id");

const contentEl = document.getElementById("content");
const errorEl = document.getElementById("error-state");

function showError() {
  errorEl.classList.remove("hidden");
  contentEl.innerHTML = "";
}

function skeleton() {
  contentEl.innerHTML = `
    <div class="skeleton h-6 w-40 mb-2"></div>
    <div class="skeleton h-9 w-72 mb-4"></div>
    <div class="skeleton h-24 w-full mb-4"></div>
    <div class="skeleton h-48 w-full"></div>`;
}

let topic, subject, topicContent, progress, dueRepetition;

async function loadTopic() {
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

  const { data: t, error: tErr } = await supabase.from("topics").select("*").eq("id", topicId).single();
  if (tErr || !t) {
    toast("Konu bulunamadı.", "error");
    showError();
    return;
  }
  topic = t;

  const [
    { data: s },
    { data: tc },
    { data: tp },
    { data: reps },
  ] = await Promise.all([
    supabase.from("subjects").select("*").eq("id", topic.subject_id).single(),
    supabase.from("topic_contents").select("*").eq("topic_id", topicId).maybeSingle(),
    supabase.from("topic_progress").select("*").eq("user_id", user.id).eq("topic_id", topicId).maybeSingle(),
    supabase
      .from("repetitions")
      .select("*")
      .eq("user_id", user.id)
      .eq("topic_id", topicId)
      .eq("status", "pending")
      .lte("scheduled_for", new Date().toISOString())
      .order("scheduled_for", { ascending: true })
      .limit(1),
  ]);

  subject = s;
  topicContent = tc;
  progress = tp;
  dueRepetition = reps && reps.length ? reps[0] : null;

  render();
}

function render() {
  const score = progress?.knowledge_score ?? 0;
  const level = progress?.learning_level;
  const color = scoreColor(score);
  const subjColor = subject?.color || "#6366f1";

  contentEl.innerHTML = `
    <div class="fadeIn">
      <div class="text-sm text-slate-400 flex items-center gap-1.5 flex-wrap">
        <a href="subjects.html" class="hover:text-indigo-600 hover:underline">Dersler</a>
        <span>›</span>
        <a href="subjects.html?subject=${subject?.id || ""}" class="hover:text-indigo-600 hover:underline">${escapeHtml(subject?.name || "")}</a>
        <span>›</span>
        <span class="text-slate-600 font-medium">${escapeHtml(topic.name)}</span>
      </div>

      <div class="mt-3">
        <h1 class="text-2xl font-extrabold text-slate-900">${escapeHtml(topic.name)}</h1>
        ${topic.kazanim_text ? `<p class="text-sm text-slate-500 mt-1">${escapeHtml(topic.kazanim_text)}</p>` : ""}
      </div>

      ${topic.status === "icerik_bekliyor" ? `<div class="mt-3"><span class="badge bg-slate-100 text-slate-500">İçerik Bekleniyor</span></div>` : ""}

      <div class="card p-4 mt-4">
        <div class="flex items-center justify-between mb-1.5">
          <p class="text-sm font-semibold text-slate-600">Bilgi Seviyesi ${level ? `· <span style="color:${color};">${escapeHtml(LEVEL_LABELS[level] || level)}</span>` : ""}</p>
          <span class="text-sm font-bold" style="color:${color};">%${score}</span>
        </div>
        <div class="progress-track"><div class="progress-fill" style="width:${score}%; background:${color};"></div></div>
      </div>

      <div id="repetition-card" class="mt-4"></div>

      <div class="grid grid-cols-2 gap-3 mt-4">
        <a href="practice.html?topic=${topic.id}" class="btn-primary text-center py-3">📝 Soru Çöz</a>
        <button id="mini-test-btn" class="btn-secondary py-3">🧪 Mini Test Başlat</button>
      </div>

      <div class="card p-5 mt-5">
        <p class="font-bold text-slate-900 mb-2">📌 Özet</p>
        ${topicContent?.summary ? `<p class="text-sm text-slate-600 leading-relaxed">${escapeHtml(topicContent.summary)}</p>` : `<p class="text-sm text-slate-400 italic">İçerik henüz eklenmedi.</p>`}
      </div>

      <div class="card p-5 mt-4">
        <p class="font-bold text-slate-900 mb-2">📖 Ders Notu</p>
        ${topicContent?.content_md ? `<div class="text-sm text-slate-700">${renderMarkdown(topicContent.content_md)}</div>` : `<p class="text-sm text-slate-400 italic">İçerik henüz eklenmedi.</p>`}
      </div>

      <div class="card p-5 mt-4">
        <p class="font-bold text-slate-900 mb-2">✏️ Örnek Soru</p>
        ${topicContent?.example_question ? `<p class="text-sm text-slate-600 leading-relaxed whitespace-pre-line">${escapeHtml(topicContent.example_question)}</p>` : `<p class="text-sm text-slate-400 italic">İçerik henüz eklenmedi.</p>`}
      </div>

      <div class="card p-5 mt-4">
        <p class="font-bold text-slate-900 mb-2">🎬 Video</p>
        ${topicContent?.video_url ? `
          <a href="${escapeHtml(topicContent.video_url)}" target="_blank" rel="noopener" class="flex items-center gap-3 rounded-xl border border-slate-200 p-3 hover:bg-slate-50 transition">
            <span class="text-2xl">▶️</span>
            <span class="text-sm font-medium text-indigo-600 truncate">${escapeHtml(topicContent.video_url)}</span>
          </a>
          <button id="video-watched-btn" class="btn-secondary mt-3 px-4 py-2 text-sm">Videoyu İzledim</button>
        ` : `<p class="text-sm text-slate-400 italic">İçerik henüz eklenmedi.</p>`}
      </div>

      <div class="card p-5 mt-4 text-center" style="background: linear-gradient(135deg, #eef2ff, #f5f3ff); border: 1px solid #e0e7ff;">
        <p class="font-bold text-slate-900 mb-1">Bu konuyu öğrendiğini düşünüyor musun?</p>
        <p class="text-xs text-slate-500 mb-3">Öz değerlendirmen, bilgi skoruna küçük bir katkı sağlar.</p>
        <button id="understood-btn" class="btn-primary px-5 py-2.5">✅ Bu konuyu anladım</button>
      </div>

      <div id="mini-test-area" class="mt-4"></div>
    </div>`;

  renderRepetitionCard();
  document.getElementById("mini-test-btn").addEventListener("click", startMiniTest);
  document.getElementById("understood-btn").addEventListener("click", handleUnderstood);
  const videoBtn = document.getElementById("video-watched-btn");
  if (videoBtn) videoBtn.addEventListener("click", handleVideoWatched);
}

function renderRepetitionCard() {
  const el = document.getElementById("repetition-card");
  if (!dueRepetition) { el.innerHTML = ""; return; }
  el.innerHTML = `
    <div class="rounded-2xl p-5 text-white relative overflow-hidden" style="background: linear-gradient(135deg, #f97316, #ea580c);">
      <div class="relative z-10">
        <p class="font-bold text-lg">🔁 Tekrar Zamanı!</p>
        <p class="text-sm text-orange-100 mt-1">Bu konuyu hatırlıyor musun? Kendini test et.</p>
        <div class="flex gap-2 mt-3">
          <button id="rep-remember-btn" class="bg-white text-orange-700 font-semibold px-4 py-2 rounded-xl text-sm hover:bg-orange-50 transition">Hatırlıyorum</button>
          <button id="rep-forgot-btn" class="bg-orange-700/40 text-white font-semibold px-4 py-2 rounded-xl text-sm hover:bg-orange-700/60 transition border border-white/30">Unuttum</button>
        </div>
      </div>
    </div>`;
  document.getElementById("rep-remember-btn").addEventListener("click", () => handleRepetition(true));
  document.getElementById("rep-forgot-btn").addEventListener("click", () => handleRepetition(false));
}

async function handleRepetition(success) {
  const { data, error } = await supabase.rpc("complete_repetition", {
    p_repetition_id: dueRepetition.id,
    p_success: success,
  });
  if (error) {
    toast(error.message || "İşlem başarısız.", "error");
    return;
  }
  toast(success ? "Harika, tekrar kaydedildi!" : "Tekrar planlandı, üzülme!", "success");
  dueRepetition = null;
  renderRepetitionCard();
}

async function handleUnderstood() {
  const btn = document.getElementById("understood-btn");
  btn.disabled = true;
  btn.textContent = "Kaydediliyor...";
  const { error } = await supabase.rpc("mark_topic_understood", { p_topic_id: topicId });
  if (error) {
    toast(error.message || "Kaydedilemedi.", "error");
    btn.disabled = false;
    btn.textContent = "✅ Bu konuyu anladım";
    return;
  }
  toast("Öz değerlendirme kaydedildi", "success");
  const { data: tp } = await supabase.from("topic_progress").select("*").eq("user_id", user.id).eq("topic_id", topicId).maybeSingle();
  progress = tp;
  render();
}

async function handleVideoWatched() {
  const btn = document.getElementById("video-watched-btn");
  btn.disabled = true;
  btn.textContent = "Kaydediliyor...";
  const { error } = await supabase.rpc("mark_video_watched", { p_topic_id: topicId });
  if (error) {
    toast(error.message || "Kaydedilemedi.", "error");
    btn.disabled = false;
    btn.textContent = "Videoyu İzledim";
    return;
  }
  toast("Video izlendi olarak işaretlendi", "success");
  btn.textContent = "✓ İzlendi";
}

// ---- Mini Test flow ----
const MINI_TEST_COUNT = 5;

async function startMiniTest() {
  const area = document.getElementById("mini-test-area");
  area.innerHTML = `
    <div class="card p-6 text-center">
      <div class="skeleton h-6 w-40 mx-auto mb-2"></div>
      <p class="text-sm text-slate-400 mt-2">Sorular hazırlanıyor...</p>
    </div>`;
  area.scrollIntoView({ behavior: "smooth", block: "start" });

  const questions = [];
  const seenIds = new Set();
  let attempts = 0;
  while (questions.length < MINI_TEST_COUNT && attempts < MINI_TEST_COUNT * 3) {
    attempts++;
    const { data: q, error } = await supabase.rpc("get_next_question", { p_topic_id: topicId });
    if (error || !q) break;
    if (!seenIds.has(q.id)) {
      seenIds.add(q.id);
      questions.push(q);
    }
  }

  if (questions.length === 0) {
    area.innerHTML = `
      <div class="card p-6 text-center">
        <div class="text-3xl mb-2">🤷</div>
        <p class="text-slate-600 font-medium">Bu konuda henüz soru eklenmedi.</p>
      </div>`;
    return;
  }

  runMiniTest(area, questions, 0, []);
}

function runMiniTest(area, questions, index, answers) {
  if (index >= questions.length) {
    finishMiniTest(area, answers);
    return;
  }

  const q = questions[index];
  const startedAt = Date.now();

  area.innerHTML = `
    <div class="card p-5 fadeIn">
      <div class="flex items-center justify-between mb-3">
        <span class="text-xs font-semibold text-slate-400">Mini Test · Soru ${index + 1}/${questions.length}</span>
        <span class="badge" style="background:${DIFFICULTY_COLORS[q.difficulty] || "#94a3b8"}1a; color:${DIFFICULTY_COLORS[q.difficulty] || "#64748b"};">${DIFFICULTY_LABELS[q.difficulty] || q.difficulty || ""}</span>
      </div>
      ${q.image_url ? `<img src="${escapeHtml(q.image_url)}" alt="Soru görseli" class="rounded-xl mb-3 max-h-64 object-contain mx-auto" />` : ""}
      <p class="font-semibold text-slate-900 leading-relaxed whitespace-pre-line">${escapeHtml(q.question_text)}</p>
      <div class="space-y-2 mt-4">
        ${(q.choices || []).map((c) => `
          <button class="mini-choice-btn w-full text-left px-4 py-3 rounded-xl border border-slate-200 hover:border-indigo-300 hover:bg-indigo-50/40 transition text-sm font-medium text-slate-700" data-choice="${c.id}">
            ${escapeHtml(c.choice_text)}
          </button>`).join("")}
      </div>
    </div>`;

  area.querySelectorAll(".mini-choice-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      const timeSpent = Math.round((Date.now() - startedAt) / 1000);
      answers.push({ question_id: q.id, choice_id: btn.dataset.choice, time_spent_seconds: timeSpent });
      runMiniTest(area, questions, index + 1, answers);
    });
  });
}

async function finishMiniTest(area, answers) {
  area.innerHTML = `
    <div class="card p-6 text-center">
      <div class="skeleton h-6 w-40 mx-auto mb-2"></div>
      <p class="text-sm text-slate-400 mt-2">Sonuçlar hesaplanıyor...</p>
    </div>`;

  const { data, error } = await supabase.rpc("submit_mini_test", {
    p_topic_id: topicId,
    p_answers: answers,
  });

  if (error || !data) {
    toast(error?.message || "Mini test gönderilemedi.", "error");
    area.innerHTML = "";
    return;
  }

  const pct = data.score != null ? Math.round(data.score) : Math.round((data.correct / data.total) * 100);
  area.innerHTML = `
    <div class="card p-6 text-center fadeIn">
      <div class="text-4xl mb-2">🎉</div>
      <p class="font-bold text-lg text-slate-900">Mini Test Tamamlandı!</p>
      <p class="text-5xl font-extrabold mt-3" style="color:${scoreColor(pct)};">%${pct}</p>
      <p class="text-sm text-slate-500 mt-2">${data.correct}/${data.total} doğru</p>
      <button id="close-mini-test-btn" class="btn-secondary mt-5 px-5 py-2.5">Kapat</button>
    </div>`;

  document.getElementById("close-mini-test-btn").addEventListener("click", async () => {
    area.innerHTML = "";
    const { data: tp } = await supabase.from("topic_progress").select("*").eq("user_id", user.id).eq("topic_id", topicId).maybeSingle();
    progress = tp;
    render();
  });
}

document.getElementById("retry-btn").addEventListener("click", loadTopic);

loadTopic();
