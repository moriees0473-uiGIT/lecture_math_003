<script setup lang="ts">
import { computed } from 'vue'

type ProcessStep = {
  id: number | string
  title: string
  color: string
  textColor?: string
}

const props = withDefaults(defineProps<{
  clicks?: number
  currentIndex?: number
  items?: ProcessStep[]
  stepWidth?: number
  stepHeight?: number
  headWidth?: number
  borderColor?: string
}>(), {
  clicks: 0,
  currentIndex: -1,
  items: () => [],
  stepWidth: 280,
  stepHeight: 84,
  headWidth: 44,
  borderColor: '#1f4a7a'
})

const visibleItems = computed(() => {
  if (props.currentIndex >= 0) return props.items
  return props.items.filter((_, index) => props.clicks > index)
})

const middleY = computed(() => props.stepHeight / 2)

const getPoints = (index: number, total: number) => {
  const width = props.stepWidth
  const height = props.stepHeight
  const headWidth = Math.min(props.headWidth, Math.floor(width / 3))
  const rightBaseX = width - headWidth
  const isFirst = index === 0
  const isLast = index === total - 1

  if (isFirst && isLast) {
    return [
      `0,0`,
      `${rightBaseX},0`,
      `${width},${middleY.value}`,
      `${rightBaseX},${height}`,
      `0,${height}`
    ].join(' ')
  }

  if (isFirst) {
    return [
      `0,0`,
      `${rightBaseX},0`,
      `${width},${middleY.value}`,
      `${rightBaseX},${height}`,
      `0,${height}`
    ].join(' ')
  }

  if (isLast) {
    return [
      `0,0`,
      `${rightBaseX},0`,
      `${width},${middleY.value}`,
      `${rightBaseX},${height}`,
      `0,${height}`,
      `${headWidth},${middleY.value}`
    ].join(' ')
  }

  return [
    `0,0`,
    `${rightBaseX},0`,
    `${width},${middleY.value}`,
    `${rightBaseX},${height}`,
    `0,${height}`,
    `${headWidth},${middleY.value}`
  ].join(' ')
}
</script>

<template>
  <div class="process-flow" :style="{
    '--step-width': `${props.stepWidth}px`,
    '--step-height': `${props.stepHeight}px`,
    '--head-width': `${props.headWidth}px`,
    '--border-color': props.borderColor
  }">
    <TransitionGroup name="process-flow-appear" tag="div" class="process-flow-track">
      <div
        v-for="(item, index) in visibleItems"
        :key="item.id"
        class="process-flow-step"
        :class="{ 'is-current': props.currentIndex === index, 'is-inactive': props.currentIndex >= 0 && props.currentIndex !== index }"
        :style="{
          '--step-color': item.color,
          '--text-color': item.textColor ?? '#ffffff',
          zIndex: visibleItems.length - index
        }"
      >
        <svg
          class="process-flow-shape"
          :viewBox="`0 0 ${props.stepWidth} ${props.stepHeight}`"
          preserveAspectRatio="none"
        >
          <polygon
            :points="getPoints(index, visibleItems.length)"
            :fill="item.color"
            :stroke="props.borderColor"
            stroke-width="3"
            stroke-linejoin="round"
          />
        </svg>
        <div class="process-flow-label">{{ item.title }}</div>
      </div>
    </TransitionGroup>
  </div>
</template>

<style scoped>
.process-flow {
  width: 100%;
  overflow: visible;
  display: flex;
  justify-content: center;
}

.process-flow-track {
  display: flex;
  align-items: center;
  justify-content: center;
}

.process-flow-step {
  position: relative;
  width: var(--step-width);
  height: var(--step-height);
  margin-left: calc(var(--head-width) * -1);
  display: flex;
  align-items: center;
  justify-content: center;
  flex: 0 0 auto;
  transition: opacity 0.4s ease, filter 0.4s ease;
}

.process-flow-step:first-child {
  margin-left: 0;
}

.process-flow-step.is-inactive {
  opacity: 0.38;
  filter: saturate(0.4);
}

.process-flow-step.is-current {
  opacity: 1;
  filter: none;
  z-index: 99 !important;
}

.process-flow-shape {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  overflow: visible;
}

.process-flow-label {
  position: relative;
  z-index: 1;
  padding: 0 0.8rem;
  color: var(--text-color);
  font-size: 1.55rem;
  font-weight: 800;
  line-height: 1;
  text-align: center;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.28);
  white-space: nowrap;
}

.process-flow-appear-enter-from {
  opacity: 0;
  transform: translateY(60px) scale(0.96);
}

.process-flow-appear-enter-active {
  transition: all 0.9s cubic-bezier(0.25, 1, 0.5, 1);
}
</style>
