// Geriye dönük uyumluluk katmanı: "Sorular" artık ayrı bir bölüm değil,
// doğrudan konu sayfasının (topic.html) içine gömülü — bkz. topic.js ve
// practiceEngine.js. Bu dosya sadece eski bağlantıları (yer imleri, dışarıdan
// gelen linkler) doğru yere yönlendirir.
const params = new URLSearchParams(window.location.search);
const topicId = params.get("topic");
const sessionId = params.get("session");

if (topicId) {
  const target = new URLSearchParams();
  target.set("id", topicId);
  if (sessionId) target.set("session", sessionId);
  window.location.replace(`topic.html?${target.toString()}`);
} else {
  window.location.replace("subjects.html");
}
