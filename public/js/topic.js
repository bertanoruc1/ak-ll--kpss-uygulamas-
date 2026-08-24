import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js";
import { toast, escapeHtml, scoreColor, renderMarkdown, LEVEL_LABELS } from "./ui.js";
import { createPracticeEngine } from "./practiceEngine.js";

const auth = await requireAuth();
if (!auth) throw new Error("not authenticated");
const { user } = auth;

mountNav("subjects.html");

const params = new URLSearchParams(window.location.search);
const topicId = params.get("id");
const sessionId = params.get("session");

// Dashboard'daki günlük plandan bir "görev" ile buraya gelindiyse, o görev
// tamamlandığında (konu anlaşıldı / tekrar yapıldı) study_sessions'ı da
// tamamlandı işaretle — böylece "Bugünün Programı" listesinde Tamamlandı görünür.
async function completeSessionIfLinked() {
  if (!sessionId) return;
  const { error } = await supabase.rpc("complete_study_session", { p_session_id: sessionId });
  if (error) console.error("complete_study_session failed:", error);
}

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
let practiceEngine = null;
let practiceStarted = false;

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
        <p class="text-xs text-slate-500 mb-3">Onayladığında aşağıdaki soru bölümü hemen açılır.</p>
        <button id="understood-btn" class="btn-primary px-5 py-2.5">✅ Bu konuyu anladım, soruları göster</button>
      </div>

      <div class="card p-5 mt-4" id="practice-card">
        <p class="font-bold text-slate-900 mb-3">📝 Soru Çöz</p>
        <div id="practice-mount">
          <button id="start-practice-btn" type="button" class="btn-primary w-full py-3">📝 Soru Çözmeye Başla</button>
        </div>
      </div>
    </div>`;

  renderRepetitionCard();
  document.getElementById("understood-btn").addEventListener("click", handleUnderstood);
  document.getElementById("start-practice-btn").addEventListener("click", () => startPractice());
  const videoBtn = document.getElementById("video-watched-btn");
  if (videoBtn) videoBtn.addEventListener("click", handleVideoWatched);

  // Bir "görev" (soru çözme) linkiyle gelindiyse, kullanıcı tekrar tıklamak
  // zorunda kalmadan soru bölümü otomatik açılsın.
  if (sessionId && !practiceStarted) {
    startPractice();
  }
}

function startPractice() {
  practiceStarted = true;
  const mount = document.getElementById("practice-mount");
  if (!mount) return;
  if (!practiceEngine) {
    practiceEngine = createPracticeEngine({
      topicId,
      sessionId,
      mountEl: mount,
      topicName: topic?.name,
      showHeader: true,
      backHref: null,
    });
  }
  practiceEngine.start();
  document.getElementById("practice-card")?.scrollIntoView({ behavior: "smooth", block: "start" });
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
  completeSessionIfLinked();
}

async function handleUnderstood() {
  const btn = document.getElementById("understood-btn");
  btn.disabled = true;
  btn.textContent = "Kaydediliyor...";
  const { error } = await supabase.rpc("mark_topic_understood", { p_topic_id: topicId });
  if (error) {
    toast(error.message || "Kaydedilemedi.", "error");
    btn.disabled = false;
    btn.textContent = "✅ Bu konuyu anladım, soruları göster";
    return;
  }
  toast("Öz değerlendirme kaydedildi, sorulara başlayabilirsin!", "success");
  await completeSessionIfLinked();
  btn.textContent = "✅ Kaydedildi";
  // Kullanıcı "anladım" dediğinde en doğru sonraki adım, o konuyla ilgili
  // sorularla kendini hemen test etmesi — bu yüzden ayrı bir sayfaya
  // yönlendirmek yerine aynı sayfadaki soru bölümünü açıp oraya kaydırıyoruz.
  startPractice();
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

document.getElementById("retry-btn").addEventListener("click", loadTopic);

loadTopic();
