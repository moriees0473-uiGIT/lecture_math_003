<script setup lang="ts">
defineProps<{
  number: string
  title: string
}>()
</script>

<template>
  <div class="relative isolate w-full max-w-[980px] mx-auto min-h-0 flex flex-col font-sans">
    <header class="relative z-30 mb-8 pt-4">
      <div class="flex items-center gap-4 text-4xl font-bold">
        <span class="bg-orange-200 text-orange-600 px-4 py-1 rounded-2xl shadow-sm">
          {{ number }}
        </span>
        <div class="min-w-0 flex-1">
          <slot name="title">
            <h1 class="!text-white">{{ title }}</h1>
          </slot>
        </div>
      </div>
      <p class="mt-4 text-2xl text-gray-300 leading-relaxed italic">
        <slot name="description"></slot>
      </p>
    </header>

    <div class="relative z-10 grid grid-cols-[1fr_1fr] gap-2 flex-1 min-h-0 mt-4">
      <div class="relative z-10 min-w-0 min-h-0 bg-white/60 border-4 border-dashed border-blue-100 rounded-3xl p-6 flex flex-col justify-center items-center shadow-inner overflow-hidden">
        <slot name="left"></slot>
      </div>

      <div class="relative z-20 min-w-0 min-h-0 bg-pink-50/50 rounded-3xl p-8 border-2 border-pink-100 overflow-hidden">
        <div class="space-y-6">
          <slot name="right"></slot>
        </div>
      </div>
    </div>
  </div>
</template>