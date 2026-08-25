// Paylaşılan modern ikon seti (Heroicons-outline tarzı, elle yazılmış, inline SVG).
// Emoji tabanlı ikonların yerini alır: her ikon "currentColor" ile boyanır, böylece
// üzerine konduğu elemanın (nav-link, buton, rozet vb.) mevcut renk/hover/active
// geçişlerini otomatik olarak miras alır — ayrı bir renk yönetimine gerek kalmaz.
//
// Kullanım: import { icon } from "./icons.js";  el.innerHTML = icon("home");

const PATHS = {
  // Navigasyon
  home: '<path stroke-linecap="round" stroke-linejoin="round" d="M2.25 12l8.954-8.955a1.5 1.5 0 0 1 2.122 0L22.28 12M4.5 9.75V20.25a.75.75 0 0 0 .75.75H9.75v-5.25a.75.75 0 0 1 .75-.75h3a.75.75 0 0 1 .75.75V21h4.5a.75.75 0 0 0 .75-.75V9.75" />',
  "book-open": '<path stroke-linecap="round" stroke-linejoin="round" d="M12 6.75c-2.1-1.6-4.9-2.4-7.5-2.25v13.5c2.6-.15 5.4.65 7.5 2.25 2.1-1.6 4.9-2.4 7.5-2.25V4.5c-2.6-.15-5.4.65-7.5 2.25Zm0 0v13.5" />',
  "x-circle": '<path stroke-linecap="round" stroke-linejoin="round" d="M9.75 9.75l4.5 4.5m0-4.5-4.5 4.5M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />',
  newspaper: '<path stroke-linecap="round" stroke-linejoin="round" d="M4.5 6.75h9a1.5 1.5 0 0 1 1.5 1.5v10.5a1.5 1.5 0 0 1-1.5 1.5h-9a1.5 1.5 0 0 1-1.5-1.5V8.25a1.5 1.5 0 0 1 1.5-1.5Zm0 0V5.25a1.5 1.5 0 0 1 1.5-1.5h11.25a1.5 1.5 0 0 1 1.5 1.5v9A1.5 1.5 0 0 1 17.25 15.75h-1.5m-8.25-6h5.25m-5.25 3h5.25m-5.25 3h2.25" />',
  calendar: '<path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3.75 8.25h16.5M4.5 5.25h15A.75.75 0 0 1 20.25 6v13.5a.75.75 0 0 1-.75.75h-15a.75.75 0 0 1-.75-.75V6a.75.75 0 0 1 .75-.75Z" />',
  "chart-bar": '<path stroke-linecap="round" stroke-linejoin="round" d="M7.5 14.25v4.5m4.5-9v9m4.5-13.5v13.5M4.5 20.25h15" />',
  bell: '<path stroke-linecap="round" stroke-linejoin="round" d="M14.857 17.082a23.85 23.85 0 0 0 5.454-1.31A8.967 8.967 0 0 1 18 9.75V9A6 6 0 0 0 6 9v.75a8.967 8.967 0 0 1-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 0 1-5.714 0m5.714 0a3 3 0 1 1-5.714 0" />',
  sparkles: '<path stroke-linecap="round" stroke-linejoin="round" d="M9.813 15.904 9 18.75l-.813-2.846a4.5 4.5 0 0 0-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 0 0 3.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 0 0 3.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 0 0-3.09 3.09ZM18.259 8.715 18 9.75l-.259-1.035a3.375 3.375 0 0 0-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 0 0 2.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 0 0 2.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 0 0-2.456 2.456Z" />',
  user: '<path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z" />',
  logout: '<path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0 0 13.5 3h-6a2.25 2.25 0 0 0-2.25 2.25v13.5A2.25 2.25 0 0 0 7.5 21h6a2.25 2.25 0 0 0 2.25-2.25V15m3 0 3-3m0 0-3-3m3 3H9" />',
  target: '<path stroke-linecap="round" stroke-linejoin="round" d="M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18Z"/><path stroke-linecap="round" stroke-linejoin="round" d="M12 16.5a4.5 4.5 0 1 0 0-9 4.5 4.5 0 0 0 0 9Z"/><path stroke-linecap="round" stroke-linejoin="round" d="M12 12.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Z"/>',

  // Eylemler / durumlar
  trash: '<path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />',
  cog: '<path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.324.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 0 1 1.37.49l1.296 2.247a1.125 1.125 0 0 1-.26 1.431l-1.003.827c-.293.24-.438.613-.431.992a7.14 7.14 0 0 1 0 .255c-.007.378.138.75.43.99l1.005.828c.424.35.534.955.26 1.43l-1.298 2.247a1.125 1.125 0 0 1-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.47 6.47 0 0 1-.22.128c-.331.183-.581.495-.644.869l-.213 1.28c-.09.543-.56.941-1.11.941h-2.594c-.55 0-1.02-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 0 1-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 0 1-1.369-.49l-1.297-2.247a1.125 1.125 0 0 1 .26-1.431l1.004-.827c.292-.24.437-.613.43-.992a7.09 7.09 0 0 1 0-.255c.007-.378-.138-.75-.43-.99l-1.004-.828a1.125 1.125 0 0 1-.26-1.43l1.297-2.247a1.125 1.125 0 0 1 1.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.087.22-.128.332-.183.582-.495.644-.869l.214-1.28Z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />',
  "book-open-alt": '<path stroke-linecap="round" stroke-linejoin="round" d="M12 6.042A8.967 8.967 0 0 0 6 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 0 1 6 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 0 1 6-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0 0 18 18a8.967 8.967 0 0 0-6 2.292m0-14.25v14.25" />',
  pencil: '<path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125" />',
  "arrow-path": '<path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0 3.181 3.183a8.25 8.25 0 0 0 13.803-3.7M4.031 9.865a8.25 8.25 0 0 1 13.803-3.7l3.181 3.182m0-4.991v4.99" />',
  coffee: '<path stroke-linecap="round" stroke-linejoin="round" d="M3.75 9h13.5m-13.5 0a2.25 2.25 0 0 0-2.25 2.25v.75c0 3.9 3.15 7.05 7.05 7.05h1.35c3.9 0 7.05-3.15 7.05-7.05v-.75A2.25 2.25 0 0 0 17.25 9m-13.5 0V6.75A2.25 2.25 0 0 1 6 4.5h9a2.25 2.25 0 0 1 2.25 2.25V9m0 0h1.125c.87 0 1.575.705 1.575 1.575v.6c0 1.553-1.259 2.812-2.812 2.812H17.1" />',
  "paper-airplane": '<path stroke-linecap="round" stroke-linejoin="round" d="M6 12 3.269 3.126A59.77 59.77 0 0 1 21.485 12 59.77 59.77 0 0 1 3.27 20.874L5.999 12Zm0 0h7.5" />',
  "face-frown": '<path stroke-linecap="round" stroke-linejoin="round" d="M15.182 16.318A4.486 4.486 0 0 0 12.016 15a4.486 4.486 0 0 0-3.198 1.318M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-13.5-3h.008v.008H7.5V9Zm9 0h.008v.008H16.5V9Z" />',
  "exclamation-triangle": '<path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9 3.75h.008v.008H12v-.008Z" />',

  // Gamification / dashboard rozet ikonları (basit, elle çizilmiş çizgi ikonlar)
  fire: '<path stroke-linecap="round" stroke-linejoin="round" d="M12 21c-3.5 0-6-2.5-6-5.5 0-2.5 1.5-4 2.5-6 .5 1.5 1.5 2 1.5 2-.5-3 1-5.5 3-7-.5 2 .5 3.5 2 5 2 2 3 3.5 3 6 0 3-2.5 5.5-6 5.5Z" />',
  trophy: '<path stroke-linecap="round" stroke-linejoin="round" d="M8 4h8v4a4 4 0 0 1-8 0V4Z" /><path stroke-linecap="round" stroke-linejoin="round" d="M8 5H5a2 2 0 0 0 2 2M16 5h3a2 2 0 0 1-2 2M12 12v3m-3 3h6m-3 0v-3" />',
  star: '<path stroke-linecap="round" stroke-linejoin="round" d="m12 3 2.5 5.5L20 9.5l-4 4 1 6-5-3-5 3 1-6-4-4 5.5-1Z" />',
  "light-bulb": '<path stroke-linecap="round" stroke-linejoin="round" d="M9 18h6M10 21h4M12 3a6 6 0 0 0-3 11.2c.6.4 1 1.1 1 1.8h4c0-.7.4-1.4 1-1.8A6 6 0 0 0 12 3Z" />',
  clock: '<path stroke-linecap="round" stroke-linejoin="round" d="M12 7.5V12l3 1.75M20.25 12a8.25 8.25 0 1 1-16.5 0 8.25 8.25 0 0 1 16.5 0Z" />',
};

/**
 * Verilen isimdeki ikonu inline SVG string olarak döndürür.
 * @param {keyof typeof PATHS} name
 * @param {{size?: number, className?: string, strokeWidth?: number}} [opts]
 */
export function icon(name, opts = {}) {
  const { size = 20, className = "", strokeWidth = 1.8 } = opts;
  const d = PATHS[name];
  if (!d) return "";
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="${size}" height="${size}" fill="none" stroke="currentColor" stroke-width="${strokeWidth}" class="icon-svg ${className}" aria-hidden="true">${d}</svg>`;
}
