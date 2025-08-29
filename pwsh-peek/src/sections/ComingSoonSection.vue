<template>
  <section class="py-20 px-4">
    <div class="max-w-7xl mx-auto">
      <div class="text-center mb-12">
          <h2 class="text-3xl sm:text-4xl md:text-5xl font-bold mb-4 bg-gradient-to-r from-emerald-400 to-blue-500 bg-clip-text text-transparent leading-snug tracking-wide">
          Coming soon
        </h2>
        <p class="text-gray-300">A peek at what’s next — focused on customization, scripting, and clarity</p>
      </div>

      <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-emerald-400 font-semibold mb-1">PowerShell Gallery</h3>
          <p class="text-sm text-gray-300">Publish and install via PSGallery: <code class="font-mono text-emerald-300">Install-Module DirectoryListing</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-emerald-400 font-semibold mb-1">Rich icon themes</h3>
          <p class="text-sm text-gray-300">More file-type icons and themes. Flags: <code class="font-mono text-emerald-300">-IconTheme minimal|rich</code>, <code class="font-mono text-emerald-300">-NoIcon</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-emerald-400 font-semibold mb-1">Layout customization</h3>
          <p class="text-sm text-gray-300">Choose columns and order (e.g., names on the right). Flags: <code class="font-mono text-emerald-300">-Columns</code>, <code class="font-mono text-emerald-300">-View</code>, <code class="font-mono text-emerald-300">-NamesRight</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-emerald-400 font-semibold mb-1">Time formats</h3>
          <p class="text-sm text-gray-300">Switch between relative and absolute times. Flags: <code class="font-mono text-emerald-300">-TimeStyle relative|iso|local</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-emerald-400 font-semibold mb-1">Directory sizes (opt‑in)</h3>
          <p class="text-sm text-gray-300">Compute folder sizes with depth control. Flags: <code class="font-mono text-emerald-300">-DirSize</code>, <code class="font-mono text-emerald-300">-DirSizeDepth</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-emerald-400 font-semibold mb-1">Raw object mode</h3>
          <p class="text-sm text-gray-300">Perfect for pipelines — no formatting. Flag: <code class="font-mono text-emerald-300">-AsObject</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-emerald-400 font-semibold mb-1">Powerful filters</h3>
          <p class="text-sm text-gray-300">Target by ext/name/links/time. Flags: <code class="font-mono text-emerald-300">-IncludeExt</code>, <code class="font-mono text-emerald-300">-ExcludeExt</code>, <code class="font-mono text-emerald-300">-Match</code>, <code class="font-mono text-emerald-300">-OnlyLinks</code>, <code class="font-mono text-emerald-300">-Since</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-emerald-400 font-semibold mb-1">More sorting</h3>
          <p class="text-sm text-gray-300">Sort by extension, type, or natural name. Flags: <code class="font-mono text-emerald-300">-SortExt</code>, <code class="font-mono text-emerald-300">-SortType</code>, <code class="font-mono text-emerald-300">-SortName</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-emerald-400 font-semibold mb-1">Color theming</h3>
          <p class="text-sm text-gray-300">Optional ANSI colors on PS 7+. Flags: <code class="font-mono text-emerald-300">-Color</code>, <code class="font-mono text-emerald-300">-NoColor</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-emerald-400 font-semibold mb-1">Git awareness</h3>
          <p class="text-sm text-gray-300">Show Git status for repo files. Flag: <code class="font-mono text-emerald-300">-GitStatus</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-emerald-400 font-semibold mb-1">Summary line</h3>
          <p class="text-sm text-gray-300">Totals for files/dirs and size. Flag: <code class="font-mono text-emerald-300">-Summary</code>.</p>
        </div>
        <div class="section-glow rounded-lg p-4">
          <h3 class="text-emerald-400 font-semibold mb-1">Minimal view</h3>
          <p class="text-sm text-gray-300">A bare name-only listing. Flag: <code class="font-mono text-emerald-300">-Bare</code>.</p>
        </div>
      </div>

      <div class="text-center mt-8">
        <a
          href="https://github.com/codywilliamson/pwsh-peek/issues/new"
          target="_blank"
          rel="noopener"
          class="inline-flex items-center gap-2 text-emerald-300 hover:text-emerald-200"
        >
          Have an idea? Open an issue ↗
        </a>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
// Static section; no props needed.
</script>

<style scoped>
</style>
