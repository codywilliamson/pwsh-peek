<template>
  <section class="py-20 px-4">
    <div class="max-w-7xl mx-auto">
      <div class="text-center mb-10 sm:mb-14">
        <h2 class="text-2xl sm:text-4xl md:text-5xl font-bold mb-3 sm:mb-6 bg-gradient-to-r from-emerald-400 to-blue-500 bg-clip-text text-transparent">
          Tips & Shortcuts
        </h2>
        <p class="text-base sm:text-lg text-gray-300">Make the most of peek with these quick pointers</p>
      </div>

      <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-sm font-semibold text-emerald-400 mb-2">Emoji/icons not showing?</h3>
          <p class="text-sm text-gray-300">Use PowerShell 7+ in Windows Terminal and a font with color emoji (e.g., Segoe UI Emoji). Optional: install <code class="font-mono text-emerald-300">Terminal-Icons</code> for ls/dir; peek already includes basic icons. Fallbacks: add <code class="font-mono text-emerald-300">-NoIcons</code> (alias <code class="font-mono text-emerald-300">-Ascii</code>) or set it globally with <code class="font-mono text-emerald-300">Set-NoIconsForPeek</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-sm font-semibold text-emerald-400 mb-2">Aliases included</h3>
          <p class="text-sm text-gray-300">Aliases like <code class="font-mono text-emerald-300">pka</code> or <code class="font-mono text-emerald-300">pkf</code> are shown alongside each command in the list.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-sm font-semibold text-emerald-400 mb-2">Combine flags</h3>
          <p class="text-sm text-gray-300">Use flags together, e.g. <code class="font-mono text-emerald-300">pkf -SortSize -All</code> or <code class="font-mono text-emerald-300">pkar -Depth 2</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-sm font-semibold text-emerald-400 mb-2">Readable output</h3>
          <p class="text-sm text-gray-300">Sizes are human-friendly and timestamps are relative by default.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-sm font-semibold text-emerald-400 mb-2">Directories first</h3>
          <p class="text-sm text-gray-300">Prefer folders on top? Add <code class="font-mono text-emerald-300">-DirsFirst</code> to any command.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-sm font-semibold text-emerald-400 mb-2">Go deeper</h3>
          <p class="text-sm text-gray-300">Recursively list with <code class="font-mono text-emerald-300">-Recurse</code> and control depth via <code class="font-mono text-emerald-300">-Depth</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-sm font-semibold text-emerald-400 mb-2">Copy examples</h3>
          <p class="text-sm text-gray-300">Each command includes a ready-to-run example you can copy.</p>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
// No props needed; this is a static tips section to replace Aliases.
</script>

<style scoped>
</style>
