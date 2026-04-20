<script setup lang="ts">
import { computed } from 'vue'

const props = withDefaults(defineProps<{
  clicks?: number
  items?: {
    id: number
    type: string   // 'circle' | 'square' | 'triangle' | 'arrow'
    text?: string  // 中に入れる文字
    color: string
    finalX: number
    startX: number
    startY: number
    startRot: number
  }[]
}>(), {
  clicks: 0,
  items: () => []
})

const visibleItems = computed(() => {
  return props.items.filter((_, index) => props.clicks > index)
})
</script>

<template>
  <div class="shapes-scene">
    <TransitionGroup name="assemble">
      <div 
        v-for="item in visibleItems" 
        :key="item.id" 
        class="shape-wrapper"
        :style="{
          '--final-x': `${item.finalX}px`,
          '--start-x': `${item.startX}px`,
          '--start-y': `${item.startY}px`,
          '--start-rot': `${item.startRot}deg`,
          '--shape-color': item.color
        }"
      >
        <div v-if="item.type === 'circle'" class="shape-bg circle"></div>
        <div v-if="item.type === 'square'" class="shape-bg square"></div>
        <div v-if="item.type === 'triangle'" class="shape-bg triangle"></div>
        <svg v-if="item.type === 'arrow'" viewBox="0 0 120 80" class="shape-bg svg-arrow">
          <polygon points="5,5 85,5 115,40 85,75 5,75" :fill="item.color" stroke="#1b365d" stroke-width="3" stroke-linejoin="round" />
        </svg>

        <div 
          v-if="item.text" 
          class="shape-text" 
          :class="{'triangle-text-offset': item.type === 'triangle'}"
        >
          {{ item.text }}
        </div>
      </div>
    </TransitionGroup>
  </div>
</template>

<style scoped>
.shapes-scene {
  position: relative;
  width: 100%;
  height: 400px;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
}

/* 図形と文字をまとめる枠 */
.shape-wrapper {
  position: absolute;
  width: 120px;
  height: 120px;
  display: flex;
  justify-content: center;
  align-items: center;
  transform: translate(var(--final-x), 0);
  transition: all 1.5s cubic-bezier(0.25, 1, 0.5, 1);
}

/* --- 背景の図形設定 --- */
.shape-bg {
  position: absolute;
}
.circle { width: 100px; height: 100px; border-radius: 50%; background-color: var(--shape-color); }
.square { width: 100px; height: 100px; border-radius: 12px; background-color: var(--shape-color); }
.triangle {
  width: 0; height: 0;
  border-left: 60px solid transparent;
  border-right: 60px solid transparent;
  border-bottom: 104px solid var(--shape-color);
  transform: translateY(-10px); /* 見た目の中央を調整 */
}
.svg-arrow { width: 120px; height: 80px; }

/* --- 文字の設定 --- */
.shape-text {
  position: relative;
  z-index: 10;
  color: #fff; /* 文字色（白） */
  font-weight: bold;
  font-size: 1.5rem;
  text-shadow: 1px 1px 3px rgba(0,0,0,0.4); /* 背景に同化しないよう影をつける */
}
/* 三角形は重心が下にあるため、文字位置を少し下にずらす */
.triangle-text-offset {
  transform: translateY(15px);
}

/* --- アニメーションの初期位置 --- */
.assemble-enter-from {
  opacity: 0;
  transform: translate(var(--start-x), var(--start-y)) rotate(var(--start-rot));
}

.assemble-enter-active {
  transition: all 1.5s cubic-bezier(0.25, 1, 0.5, 1);
}
</style>