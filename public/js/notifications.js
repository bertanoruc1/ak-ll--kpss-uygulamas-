import { supabase } from "./supabaseClient.js";
import { requireAuth } from "./auth.js";
import { mountNav } from "./nav.js";
import { toast, escapeHtml, timeAgo } from "./ui.js";
import { NOTIFICATION_PRIORITY_LABELS, NOTIFICATION_PRIORITY_COLORS } from "./config.js";

const auth = await requireAuth();
if (!auth) {
  throw new Error("not authenticated");
}
const { user } = auth;

mountNav("notifications.html");

const listEl = document.getElementById("notif-list");
const emptyEl = document.getElementById("empty-state");
const errorEl = document.getElementById("error-state");
const markAllBtn = document.getElementById("mark-all-btn");

let notifications = [];

function priorityBadge(priority) {
  const color = NOTIFICATION_PRIORITY_COLORS[priority] || NOTIFICATION_PRIORITY_COLORS.normal;
  const label = NOTIFICATION_PRIORITY_LABELS[priority] || priority;
  return `<span class="badge" style="background:${color}1a; color:${color};">${escapeHtml(label)}</span>`;
}

function renderList() {
  if (notifications.length === 0) {
    listEl.innerHTML = "";
    emptyEl.classList.remove("hidden");
    return;
  }
  emptyEl.classList.add("hidden");
  listEl.innerHTML = notifications.map((n) => {
    const color = NOTIFICATION_PRIORITY_COLORS[n.priority] || NOTIFICATION_PRIORITY_COLORS.normal;
    const unread = !n.is_read;
    return `
      <button data-id="${n.id}" class="notif-item card p-4 text-left w-full transition fadeIn ${unread ? "bg-teal-50/50" : "bg-white"}" style="border-left: 4px solid ${color};">
        <div class="flex items-start justify-between gap-3">
          <div class="min-w-0 flex-1">
            <div class="flex items-center gap-2 flex-wrap">
              ${priorityBadge(n.priority)}
              ${unread ? '<span class="w-2 h-2 rounded-full bg-teal-500 shrink-0"></span>' : ""}
            </div>
            <p class="mt-1.5 ${unread ? "font-bold text-slate-900" : "font-medium text-slate-600"}">${escapeHtml(n.title || "")}</p>
            ${n.body ? `<p class="text-sm text-slate-500 mt-0.5">${escapeHtml(n.body)}</p>` : ""}
          </div>
          <span class="text-xs text-slate-400 shrink-0 whitespace-nowrap">${timeAgo(n.created_at)}</span>
        </div>
      </button>`;
  }).join("");

  listEl.querySelectorAll(".notif-item").forEach((btn) => {
    btn.addEventListener("click", () => handleNotifClick(btn.dataset.id));
  });
}

async function handleNotifClick(id) {
  const notif = notifications.find((n) => String(n.id) === String(id));
  if (!notif || notif.is_read) return;

  const { error } = await supabase.rpc("mark_notification_read", { p_id: notif.id });
  if (error) {
    toast("Bildirim güncellenemedi.", "error");
    return;
  }
  notif.is_read = true;
  renderList();
}

async function handleMarkAll() {
  markAllBtn.disabled = true;
  const { error } = await supabase.rpc("mark_all_notifications_read");
  markAllBtn.disabled = false;
  if (error) {
    toast("Bildirimler güncellenemedi.", "error");
    return;
  }
  await loadNotifications();
  toast("Tüm bildirimler okundu olarak işaretlendi.", "success");
}

async function loadNotifications() {
  errorEl.classList.add("hidden");
  const { data, error } = await supabase
    .from("notifications")
    .select("*")
    .eq("user_id", user.id)
    .order("created_at", { ascending: false });

  if (error) {
    toast("Bildirimler yüklenemedi.", "error");
    listEl.innerHTML = "";
    errorEl.classList.remove("hidden");
    return;
  }
  notifications = data || [];
  renderList();
}

document.getElementById("retry-btn").addEventListener("click", loadNotifications);
markAllBtn.addEventListener("click", handleMarkAll);

loadNotifications();
