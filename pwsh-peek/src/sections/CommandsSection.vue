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
          <div class="flex items-center justify-between mb-2 gap-2">
            <code class="text-emerald-400 font-mono text-sm">{{ cmd.name }}</code>
            <span class="text-xs text-gray-500">{{ cmd.alias || '—' }}</span>
          </div>
          <p class="text-gray-300 text-sm mb-3">{{ cmd.description }}</p>
          <div v-if="cmd.options?.length" class="mb-2 flex flex-wrap gap-1">
            <span v-for="opt in cmd.options" :key="opt" class="inline-block px-1.5 sm:px-2 py-0.5 text-[9px] sm:text-[10px] rounded bg-slate-900/50 border border-emerald-500/20 text-emerald-300 font-mono">{{ opt }}</span>
          </div>
          <div v-if="cmd.example" class="relative bg-slate-900/50 rounded p-2 overflow-x-auto">
            <button
              class="absolute top-2 right-2 text-[11px] sm:text-xs inline-flex items-center gap-1 px-2 py-0.5 rounded border border-emerald-500/30 text-emerald-300 bg-slate-900/60 hover:bg-slate-900/80 transition"
              :aria-label="`Copy example for ${cmd.name}`"
              :title="`Copy example for ${cmd.name}`"
              @click="copyExample(cmd.example!, index)"
            >
              <span v-if="!copiedExample[index]">📋</span>
              <span v-else>✅</span>
              <span class="font-mono">Copy</span>
            </button>
            <code class="block pr-16 text-[11px] sm:text-[12px] text-blue-300 font-mono whitespace-pre">{{ cmd.example }}</code>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const props = defineProps<{ 
  commands: Array<{ name: string; alias?: string; description: string; options?: string[]; example?: string }>
}>()

// Track copied state for example snippets
const copiedExample = ref<Record<number, boolean>>({})

async function copyExample(example: string, index: number) {
  if (!example) return
  try {
    await navigator.clipboard.writeText(example)
    copiedExample.value[index] = true
    setTimeout(() => { copiedExample.value[index] = false }, 1500)
  } catch {
    // silent fallback
  }
}
</script>
