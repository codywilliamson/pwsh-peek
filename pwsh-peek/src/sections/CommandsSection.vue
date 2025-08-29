<template>
  <section class="py-20 px-4">
    <div class="max-w-7xl mx-auto">
      <div class="text-center mb-16">
        <h2 class="text-4xl md:text-5xl font-bold mb-6 bg-gradient-to-r from-purple-400 to-emerald-500 bg-clip-text text-transparent">
          All Commands
        </h2>
      </div>

      <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div v-for="(cmd, index) in commands" :key="index"
             class="section-glow rounded-lg p-4 hover:bg-emerald-500/5 transition-all duration-300">
          <div class="flex items-center justify-between mb-2">
            <code class="text-emerald-400 font-mono text-sm">{{ cmd.name }}</code>
            <span class="text-xs text-gray-500">{{ cmd.alias || '—' }}</span>
          </div>
          <p class="text-gray-300 text-sm mb-3">{{ cmd.description }}</p>
          <div v-if="cmd.options?.length" class="mb-2 flex flex-wrap gap-1">
            <span v-for="opt in cmd.options" :key="opt" class="inline-block px-2 py-0.5 text-[10px] rounded bg-slate-900/50 border border-emerald-500/20 text-emerald-300 font-mono">{{ opt }}</span>
          </div>
          <div v-if="cmd.example" class="bg-slate-900/50 rounded p-2">
            <code class="text-[12px] text-blue-300 font-mono">{{ cmd.example }}</code>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const props = defineProps<{ 
  commands: Array<{ name: string; alias?: string; description: string; options?: string[]; example?: string }>
}>()
</script>
