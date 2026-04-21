<template>
  <div class="animation-frame">
    <div class="math-symbols">
      <div v-for="(s, i) in symbols" :key="i" :class="['symbol', 'monochrome-emoji', `explode-${i + 1}`]">
        {{ s }}
      </div>
    </div>

    <div class="theme-section">
      <h2 v-if="subtitle" class="theme-subtitle">{{ subtitle }}</h2>
      
      <p v-if="description" class="theme-description">{{ description }}</p>

      <ul class="theme-points">
        <li v-for="(item, i) in points" :key="i" :class="`point-${i + 1}`">
          <span class="custom-icon"></span>
          <span class="text" v-html="format(item.title)" @click="handleInlineClick"></span>
          <span v-if="item.desc" class="desc" v-html="format(item.desc)" @click="handleInlineClick"></span>
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup>
/**
 * @param subtitle - 本日のテーマなどの小見出し
 * @param description - リスト上の補足説明テキスト
 * @param points - { title: string, desc: string } の配列
 */
defineProps({
  subtitle: { type: String, default: '' },
  description: { type: String, default: '' },
  points: { type: Array, default: () => [] }
})

// JinanStep と共通のテキスト処理（[red][green][hl][en][jp]・太字・ルビ対応）
const format = (value = '') => {
  if (!value) return ''
  const escaped = value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')

  return escaped
    .replace(/\[red\](.+?)\[\/red\]/g, '<span class="desc-red">$1</span>')
    .replace(/\[green\](.+?)\[\/green\]/g, '<span class="desc-green">$1</span>')
    .replace(/\[(?:orange|orenge)\](.+?)\[\/(?:orange|orenge)\]/g, '<span class="desc-orange">$1</span>')
    .replace(/\[hl\](.+?)\[\/hl\]/g, '<span class="desc-hl">$1</span>')
    .replace(/\[en\](.+?)\[\/en\]/g, '<button type="button" class="ct-inline-speech" data-lang="en-US" data-text="$1"><strong>$1</strong></button>')
    .replace(/\[jp\](.+?)\[\/jp\]/g, '<button type="button" class="ct-inline-speech" data-lang="ja-JP" data-text="$1"><strong>$1</strong><span class="ct-speech-icon" aria-hidden="true">🔉</span></button>')
    .replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')
    .replace(/\{([^|]+)\|([^}]+)\}/g, '<ruby>$1<rt>$2</rt></ruby>')
}

// [en]...[/en] / [jp]...[/jp] インライン読み上げ
const handleInlineClick = (e) => {
  const rawTarget = e.target
  const targetEl = rawTarget instanceof Element ? rawTarget : rawTarget?.parentElement
  const btn = targetEl?.closest('.ct-inline-speech')
  if (!btn) return
  e.stopPropagation()
  window.speechSynthesis.cancel()
  const utter = new SpeechSynthesisUtterance(btn.dataset.text || btn.textContent || '')
  utter.lang = btn.dataset.lang === 'ja-JP' ? 'ja-JP' : 'en-US'
  utter.rate = btn.dataset.lang === 'ja-JP' ? 0.82 : 0.85
  window.speechSynthesis.speak(utter)
}

// ===== 文字候補 =====
// 元：数学記号
// const symbols = ['∫', '∞', '∑', 'Δ', '√', '∇', 'π', 'θ']

// 案1：コード・プログラミング系（寂しい感じ）
// const symbols = ['<', '/', '>', '=', '{', '}', '[', ']']

// 案2：幾何学・テック系
// const symbols = ['◆', '▶', '◀', '◎', '⬢', '⌘', '✦', '★']

// 案3：シンプル・サークル系
// const symbols = ['◉', '◎', '⟐', '◈', '★', '✦', '⬟', '▲']

// 案4：デザイン・フロー系
// const symbols = ['→', '←', '↑', '↓', '◆', '⊕', '◎', '✓']

// 案5：ミニマル・シンボル系
// const symbols = ['⚙', '⚡', '◆', '⊙', '⬢', '▶', '◀', '✦']

// ===== 色付きアイコン（システム開発系）=====
// 色付き案1：テック・デバイス系
// const symbols = ['💻', '📱', '⚙️', '🔧', '🚀', '✅', '🔒', '📊']

// 色付き案2：開発フロー系
//const symbols = ['🎯', '📋', '⚙️', '🚀', '✅', '📊', '🔧', '🌐']

// 色付き案3：システム・ネットワーク系
// const symbols = ['🖥️', '📡', '🔗', '⚡', '💾', '📱', '🛡️', '📈']

// 色付き案4：プロセス・ワークフロー系
// const symbols = ['📝', '✏️', '🔍', '💡', '⚙️', '✅', '🚀', '📊']

// 色付き案5：スマート開発・AI系
//const symbols = ['🤖', '🧠', '🔮', '⚡', '🎯', '🚀', '💎', '🌟']

// 選択したもの（アクティブ）：
const symbols = ['∫', '∞', '∑', 'Δ', '√', '∇', 'π', 'θ']
</script>

<style scoped>
/* --- メインフレーム（グローバル変数対応）--- */
.animation-frame {
  position: relative;
  width: min(980px, 100%);
  height: 400px;
  margin: -8px auto 0;
  border-radius: var(--app-radius, 24px);
  /* 背景グラデーションをグローバル変数で参照 */
  background: linear-gradient(
    145deg, 
    var(--app-bg-start, #ecfeff) 0%, 
    var(--app-bg-middle, #f8fafc) 45%, 
    var(--app-bg-end, #e2e8f0) 100%
  );
  box-shadow: inset 0 2px 10px rgba(0,0,0,0.05), var(--app-shadow, 0 10px 30px rgba(0,0,0,0.1));
  overflow: visible; /* 記号が外側へ飛び出す演出を許可 */
}

/* --- 記号アニメーション（全体4秒）--- */
.math-symbols {
  position: absolute;
  top: 50%; left: 50%;
  width: 0; height: 0;
  z-index: 10;
}

.symbol {
  position: absolute;
  top: 0; left: 0;
  font-size: 3.8rem;
  font-weight: 700;
  color: var(--app-text-main, #0f172a);
  opacity: 0;
  animation-duration: 4s !important;
  animation-timing-function: cubic-bezier(0.2, 0.8, 0.2, 1) !important;
  animation-fill-mode: both !important;
}

/* 絵文字を白黒に変換 */
.monochrome-emoji {
  filter: grayscale(100%) contrast(200%);
}

/* 記号ごとのアニメーション割り当て */
.explode-1 { animation-name: explode1; animation-delay: 0.1s; }
.explode-2 { animation-name: explode2; animation-delay: 0.15s; }
.explode-3 { animation-name: explode3; animation-delay: 0.2s; }
.explode-4 { animation-name: explode4; animation-delay: 0.25s; }
.explode-5 { animation-name: explode5; animation-delay: 0.3s; }
.explode-6 { animation-name: explode6; animation-delay: 0.35s; }
.explode-7 { animation-name: explode7; animation-delay: 0.4s; }
.explode-8 { animation-name: explode8; animation-delay: 0.45s; }

/* 放射状アニメーションの定義（45%付近で集まり、その後拡散） */
@keyframes explode1 { 0% { transform: translate(-50%, -50%) translate(0, -400px) scale(0.2); opacity: 0; } 15%, 45% { transform: translate(-50%, -50%) translate(0, -130px) scale(1); opacity: 1; } 100% { transform: translate(-50%, -50%) translate(0, -600px) scale(2); opacity: 0; } }
@keyframes explode2 { 0% { transform: translate(-50%, -50%) translate(400px, -400px) scale(0.2); opacity: 0; } 15%, 45% { transform: translate(-50%, -50%) translate(92px, -92px) scale(1); opacity: 1; } 100% { transform: translate(-50%, -50%) translate(600px, -600px) scale(2); opacity: 0; } }
@keyframes explode3 { 0% { transform: translate(-50%, -50%) translate(400px, 0) scale(0.2); opacity: 0; } 15%, 45% { transform: translate(-50%, -50%) translate(130px, 0) scale(1); opacity: 1; } 100% { transform: translate(-50%, -50%) translate(600px, 0) scale(2); opacity: 0; } }
@keyframes explode4 { 0% { transform: translate(-50%, -50%) translate(400px, 400px) scale(0.2); opacity: 0; } 15%, 45% { transform: translate(-50%, -50%) translate(92px, 92px) scale(1); opacity: 1; } 100% { transform: translate(-50%, -50%) translate(600px, 600px) scale(2); opacity: 0; } }
@keyframes explode5 { 0% { transform: translate(-50%, -50%) translate(0, 400px) scale(0.2); opacity: 0; } 15%, 45% { transform: translate(-50%, -50%) translate(0, 130px) scale(1); opacity: 1; } 100% { transform: translate(-50%, -50%) translate(0, 600px) scale(2); opacity: 0; } }
@keyframes explode6 { 0% { transform: translate(-50%, -50%) translate(-400px, 400px) scale(0.2); opacity: 0; } 15%, 45% { transform: translate(-50%, -50%) translate(-92px, 92px) scale(1); opacity: 1; } 100% { transform: translate(-50%, -50%) translate(-600px, 600px) scale(2); opacity: 0; } }
@keyframes explode7 { 0% { transform: translate(-50%, -50%) translate(-400px, 0) scale(0.2); opacity: 0; } 15%, 45% { transform: translate(-50%, -50%) translate(-130px, 0) scale(1); opacity: 1; } 100% { transform: translate(-50%, -50%) translate(-600px, 0) scale(2); opacity: 0; } }
@keyframes explode8 { 0% { transform: translate(-50%, -50%) translate(-400px, -400px) scale(0.2); opacity: 0; } 15%, 45% { transform: translate(-50%, -50%) translate(-92px, -92px) scale(1); opacity: 1; } 100% { transform: translate(-50%, -50%) translate(-600px, -600px) scale(2); opacity: 0; } }

/* --- テキストセクション --- */
.theme-section {
  position: absolute;
  top: 58px;
  left: 50%;
  transform: translateX(-50%);
  width: min(840px, 96%);
  display: flex;
  flex-direction: column;
  align-items: center;
  z-index: 5;
}

.theme-subtitle {
  font-size: var(--app-font-size-title, 2.5rem) !important;
  font-weight: bold !important;
  color: var(--app-title-color, #164e63) !important;
  margin-bottom: 30px !important;
  position: relative;
  top: -1em;
  /* 記号が整った後に見出しを表示（2.2秒遅延） */
  animation: fadeInUp 0.8s ease-out 2.2s both;
}

.theme-description {
  font-size: 1.1rem;
  color: var(--app-text-sub, #64748b);
  margin-bottom: 15px;
  animation: fadeInUp 0.8s ease-out 2.4s both;
}

/* --- リストスタイル --- */
.theme-points {
  list-style: none !important;
  padding: 0 !important;
  margin: 0 !important;
  position: relative;
  top: -1.8em;
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 100%;
}

.theme-points li {
  display: flex;
  align-items: center;
  font-size: var(--app-font-size-body, 1.6rem);
  font-weight: 600;
  color: var(--app-text-main, #1f2937);
  background: rgba(255, 255, 255, 0.6);
  padding: 10px 20px;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0,0,0,0.05);
  opacity: 0;
  animation: slideInRight 0.6s ease-out both;
}

/* リストのスライドイン遅延 */
.point-1 { animation-delay: 2.6s !important; }
.point-2 { animation-delay: 2.8s !important; }
.point-3 { animation-delay: 3.0s !important; }
.point-4 { animation-delay: 3.2s !important; } /* 4項目目があっても対応可能 */

/* --- アイコン（シンプルな枠）--- */
.custom-icon {
  width: 20px; height: 20px;
  border: 2px solid var(--app-accent, #06b6d4);
  margin-right: 15px;
  flex-shrink: 0;
}

.text { margin-right: 15px; }
.desc {
  font-size: 1.1rem;
  color: var(--app-text-sub, #64748b);
  font-weight: normal;
}

.desc-red {
  color: #dc2626;
}

.desc-green {
  color: #2f855a;
}

.desc-orange {
  color: #c2410c;
  font-weight: 800;
  text-shadow: 0 1px 0 rgba(90, 90, 90, 0.28);
}

.desc-hl {
  background: #fef3c7;
  border: 1px solid #fde68a;
  border-radius: 0.3em;
  padding: 0.02em 0.3em;
  color: #5b4630;
}

/* [en]...[/en] / [jp]...[/jp] インライン読み上げボタン */
:deep(.ct-inline-speech) {
  background: none;
  border: none;
  padding: 0 1px;
  cursor: pointer;
  color: inherit;
  font-size: inherit;
  font-family: inherit;
}

:deep(.ct-inline-speech:hover) {
  opacity: 0.7;
}

:deep(.ct-speech-icon) {
  margin-left: 0.2em;
  font-size: 0.9em;
}

/* ルビの調整 */
:deep(rt) {
  font-size: 0.55em;
  color: #000000;
  font-weight: 700;
}

/* --- アニメーション補助 --- */
@keyframes fadeInUp {
  0% { transform: translateY(20px); opacity: 0; }
  100% { transform: translateY(0); opacity: 1; }
}

@keyframes slideInRight {
  0% { transform: translateX(30px); opacity: 0; }
  100% { transform: translateX(0); opacity: 1; }
}
</style>


