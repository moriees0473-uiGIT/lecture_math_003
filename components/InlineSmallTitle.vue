<script setup lang="ts">
const props = withDefaults(
  defineProps<{
    title: string
    suffix?: string
    suffixScale?: number
  }>(),
  {
    suffix: '',
    suffixScale: 0.62
  }
)
</script>

<template>
  <h2 class="inline-title" :style="{ fontSize: 'var(--app-font-size-title, 2.0rem)' }">
    <span class="main">{{ props.title }}</span>
    <span v-if="props.suffix" class="suffix" :style="{ fontSize: `${props.suffixScale}em` }">
      {{ props.suffix }}
    </span>
  </h2>
</template>

<style scoped>
.inline-title {
  margin: 0;
  line-height: 1.1;
  letter-spacing: 0.02em;
  transform: translateY(-1em);
}

.main {
  font-weight: 800;
}

.suffix {
  margin-left: 0.35em;
  font-weight: 700;
  opacity: 0.9;
  vertical-align: baseline;
}
</style>
