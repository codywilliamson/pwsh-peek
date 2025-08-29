<template>
  <section class="py-16 px-4 sm:py-20">
    <div class="max-w-7xl mx-auto">
      <div class="text-center mb-10 sm:mb-16">
        <h2 class="text-2xl sm:text-4xl md:text-5xl font-bold mb-3 sm:mb-6 bg-gradient-to-r from-blue-400 to-purple-500 bg-clip-text text-transparent">
          Simple & Powerful
        </h2>
        <p class="text-base sm:text-xl text-gray-300">
          Intuitive commands that just work
        </p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 sm:gap-8">
        <div class="space-y-6">
          <div class="section-glow rounded-xl p-4 sm:p-6 overflow-hidden">
            <h3 class="text-base sm:text-lg font-semibold mb-3 sm:mb-4 text-red-400">❌ The old way</h3>
            <pre class="w-full max-w-full text-xs sm:text-sm leading-5 sm:leading-6 text-gray-300 bg-slate-900/50 rounded-lg p-3 sm:p-4 overflow-x-auto"><code>PS> Get-ChildItem -Force | Sort-Object PSIsContainer,Name
PS> Get-ChildItem -File | Sort-Object Length -Descending
PS> Get-ChildItem -Directory -Recurse -Depth 2</code></pre>
          </div>

          <div class="section-glow rounded-xl p-4 sm:p-6 sm:glow-emerald overflow-hidden">
            <h3 class="text-base sm:text-lg font-semibold mb-3 sm:mb-4 text-emerald-400">✅ The peek way</h3>
            <pre class="w-full max-w-full text-xs sm:text-sm leading-5 sm:leading-6 text-emerald-300 bg-slate-900/50 rounded-lg p-3 sm:p-4 overflow-x-auto"><code>PS> peek-all
PS> peek-files -SortSize  
PS> peek-dirs -Recurse -Depth 2</code></pre>
          </div>
        </div>

        <div class="section-glow rounded-xl p-4 sm:p-6">
          <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-1 sm:gap-2 mb-4">
            <h3 class="text-base sm:text-lg font-semibold text-emerald-400">Flags & Sorting</h3>
            <span class="text-xs text-gray-400">works across peek commands</span>
          </div>
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <div v-for="flag in flags" :key="flag.name" class="rounded-lg border border-emerald-500/20 bg-slate-900/40 p-3">
              <div class="mb-1">
                <span class="inline-block px-2 py-0.5 text-[10px] sm:text-xs rounded-full bg-emerald-500/10 border border-emerald-500/30 text-emerald-300 font-mono">{{ flag.name }}</span>
              </div>
              <p class="text-xs sm:text-sm text-gray-300">{{ flag.desc }}</p>
            </div>
          </div>
          <div class="mt-4 text-[11px] sm:text-xs text-gray-400">
            Tip: combine flags, e.g. <code class="text-emerald-300 font-mono">pkf -SortSize -All</code>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const props = defineProps<{ flags: Array<{ name: string; desc: string }> }>()
</script>
