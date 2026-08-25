import { supabase } from "./supabaseClient.js";
import { toast, escapeHtml, DIFFICULTY_LABELS, DIFFICULTY_COLORS, scoreColor } from "./ui.js?v=2";

// Paylaşılan soru çözme motoru: hedef belirleme (kaç soruda bitecek),
// soru getirme, cevaplama, sonuç ekranı, sonsuz döngü koruması ve — bir
// study_sessions "görev"i ile gelindiyse — o görevi tamamlandı işaretleme.
//
// Bu motor artık STANDALONE bir "Sorular" sayfasına değil, doğrudan konu
// sayfasının (topic.html) İÇİNE gömülü olarak çalışır (bkz. topic.js) —
// "dersler kısmına girince her konunun içinde içerik VE soru bölümü olsun"
// isteğinin karşılığı. practice.js artık sadece eski bağlantıları
// topic.html'e yönlendiren ince bir katman.
export function createPracticeEngine({ topicId, sessionId, mountEl, topicName, onFinished, showHeader = true, backHref = null }) {
  const tally = { correct: 0, total: 0 };
  let answering = false;
  let sessionTarget = null;
  let sessionRow = null;
  const servedQuestionIds = new Set();
  let finished = false;

  function statsHeader() {
    if (!showHeader) return "";
    const pct = tally.total ? Math.round((tally.correct / tally.total) * 100) : 0;
    return `
      <div class="flex items-center justify-between mb-4">
        <div>
          ${backHref ? `<a href="${backHref}" class="text-sm font-semibold text-teal-600 hover:underline">← ${escapeHtml(topicName || "Geri")}</a>` : `<p class="text-sm font-bold text-slate-700">${escapeHtml(topicName || "")}</p>`}
          <p class="text-xs text-slate-400 mt-0.5">Soru Çözme Oturumu</p>
        </div>
        <div class="text-right">
          <p class="text-xs font-semibold text-slate-400">Bu oturum</p>
          <p class="text-sm font-bold" style="color:${scoreColor(pct)};">${tally.correct}/${tally.total} · %${pct}</p>
        </div>
      </div>`;
  }

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
          target = totalInTopic ? Math.min(s.question_target, totalInTopic) : s.question_target;
        }
      }
    }

    sessionTarget = target && target > 0 ? target : null;
  }

  async function loadNextQuestion() {
    mountEl.innerHTML = `${statsHeader()}<div class="skeleton h-64 w-full"></div>`;

    const { data: q, error } = await supabase.rpc("get_next_question", { p_topic_id: topicId });

    if (error) {
      toast(error.message || "Soru yüklenemedi.", "error");
      mountEl.innerHTML = `${statsHeader()}<div class="card p-8 text-center"><p class="text-slate-500 text-sm">Sorular yüklenirken bir sorun oluştu.</p></div>`;
      return;
    }

    if (!q) {
      mountEl.innerHTML = `
        ${statsHeader()}
        <div class="card p-8 text-center">
          <div class="text-4xl mb-3">🤷</div>
          <p class="text-slate-600 font-medium mb-1">Bu konuda henüz soru eklenmedi.</p>
        </div>`;
      return;
    }

    // Sonsuz döngü koruması: backend, konudaki tüm sorular bu oturumda
    // cevaplandıysa aynı soruyu tekrar döndürebilir — o durumda döngüye
    // girmek yerine oturumu bitir.
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

    mountEl.innerHTML = `
      ${statsHeader()}
      <div class="card p-5 fadeIn">
        <div class="flex items-center justify-between mb-3">
          <span class="badge" style="background:${DIFFICULTY_COLORS[q.difficulty] || "#94a3b8"}1a; color:${DIFFICULTY_COLORS[q.difficulty] || "#64748b"};">${DIFFICULTY_LABELS[q.difficulty] || q.difficulty || ""}</span>
          ${q.kazanim ? `<span class="text-xs text-slate-400">${escapeHtml(q.kazanim)}</span>` : ""}
        </div>
        ${q.image_url ? `<img src="${escapeHtml(q.image_url)}" alt="Soru görseli" class="rounded-xl mb-3 max-h-72 object-contain mx-auto" />` : ""}
        <p class="font-semibold text-slate-900 leading-relaxed whitespace-pre-line">${escapeHtml(q.question_text)}</p>
        <div id="pe-choices" class="space-y-2 mt-4">
          ${(q.choices || []).map((c) => `
            <button class="choice-btn w-full text-left px-4 py-3 rounded-xl border border-slate-200 hover:border-teal-300 hover:bg-teal-50/40 transition text-sm font-medium text-slate-700" data-choice="${c.id}">
              ${escapeHtml(c.choice_text)}
            </button>`).join("")}
        </div>
        <div id="pe-result-area" class="mt-4"></div>
      </div>`;

    mountEl.querySelectorAll(".choice-btn").forEach((btn) => {
      btn.addEventListener("click", () => handleAnswer(q, btn, startedAt));
    });
  }

  async function handleAnswer(q, btn, startedAt) {
    if (answering) return;
    answering = true;

    mountEl.querySelectorAll(".choice-btn").forEach((b) => (b.disabled = true));
    btn.classList.add("opacity-70");

    const timeSpent = Math.round((Date.now() - startedAt) / 1000);
    const { data, error } = await supabase.rpc("submit_answer", {
      p_question_id: q.id,
      p_choice_id: btn.dataset.choice,
      p_time_spent_seconds: timeSpent,
    });

    if (error || !data) {
      toast(error?.message || "Cevap gönderilemedi.", "error");
      mountEl.querySelectorAll(".choice-btn").forEach((b) => (b.disabled = false));
      answering = false;
      return;
    }

    tally.total++;
    if (data.is_correct) tally.correct++;

    mountEl.querySelectorAll(".choice-btn").forEach((b) => {
      const id = b.dataset.choice;
      if (id === data.correct_choice_id) {
        b.classList.add("border-emerald-400", "bg-emerald-50", "text-emerald-700");
        b.innerHTML += ` <span class="float-right">✅</span>`;
      } else if (id === btn.dataset.choice && !data.is_correct) {
        b.classList.add("border-rose-400", "bg-rose-50", "text-rose-700");
        b.innerHTML += ` <span class="float-right">❌</span>`;
      }
    });

    const headerWrap = mountEl.querySelector(":scope > div:first-child");
    if (headerWrap && showHeader) headerWrap.outerHTML = statsHeader();

    const reachedTarget = sessionTarget != null && tally.total >= sessionTarget;
    const resultArea = document.getElementById("pe-result-area");
    resultArea.innerHTML = `
      <div class="rounded-xl p-4 ${data.is_correct ? "bg-emerald-50 border border-emerald-100" : "bg-rose-50 border border-rose-100"} fadeIn">
        <p class="font-bold ${data.is_correct ? "text-emerald-700" : "text-rose-700"}">${data.is_correct ? "🎉 Doğru cevap!" : "😕 Yanlış cevap"}</p>
        ${!data.is_correct ? `<p class="text-sm text-slate-600 mt-1">Doğru cevap: <strong>${escapeHtml(data.correct_choice_text || "")}</strong></p>` : ""}
        <div id="pe-explanation-box" class="mt-3">
          <div class="skeleton h-4 w-2/3"></div>
        </div>
        <button id="pe-next-btn" class="btn-primary mt-4 px-5 py-2.5 text-sm">${reachedTarget ? "Bitir ve Sonucu Gör →" : "Sonraki Soru →"}</button>
      </div>`;

    document.getElementById("pe-next-btn").addEventListener("click", () => {
      if (reachedTarget) finishSession();
      else loadNextQuestion();
    });

    loadExplanation(q.id);
  }

  async function finishSession() {
    if (finished) return;
    finished = true;

    const pct = tally.total ? Math.round((tally.correct / tally.total) * 100) : 0;

    mountEl.innerHTML = `
      ${statsHeader()}
      <div class="card p-8 text-center fadeIn">
        <div class="text-5xl mb-3">${pct >= 70 ? "🏆" : pct >= 40 ? "👏" : "💪"}</div>
        <p class="text-xl font-extrabold text-slate-900">Oturum tamamlandı!</p>
        <p class="text-sm text-slate-500 mt-1">${escapeHtml(topicName || "")}</p>
        <p class="text-4xl font-extrabold mt-4" style="color:${scoreColor(pct)};">${tally.correct}/${tally.total}</p>
        <p class="text-sm font-semibold text-slate-500 mt-1">%${pct} başarı</p>
        <div class="grid grid-cols-2 gap-3 mt-6">
          <button id="pe-restart-btn" type="button" class="btn-secondary py-2.5 text-sm text-center">Tekrar Çöz</button>
          <a href="dashboard.html" class="btn-primary py-2.5 text-sm text-center">Panele Dön</a>
        </div>
      </div>`;

    document.getElementById("pe-restart-btn")?.addEventListener("click", () => start());

    if (sessionId && sessionRow && sessionRow.status !== "done") {
      const { error } = await supabase.rpc("complete_study_session", { p_session_id: sessionId });
      if (error) console.error("complete_study_session failed:", error);
      else toast("Görev tamamlandı olarak işaretlendi! 🎉", "success");
    }

    onFinished?.(tally);
  }

  async function loadExplanation(questionId) {
    const box = document.getElementById("pe-explanation-box");
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
    if (data.video_solution_url) parts.push(`<a href="${escapeHtml(data.video_solution_url)}" target="_blank" rel="noopener" class="inline-flex items-center gap-1.5 text-sm font-semibold text-teal-600 hover:underline mt-2">▶️ Video çözümü izle</a>`);

    box.innerHTML = parts.length ? parts.join("") : `<p class="text-sm text-slate-400 italic">Açıklama eklenmemiş.</p>`;
  }

  async function start() {
    finished = false;
    tally.correct = 0;
    tally.total = 0;
    servedQuestionIds.clear();
    await resolveSessionTarget();
    await loadNextQuestion();
  }

  return { start };
}
