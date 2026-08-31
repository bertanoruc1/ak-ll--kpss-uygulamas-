import { supabase } from "./supabaseClient.js";
import { requireAuth, signOut } from "./auth.js";
import { mountNav } from "./nav.js?v=3";
import { toast, escapeHtml, timeAgo } from "./ui.js?v=3";
import { EXAM_TYPE_LABELS, REPORT_TYPE_LABELS, REPORT_STATUS_LABELS, REPORT_STATUS_COLORS } from "./config.js";

const auth = await requireAuth();
if (!auth) {
  throw new Error("not authenticated");
}
const { user, profile } = auth;

mountNav("profile.html");

const contentEl = document.getElementById("content");
const errorEl = document.getElementById("error-state");

function initials(name, email) {
  const src = (name || email || "?").trim();
  return src.charAt(0).toUpperCase();
}

function examTypeOptions(selected) {
  return Object.entries(EXAM_TYPE_LABELS).map(([key, label]) =>
    `<option value="${key}" ${key === selected ? "selected" : ""}>${escapeHtml(label)}</option>`
  ).join("");
}

// Rozetler (achievements) veritabanında zaten arka planda kazanılıyordu
// (bkz. check_achievements RPC'si) ama hiçbir sayfa bunu göstermiyordu —
// kullanıcı rozet kazandığını hiç fark etmiyordu. Artık burada gösteriliyor.
const ACHIEVEMENT_ICONS = {
  ilk_soru: "🥇",
  yuz_soru: "💯",
  bin_soru: "🌙",
  yedi_gun_seri: "🔥",
  otuz_gun_seri: "🛡️",
};

function renderAchievements(achievements) {
  if (!achievements || achievements.length === 0) return "";
  const earnedCount = achievements.filter((a) => a.earned).length;
  return `
    <div class="card p-6">
      <div class="flex items-center justify-between mb-1">
        <p class="font-bold text-slate-900">🏆 Rozetlerim</p>
        <span class="text-xs font-semibold text-teal-600">${earnedCount}/${achievements.length}</span>
      </div>
      <p class="text-xs text-slate-400 mb-4">Çalıştıkça yeni rozetler kazanırsın.</p>
      <div class="grid grid-cols-3 sm:grid-cols-5 gap-3">
        ${achievements.map((a) => `
          <div class="flex flex-col items-center text-center gap-1 p-2 rounded-xl ${a.earned ? "bg-amber-50" : "bg-slate-50 opacity-50"}" title="${escapeHtml(a.description || "")}">
            <div class="text-3xl ${a.earned ? "" : "grayscale"}">${ACHIEVEMENT_ICONS[a.code] || "🏅"}</div>
            <p class="text-[11px] font-semibold ${a.earned ? "text-slate-800" : "text-slate-400"} leading-tight">${escapeHtml(a.name)}</p>
          </div>
        `).join("")}
      </div>
    </div>`;
}

function reportTypeOptions(selected) {
  return Object.entries(REPORT_TYPE_LABELS).map(([key, label]) =>
    `<option value="${key}" ${key === selected ? "selected" : ""}>${escapeHtml(label)}</option>`
  ).join("");
}

function myReportRowHtml(r) {
  const statusColor = REPORT_STATUS_COLORS[r.status] || "#64748b";
  return `
    <div class="py-3">
      <div class="flex items-center gap-2 flex-wrap">
        <span class="badge bg-teal-50 text-teal-700">${escapeHtml(REPORT_TYPE_LABELS[r.report_type] || r.report_type)}</span>
        <span class="badge" style="background:${statusColor}1a; color:${statusColor};">${escapeHtml(REPORT_STATUS_LABELS[r.status] || r.status)}</span>
        <span class="text-xs text-slate-400">${timeAgo(r.created_at)}</span>
      </div>
      <p class="text-sm text-slate-700 mt-1.5 whitespace-pre-line">${escapeHtml(r.message)}</p>
      ${r.admin_note ? `<p class="text-xs text-slate-500 mt-1.5 bg-slate-50 rounded-lg p-2"><strong>Yanıt:</strong> ${escapeHtml(r.admin_note)}</p>` : ""}
    </div>`;
}

function renderReportSection(myReports) {
  return `
    <div class="card p-6">
      <p class="font-bold text-slate-900">🐞 Sorun Bildir</p>
      <p class="text-xs text-slate-500 mt-1 mb-4">Bir hata mı gördün, eksik bir konu ya da soru mu fark ettin? Bize bildir, inceleyelim.</p>
      <form id="report-form" class="space-y-3">
        <label class="text-sm font-semibold text-slate-800 block">Kategori
          <select id="report_type" class="input mt-1.5">${reportTypeOptions("hata")}</select>
        </label>
        <label class="text-sm font-semibold text-slate-800 block">Açıklama
          <textarea id="report_message" required class="input mt-1.5" rows="3" placeholder="Ne oldu, nerede karşılaştın? Ne kadar detay verirsen o kadar hızlı çözeriz."></textarea>
        </label>
        <label class="text-sm font-semibold text-slate-800 block">İlgili sayfa/konu (opsiyonel)
          <input id="report_context" type="text" class="input mt-1.5" placeholder="ör. Matematik > Kümeler konusu" />
        </label>
        <button type="submit" id="report-submit-btn" class="btn-primary w-full py-3">Gönder</button>
      </form>
      ${myReports.length ? `
        <div class="mt-5 pt-4 border-t border-slate-100">
          <p class="text-xs font-bold text-slate-400 mb-1">Gönderdiğin Bildirimler</p>
          <div class="divide-y divide-slate-100">
            ${myReports.map((r) => myReportRowHtml(r)).join("")}
          </div>
        </div>` : ""}
    </div>`;
}

async function handleReportSubmit(e) {
  e.preventDefault();
  const btn = document.getElementById("report-submit-btn");
  const message = document.getElementById("report_message").value.trim();
  if (!message) {
    toast("Lütfen bir açıklama yaz.", "error");
    return;
  }
  btn.disabled = true;
  btn.textContent = "Gönderiliyor...";

  const { error } = await supabase.from("user_reports").insert({
    user_id: user.id,
    report_type: document.getElementById("report_type").value,
    message,
    page_context: document.getElementById("report_context").value.trim() || null,
  });

  btn.disabled = false;
  btn.textContent = "Gönder";

  if (error) {
    toast(error.message || "Bildirim gönderilemedi.", "error");
    return;
  }
  toast("Bildirimin alındı, teşekkürler!", "success");
  await loadProfile();
}

function render(student, gami, achievements, myReports) {
  const name = profile?.full_name || "";
  const email = profile?.email || user.email || "";

  contentEl.innerHTML = `
    <div class="space-y-5 fadeIn">
      <!-- Avatar + kimlik -->
      <div class="card p-6 flex items-center gap-4">
        <div class="w-16 h-16 rounded-full flex items-center justify-center text-2xl font-extrabold text-white shrink-0" style="background: linear-gradient(135deg, #0f766e, #0ea5e9 55%, #22d3ee);">
          ${escapeHtml(initials(name, email))}
        </div>
        <div class="min-w-0">
          <p class="font-bold text-lg text-slate-900 truncate">${escapeHtml(name || "İsimsiz Öğrenci")}</p>
          <p class="text-sm text-slate-500 truncate">${escapeHtml(email)}</p>
        </div>
      </div>

      <!-- Gamification istatistikleri -->
      <div class="grid grid-cols-3 gap-3">
        <div class="card p-4 text-center">
          <div class="text-2xl">🔥</div>
          <p class="text-xl font-extrabold text-slate-900 mt-1">${gami?.current_streak ?? 0}</p>
          <p class="text-xs text-slate-500">Gün Serisi</p>
        </div>
        <div class="card p-4 text-center">
          <div class="text-2xl">🏅</div>
          <p class="text-xl font-extrabold text-slate-900 mt-1">${gami?.level ?? 1}</p>
          <p class="text-xs text-slate-500">Seviye</p>
        </div>
        <div class="card p-4 text-center">
          <div class="text-2xl">✨</div>
          <p class="text-xl font-extrabold text-slate-900 mt-1">${gami?.xp ?? 0}</p>
          <p class="text-xs text-slate-500">XP</p>
        </div>
      </div>

      ${renderAchievements(achievements)}

      <!-- Düzenleme formu -->
      <form id="profile-form" class="card p-6 space-y-5">
        <p class="font-bold text-slate-900">Hesap ve Çalışma Tercihleri</p>

        <div>
          <label class="text-sm font-semibold text-slate-800 block mb-2">Ad Soyad</label>
          <input id="full_name" type="text" class="input" value="${escapeHtml(name)}" />
        </div>

        <div>
          <label class="text-sm font-semibold text-slate-800 block mb-2">Sınav Türü</label>
          <select id="exam_type" class="input">
            ${examTypeOptions(student?.exam_type)}
          </select>
          <p class="text-xs text-amber-600 mt-1.5">⚠️ Sınav türünü değiştirmek çalışma programını ve önerilen dersleri değiştirir.</p>
        </div>

        <div>
          <label class="text-sm font-semibold text-slate-800 block mb-2">Hedef Puan</label>
          <input id="target_score" type="number" step="0.01" class="input" value="${escapeHtml(student?.target_score ?? "")}" placeholder="ör. 85" />
        </div>

        <div>
          <label class="text-sm font-semibold text-slate-800 block mb-2">Günlük Çalışma Süresi (dk)</label>
          <input id="daily_study_minutes" type="number" class="input" value="${escapeHtml(student?.daily_study_minutes ?? 120)}" />
        </div>

        <div class="grid grid-cols-2 gap-3">
          <div>
            <label class="text-sm font-semibold text-slate-800 block mb-2">Başlangıç Saati</label>
            <input id="preferred_start_time" type="time" class="input" value="${escapeHtml((student?.preferred_start_time || "19:00").slice(0, 5))}" />
          </div>
          <div>
            <label class="text-sm font-semibold text-slate-800 block mb-2">Bitiş Saati</label>
            <input id="preferred_end_time" type="time" class="input" value="${escapeHtml((student?.preferred_end_time || "21:00").slice(0, 5))}" />
          </div>
        </div>

        <div>
          <label class="text-sm font-semibold text-slate-800 block mb-2">Bildirim Sıklığı</label>
          <select id="notification_frequency" class="input">
            <option value="low" ${student?.notification_frequency === "low" ? "selected" : ""}>Az</option>
            <option value="normal" ${!student?.notification_frequency || student?.notification_frequency === "normal" ? "selected" : ""}>Normal</option>
            <option value="high" ${student?.notification_frequency === "high" ? "selected" : ""}>Sık</option>
          </select>
        </div>

        <button type="submit" id="save-btn" class="btn-primary w-full py-3">Kaydet</button>
      </form>

      ${renderReportSection(myReports)}

      <button id="signout-btn" class="btn-secondary w-full py-3">Çıkış Yap</button>

      <div class="text-center">
        <a href="gizlilik.html" class="text-xs text-slate-400 hover:text-teal-600 hover:underline">Gizlilik Politikası</a>
      </div>

      <!-- Hesap silme -->
      <div class="card p-6 border border-rose-100">
        <p class="font-bold text-rose-600">⚠️ Tehlikeli Bölge</p>
        <p class="text-sm text-slate-500 mt-1 mb-4">Hesabını sildiğinde tüm ilerlemen, sohbet geçmişin ve kişisel verilerin kalıcı olarak silinir. Bu işlem geri alınamaz.</p>
        <button id="delete-account-btn" class="btn-secondary w-full py-3 text-rose-600 hover:bg-rose-50">Hesabımı Sil</button>
        <div id="delete-confirm-box" class="hidden mt-4 space-y-3 pt-4 border-t border-rose-100">
          <p class="text-sm text-slate-700">Emin misin? Onaylamak için aşağıya <strong>SİL</strong> yaz.</p>
          <input id="delete-confirm-input" type="text" class="input" placeholder="SİL" autocomplete="off" />
          <div class="flex gap-2">
            <button id="delete-confirm-cancel" type="button" class="btn-secondary flex-1 py-2.5">Vazgeç</button>
            <button id="delete-confirm-submit" type="button" class="btn-primary flex-1 py-2.5 bg-rose-600 hover:bg-rose-700">Kalıcı Olarak Sil</button>
          </div>
        </div>
      </div>
    </div>`;

  document.getElementById("profile-form").addEventListener("submit", handleSubmit);
  document.getElementById("report-form").addEventListener("submit", handleReportSubmit);
  document.getElementById("signout-btn").addEventListener("click", () => signOut());

  const deleteBtn = document.getElementById("delete-account-btn");
  const deleteBox = document.getElementById("delete-confirm-box");
  const deleteInput = document.getElementById("delete-confirm-input");
  const deleteSubmitBtn = document.getElementById("delete-confirm-submit");

  deleteBtn.addEventListener("click", () => {
    deleteBox.classList.remove("hidden");
    deleteBtn.classList.add("hidden");
    deleteInput.focus();
  });
  document.getElementById("delete-confirm-cancel").addEventListener("click", () => {
    deleteBox.classList.add("hidden");
    deleteBtn.classList.remove("hidden");
    deleteInput.value = "";
  });
  deleteSubmitBtn.addEventListener("click", async () => {
    if (deleteInput.value.trim().toUpperCase() !== "SİL" && deleteInput.value.trim().toUpperCase() !== "SIL") {
      toast("Onaylamak için kutuya \"SİL\" yazmalısın.", "error");
      return;
    }
    deleteSubmitBtn.disabled = true;
    deleteSubmitBtn.textContent = "Siliniyor...";
    const { error } = await supabase.rpc("delete_own_account");
    if (error) {
      toast(error.message || "Hesap silinemedi.", "error");
      deleteSubmitBtn.disabled = false;
      deleteSubmitBtn.textContent = "Kalıcı Olarak Sil";
      return;
    }
    await supabase.auth.signOut();
    window.location.href = "login.html";
  });
}

async function handleSubmit(e) {
  e.preventDefault();
  const btn = document.getElementById("save-btn");
  btn.disabled = true;
  btn.textContent = "Kaydediliyor...";

  const full_name = document.getElementById("full_name").value.trim();
  const exam_type = document.getElementById("exam_type").value;
  const target_score = document.getElementById("target_score").value;
  const daily_study_minutes = document.getElementById("daily_study_minutes").value;
  const preferred_start_time = document.getElementById("preferred_start_time").value;
  const preferred_end_time = document.getElementById("preferred_end_time").value;
  const notification_frequency = document.getElementById("notification_frequency").value;

  const [{ error: profileErr }, { error: studentErr }] = await Promise.all([
    supabase.from("profiles").update({ full_name }).eq("id", user.id),
    supabase.from("students").update({
      exam_type,
      target_score: target_score === "" ? null : Number(target_score),
      daily_study_minutes: daily_study_minutes === "" ? null : Number(daily_study_minutes),
      preferred_start_time,
      preferred_end_time,
      notification_frequency,
    }).eq("user_id", user.id),
  ]);

  btn.disabled = false;
  btn.textContent = "Kaydet";

  if (profileErr || studentErr) {
    toast((profileErr || studentErr).message || "Profil güncellenemedi.", "error");
    return;
  }
  toast("Profil güncellendi.", "success");
}

async function loadProfile() {
  errorEl.classList.add("hidden");
  const [{ data: student, error: studentErr }, { data: gami }, { data: achievements }, { data: myReports }] = await Promise.all([
    supabase.from("students").select("*").eq("user_id", user.id).single(),
    supabase.from("user_gamification").select("*").eq("user_id", user.id).single(),
    supabase.rpc("get_my_achievements"),
    supabase.from("user_reports").select("*").eq("user_id", user.id).order("created_at", { ascending: false }).limit(20),
  ]);

  if (studentErr) {
    toast("Profil yüklenemedi.", "error");
    contentEl.innerHTML = "";
    errorEl.classList.remove("hidden");
    return;
  }
  render(student, gami, achievements || [], myReports || []);
}

document.getElementById("retry-btn").addEventListener("click", loadProfile);

loadProfile();
