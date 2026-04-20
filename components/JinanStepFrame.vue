<script setup lang="ts">
const props = withDefaults(defineProps<{
  variant?: 'beige' | 'white' | 'point-bg'
  speechText?: string       // 読み上げる英語テキスト
  speechLinkText?: string   // リンクの表示ラベル
  speechRate?: number       // 読み上げ速度（デフォルト 0.9）
}>(), {
  variant: 'beige',
  speechText: '',
  speechLinkText: '▶ Read in English',
  speechRate: 0.9
})

function speak() {
  if (!props.speechText) return
  window.speechSynthesis.cancel()
  const utter = new SpeechSynthesisUtterance(props.speechText)
  utter.lang = 'en-US'
  utter.rate = props.speechRate
  window.speechSynthesis.speak(utter)
}
</script>

<template>
  <div :class="['jinan-step-frame', `jinan-step-frame--${props.variant}`]">
    <div v-if="$slots['header-actions']" class="frame-header-actions">
      <slot name="header-actions" />
    </div>
    <slot />
    <div v-if="props.speechText" class="speech-link-wrap">
      <button class="speech-link" @click="speak">
        {{ props.speechLinkText }}
      </button>
    </div>
  </div>
</template>

<style scoped>
.jinan-step-frame {
  position: relative;
  width: min(980px, 100%);
  margin: 0px auto 0;
  padding: 32px 44px;
  border-radius: var(--app-radius, 24px);
  text-align: left;
}

.frame-header-actions {
  position: absolute;
  top: 20px;
  right: 24px;
  z-index: 5;
}

.jinan-step-frame--beige {
  background: linear-gradient(
    145deg,
    var(--app-bg-start, #d9c9b2) 0%,
    var(--app-bg-middle, #bda78d) 45%,
    var(--app-bg-end, #a78c6f) 100%
  );
  box-shadow: inset 0 2px 10px rgba(0, 0, 0, 0.05), var(--app-shadow, 0 10px 30px rgba(0, 0, 0, 0.1));
}

.jinan-step-frame--white {
  background: #ffffff;
  box-shadow: inset 0 1px 4px rgba(0, 0, 0, 0.04), var(--app-shadow, 0 8px 24px rgba(0, 0, 0, 0.08));
}

.jinan-step-frame--point-bg {
  background: transparent;
  box-shadow: none;
}

.speech-link-wrap {
  margin-top: 14px;
  text-align: right;
}

.speech-link {
  font-size: 0.95rem;
  color: var(--app-title-color, #5b4630);
  text-decoration: underline;
  text-underline-offset: 3px;
}

.speech-link:hover {
  opacity: 0.85;
}
</style>
