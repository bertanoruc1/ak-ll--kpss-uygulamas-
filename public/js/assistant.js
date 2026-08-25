import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js";
import { toast, escapeHtml } from "./ui.js";

const auth = await requireAuth();
if (!auth) {
  throw new Error("not authenticated");
}

mountNav("assistant.html");

const chatList = document.getElementById("chat-list");
const chatScroll = document.getElementById("chat-scroll");
const chipRow = document.getElementById("chip-row");
const chatForm = document.getElementById("chat-form");
const chatInput = document.getElementById("chat-input");
const sendBtn = document.getElementById("send-btn");

const STARTER_PROMPTS = [
  "Bugün ne çalışmalıyım?",
  "Başarı oranım ne?",
  "Sınava kaç gün kaldı?",
  "Bana bir çalışma tavsiyesi ver",
];

const messages = [];
let sending = false;
// Bir kere "gerçek LLM'e bağlı değil" (ai-chat henüz deploy/config
// edilmemiş) olduğu anlaşılınca, aynı sayfa oturumunda her mesajda tekrar
// tekrar denemek yerine doğrudan eski kural tabanlı RPC'yi kullan — hem
// gereksiz ağ isteğini önler hem de kullanıcı beklemez.
let llmUnavailable = false;

function bubbleHtml(msg) {
  if (msg.role === "user") {
    return `
      <div class="flex justify-end fadeIn">
        <div class="max-w-[80%] bg-teal-600 text-white rounded-2xl rounded-br-md px-4 py-2.5 text-sm shadow-sm">
          ${escapeHtml(msg.text)}
        </div>
      </div>`;
  }
  return `
    <div class="flex justify-start items-end gap-2 fadeIn">
      <div class="w-8 h-8 rounded-full flex items-center justify-center text-base shrink-0" style="background: linear-gradient(135deg, #0f766e, #0ea5e9 55%, #22d3ee);">🤖</div>
      <div class="max-w-[80%] bg-white border border-slate-100 rounded-2xl rounded-bl-md px-4 py-2.5 text-sm text-slate-700 shadow-sm">
        ${escapeHtml(msg.text)}
      </div>
    </div>`;
}

function typingHtml() {
  return `
    <div id="typing-indicator" class="flex justify-start items-end gap-2 fadeIn">
      <div class="w-8 h-8 rounded-full flex items-center justify-center text-base shrink-0" style="background: linear-gradient(135deg, #0f766e, #0ea5e9 55%, #22d3ee);">🤖</div>
      <div class="bg-white border border-slate-100 rounded-2xl rounded-bl-md px-4 py-3 shadow-sm flex items-center gap-1">
        <span class="w-1.5 h-1.5 rounded-full bg-slate-400 typing-dot"></span>
        <span class="w-1.5 h-1.5 rounded-full bg-slate-400 typing-dot"></span>
        <span class="w-1.5 h-1.5 rounded-full bg-slate-400 typing-dot"></span>
      </div>
    </div>`;
}

function renderMessages() {
  chatList.innerHTML = messages.map(bubbleHtml).join("") || emptyStateHtml();
}

function emptyStateHtml() {
  return `
    <div class="text-center py-10 fadeIn">
      <div class="text-4xl mb-2">🤖</div>
      <p class="text-slate-500 text-sm">Merhaba! Bana bir konu/ders adı, "bugün ne çalışmalıyım", "başarı oranım", "seviyem" ya da "motivasyona ihtiyacım var" gibi istediğin gibi sorabilirsin — belirli kalıplara bağlı değilim.</p>
    </div>`;
}

function renderChips() {
  chipRow.innerHTML = STARTER_PROMPTS.map((p) =>
    `<button type="button" data-prompt="${escapeHtml(p)}" class="chip-btn text-xs font-medium px-3 py-1.5 rounded-full border border-teal-200 bg-teal-50 text-teal-700 hover:bg-teal-100 transition">${escapeHtml(p)}</button>`
  ).join("");

  chipRow.querySelectorAll(".chip-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      sendMessage(btn.dataset.prompt);
    });
  });
}

function scrollToBottom() {
  chatScroll.scrollTop = chatScroll.scrollHeight;
}

// Gerçek bir Claude modeline bağlı serbest sohbet — ai-chat Edge Function'ı
// çağırır, son birkaç mesajı (konuşma geçmişi) de yollar ki bağlamı takip
// edebilsin. Fonksiyon henüz deploy/config edilmediyse (llm_not_configured)
// SESSİZCE eski kural tabanlı ai_assistant_ask RPC'sine döner — sayfa hiçbir
// zaman kırılmaz, sadece "akıllılık seviyesi" ayarlanana kadar eskisi gibi çalışır.
async function askLlm(trimmed) {
  const history = messages
    .filter((m) => m.role === "user" || m.role === "assistant")
    .slice(-16)
    .map((m) => ({ role: m.role, text: m.text }));

  const { data, error } = await supabase.functions.invoke("ai-chat", {
    body: { message: trimmed, history },
  });

  if (error || !data || data.error) {
    if (data?.error === "llm_not_configured" || error) {
      llmUnavailable = true;
    }
    return null;
  }
  return data.reply || null;
}

async function askRuleBasedFallback(trimmed) {
  const { data, error } = await supabase.rpc("ai_assistant_ask", { p_message: trimmed });
  if (error) return null;
  return data?.response || null;
}

async function sendMessage(text) {
  const trimmed = (text || "").trim();
  if (!trimmed || sending) return;

  sending = true;
  sendBtn.disabled = true;
  chatInput.value = "";
  chipRow.classList.add("hidden");

  messages.push({ role: "user", text: trimmed });
  renderMessages();
  chatList.insertAdjacentHTML("beforeend", typingHtml());
  scrollToBottom();

  let replyText = null;
  if (!llmUnavailable) {
    replyText = await askLlm(trimmed);
  }
  if (replyText === null) {
    replyText = await askRuleBasedFallback(trimmed);
  }

  document.getElementById("typing-indicator")?.remove();

  if (replyText === null) {
    toast("Asistan şu anda yanıt veremiyor.", "error");
    messages.push({ role: "assistant", text: "Üzgünüm, şu anda yanıt veremiyorum. Lütfen tekrar dener misin?" });
  } else {
    messages.push({ role: "assistant", text: replyText });
  }

  renderMessages();
  scrollToBottom();
  sending = false;
  sendBtn.disabled = false;
  chatInput.focus();
}

chatForm.addEventListener("submit", (e) => {
  e.preventDefault();
  sendMessage(chatInput.value);
});

renderChips();
renderMessages();
