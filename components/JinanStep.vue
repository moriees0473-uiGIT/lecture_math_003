<script setup lang="ts">
import { computed } from 'vue'

const props = withDefaults(defineProps<{
  title?: string // 表示用テキスト
  kind?: 'title' | 'subtitle' | 'body' // 文字サイズの種類
  highlight?: boolean // 全文を背景ハイライトする
  speechText?: string // 読み上げ専用テキスト
  mathSize?: 'small' | 'normal' | 'large' | 'largel' | 'laerge' // 数式の文字サイズ
}>(), {
  kind: 'subtitle',
  highlight: false,
  speechText: '',
  mathSize: 'normal'
})

const displayText = computed(() => {
  if ((props.title ?? '').trim()) {
    return props.title || ''
  }

  if ((props.speechText ?? '').trim()) {
    return props.speechText || ''
  }

  return ''
})

const getVoicesReady = async () => {
  if (typeof window === 'undefined' || !('speechSynthesis' in window) || !('SpeechSynthesisUtterance' in window)) {
    return [] as SpeechSynthesisVoice[]
  }

  const initialVoices = window.speechSynthesis.getVoices()
  if (initialVoices.length > 0) return initialVoices

  // 初回は音声一覧が空のことがあるため、イベント到着を短時間待つ
  const loadedVoices = await new Promise<SpeechSynthesisVoice[]>((resolve) => {
    const timer = window.setTimeout(() => {
      resolve(window.speechSynthesis.getVoices())
    }, 500)

    const onVoicesChanged = () => {
      window.clearTimeout(timer)
      resolve(window.speechSynthesis.getVoices())
    }

    window.speechSynthesis.addEventListener('voiceschanged', onVoicesChanged, { once: true })
  })

  return loadedVoices
}

const speakInline = async (text: string, lang: 'ja-JP' | 'en-US') => {
  if (typeof window === 'undefined' || !text) return
  if (!('speechSynthesis' in window) || !('SpeechSynthesisUtterance' in window)) return

  window.speechSynthesis.cancel()

  const utterance = new SpeechSynthesisUtterance(text)
  utterance.lang = lang
  utterance.rate = lang === 'ja-JP' ? 0.82 : 0.85

  const voices = await getVoicesReady()
  const targetVoice = lang === 'ja-JP'
    ? voices.find((voice) => /microsoft/i.test(voice.name) && /nanami/i.test(voice.name))
      || voices.find((voice) => voice.lang.toLowerCase().startsWith('ja'))
    : voices.find((voice) => voice.lang.toLowerCase().startsWith('en'))

  if (targetVoice) {
    utterance.voice = targetVoice
  }

  window.speechSynthesis.speak(utterance)
}

const renderMathContent = (expression: string) => {
  const placeholders: string[] = []
  const makePlaceholder = (index: number) => `\u0000${index}\u0000`

  let html = expression
    .replace(/sqrt\(([^()]+)\)/g, (_, radicand: string) => {
      const index = placeholders.push(
        `<span class="step-math-root"><span class="step-math-root-sign">√</span><span class="step-math-root-body">${renderMathContent(radicand)}</span></span>`
      ) - 1

      return makePlaceholder(index)
    })
    // 括弧全体の累乗 (a-b)^2 や通常の x^2 に対応
    .replace(/(\([^()]+\)|[A-Za-z0-9])\^(\d+)/g, (_, base: string, power: string) => {
      const index = placeholders.push(
        `<span class=\"step-math-inline\"><span class=\"step-math-var\">${base}</span><sup class=\"step-math-sup\">${power}</sup></span>`
      ) - 1
      return makePlaceholder(index)
    })

  html = html
    .replace(/([A-Za-z])/g, '<span class="step-math-var">$1</span>')
    .replace(/\u0000(\d+)\u0000/g, (_, index: string) => placeholders[Number(index)])

  return html
}

const normalizeMathSize = (mathSize: 'small' | 'normal' | 'large' | 'largel' | 'laerge') => {
  if (mathSize === 'largel' || mathSize === 'laerge') return 'large'
  return mathSize
}

const renderMathExpression = (expression: string, mathSize: 'small' | 'normal' | 'large' | 'largel' | 'laerge') => {
  const normalizedSize = normalizeMathSize(mathSize)
  const cls = normalizedSize === 'normal'
    ? 'step-math'
    : `step-math step-math--${normalizedSize}`
  return `<span class="${cls}">${renderMathContent(expression)}</span>`
}

// 文字列処理関数（色・太字・ルビ・インライン読み上げに対応）
const format = (text: string) => {
  if (!text) return ''
  const escaped = text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')

  return escaped
    .replace(/\\n|\r\n|\r|\n/g, '<br/>')
    .replace(/\[math\](.+?)\[\/math\]/g, (_, expression: string) => renderMathExpression(expression, 'normal'))
    .replace(/\[red\](.+?)\[\/red\]/g, '<span class="step-red">$1</span>')
    .replace(/\[green\](.+?)\[\/green\]/g, '<span class="step-green">$1</span>')
    .replace(/\[gray\](.+?)\[\/gray\]/g, '<span class="step-gray">$1</span>')
    .replace(/\[(?:orange|orenge)\](.+?)\[\/(?:orange|orenge)\]/g, '<span class="step-orange">$1</span>')
    .replace(/\[hl\](.+?)\[\/hl\]/g, '<span class="step-hl">$1</span>')
    .replace(/\[en\](.+?)\[\/en\]/g, '<button type="button" class="step-inline-speech step-inline-speech--en" data-lang="en-US" data-text="$1"><strong>$1</strong></button>')
    .replace(/\[jp\](.+?)\[\/jp\]/g, '<button type="button" class="step-inline-speech step-inline-speech--jp" data-lang="ja-JP" data-text="$1"><strong>$1</strong><span class="step-speech-icon" aria-hidden="true">🔉</span></button>')
    .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    // Convert power notation like x^2 into a math-like superscript rendering.
    .replace(/([A-Za-z0-9])\^(\d+)/g, '<span class="step-math-var">$1</span><sup class="step-math-sup">$2</sup>')
    .replace(/\{([^|]+)\|([^}]+)\}/g, '<ruby>$1<rt>$2</rt></ruby>')
}

// [en]...[/en] / [jp]...[/jp] のインライン読み上げ
const handleInlineClick = (e: MouseEvent) => {
  const rawTarget = e.target as Node | null
  const targetEl = rawTarget instanceof Element ? rawTarget : rawTarget?.parentElement
  const btn = targetEl?.closest('.step-inline-speech') as HTMLElement | null
  if (!btn) return
  e.stopPropagation()
  void speakInline(
    btn.dataset.text || btn.textContent || '',
    btn.dataset.lang === 'ja-JP' ? 'ja-JP' : 'en-US'
  )
}
</script>

<template>
  <div
    :class="['jinan-step-container', { 'jinan-step-container--highlight': props.highlight, 'jinan-step-container--body': props.kind === 'body' }]"
    :style="props.kind === 'body' ? { textAlign: 'left', display: 'block', width: '100%' } : {}"
  >
    <div class="jinan-step-row">
      <div
        :class="['step-title', `step-title--${props.kind}`]"
        :style="props.kind === 'body' ? { textAlign: 'left', display: 'block', width: '100%' } : {}"
        v-html="format(displayText)"
        @click="handleInlineClick"
      ></div>
    </div>
  </div>
</template>

<style scoped>
.jinan-step-container {
  margin: 0.6rem 0;
  font-family: 'Hiragino Kaku Gothic Pro', 'Meiryo', sans-serif;
  color: var(--app-text-main, #1f2937);
}

.jinan-step-container--highlight {
  padding: 12px 16px;
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.56);
}

.jinan-step-container--body {
  width: 100%;
  text-align: left;
  position: relative;
  z-index: 1;
}

.jinan-step-row {
  display: flex;
  align-items: flex-start;
  gap: 12px;
}

/* タイトル：太字で大きく */
.step-title {
  line-height: 1.2;
}

.step-title--title {
  font-size: max(var(--app-font-size-title, 2.5rem), 2.5rem);
  font-weight: 900;
  color: var(--app-title-color, #5b4630);
  margin-left: -1.5em;
}

.step-title--subtitle {
  font-size: max(var(--app-font-size-subtitle, 2.1rem), 2.1rem);
  font-weight: 900;
  color: var(--app-text-main, #3f3326);
  margin-top: 0.5em;
}

.step-title--body {
  font-size: max(var(--app-font-size-body, 1.9rem), 1.9rem);
  font-weight: 600;
  line-height: 1.45;
  color: var(--app-text-sub, #6f5c45);
  display: block;
  width: 100%;
  text-align: left;
}

:deep(.step-title--body strong) {
  font-weight: 900;
}

:deep(.step-red) {
  color: #dc2626;
}

:deep(.step-green) {
  color: #2f855a;
}

:deep(.step-gray) {
  color: #8a97a8;
}

:deep(.step-orange) {
  color: #c2410c;
  font-weight: 800;
  text-shadow: 0 1px 0 rgba(90, 90, 90, 0.28);
}

:deep(.step-hl) {
  background: #fef3c7;
  border: 1px solid #fde68a;
  border-radius: 0.3em;
  padding: 0.02em 0.3em;
  color: #5b4630;
}

:deep(.step-math) {
  display: inline-flex;
  align-items: flex-end;
  gap: 0.06em;
  font-family: 'Cambria Math', 'Times New Roman', serif;
  font-size: 1.3em;
  font-weight: 600;
  line-height: 1.08;
  white-space: pre;
  color: currentColor;
}

:deep(.step-math-inline) {
  display: inline-flex;
  align-items: flex-start;
  line-height: 1;
}

:deep(.step-math-var) {
  font-family: 'Cambria Math', 'Times New Roman', serif;
  font-style: italic;
  font-weight: 600;
}

:deep(.step-math-sup) {
  font-family: 'Cambria Math', 'Times New Roman', serif;
  font-style: italic;
  font-size: 0.5em;
  line-height: 1;
  margin-left: 0.02em;
  position: relative;
  top: -0.08em;
}

:deep(.step-math-root) {
  display: inline-flex;
  align-items: flex-start;
  margin-right: 0.05em;
}

:deep(.step-math-root-sign) {
  font-size: 0.95em;
  line-height: 0.98;
  margin-top: 0.2em;
}

:deep(.step-math-root-body) {
  position: relative;
  display: inline-block;
  margin-left: -0.14em;
  padding: 0.2em 0.12em 0 0.12em;
}

:deep(.step-math-root-body::before) {
  content: '';
  position: absolute;
  left: 0.08em;
  right: 0;
  top: calc(0.02em + 1px);
  border-top: 0.08em solid currentColor;
}

/* ルビの調整 */
:deep(rt) {
  font-size: 0.55em;
  color: #000000;
  font-weight: 700;
}

/* [en]...[/en] / [jp]...[/jp] インライン読み上げボタン */
:deep(.step-inline-speech) {
  background: none;
  border: none;
  padding: 0 1px;
  cursor: pointer;
  color: inherit;
  font-size: inherit;
  font-family: inherit;
  font-weight: inherit;
}

:deep(.step-inline-speech--en) {
  display: inline-block;
  white-space: nowrap;
  min-width: fit-content;
  text-align: left;
}

:deep(.step-inline-speech--jp) {
  display: block;
  width: 100%;
  white-space: normal;
  text-align: left;
}

:deep(.step-inline-speech:hover) {
  opacity: 0.7;
}

:deep(.step-speech-icon) {
  margin-left: 0.2em;
  font-size: 0.9em;
}
</style>