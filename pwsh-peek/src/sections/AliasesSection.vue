<template>
  <section id="aliases" class="py-20 px-4">
    <div class="max-w-7xl mx-auto">
      <div class="text-center mb-12">
        <h2 class="text-4xl md:text-5xl font-bold mb-4 bg-gradient-to-r from-emerald-400 to-purple-500 bg-clip-text text-transparent">Aliases</h2>
        <p class="text-gray-300">Short, memorable shorthands you can type fast</p>
      </div>
      <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <div v-for="(a, i) in aliases" :key="i" class="section-glow rounded-lg p-4 flex items-center justify-between">
          <code class="text-emerald-400 font-mono">{{ a.alias }}</code>
          <span class="text-gray-400">→</span>
          <code class="text-blue-300 font-mono">{{ a.command }}</code>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const props = defineProps<{ aliases: Array<{ alias: string; command: string }> }>()
</script>
