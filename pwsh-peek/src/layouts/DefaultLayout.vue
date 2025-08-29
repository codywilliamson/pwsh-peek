<template>
  <div class="min-h-screen overflow-x-hidden">
    <!-- Navigation -->
    <nav class="fixed top-0 w-full z-50 bg-slate-950/80 backdrop-blur-md border-b border-emerald-500/20">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
          <div class="flex items-center space-x-3">
            <div class="text-3xl">👀</div>
            <span class="text-xl font-bold bg-gradient-to-r from-emerald-400 to-blue-500 bg-clip-text text-transparent">
              peek
            </span>
          </div>
          <div class="hidden md:flex space-x-8">
            <a href="#features" class="text-gray-300 hover:text-emerald-400 transition-colors duration-300">Features</a>
            <a href="#install" class="text-gray-300 hover:text-emerald-400 transition-colors duration-300">Install</a>
            <a href="https://github.com/codywilliamson/pwsh-peek" 
               class="text-gray-300 hover:text-emerald-400 transition-colors duration-300">GitHub</a>
          </div>
        </div>
      </div>
    </nav>

    <main>
      <slot />
    </main>

    <!-- Footer -->
    <footer class="py-12 px-4 border-t border-emerald-500/20">
      <div class="max-w-7xl mx-auto text-center">
        <div class="flex justify-center items-center space-x-3 mb-4">
          <div class="text-2xl">👀</div>
          <span class="text-lg font-bold text-emerald-400">peek</span>
        </div>
        <p class="text-gray-400 mb-4">
          Vibe coded with ❤️ just because I can
        </p>
        <div class="flex flex-wrap justify-center gap-3">
          <a href="https://github.com/codywilliamson/pwsh-peek" 
             class="inline-flex items-center gap-2 text-sm text-gray-300 hover:text-emerald-300 border border-emerald-500/30 hover:border-emerald-400/60 rounded-full px-3 py-1 transition-colors">
            <span>🐙</span>
            <span>GitHub</span>
          </a>
          <a href="https://peek.codywilliamson.com" 
             class="inline-flex items-center gap-2 text-sm text-gray-300 hover:text-emerald-300 border border-emerald-500/30 hover:border-emerald-400/60 rounded-full px-3 py-1 transition-colors">
            <span>🔗</span>
            <span>peek.codywilliamson.com</span>
          </a>
          <a href="https://codywilliamson.com" 
             class="inline-flex items-center gap-2 text-sm text-gray-300 hover:text-emerald-300 border border-emerald-500/30 hover:border-emerald-400/60 rounded-full px-3 py-1 transition-colors">
            <span>🌐</span>
            <span>codywilliamson.com</span>
          </a>
          <a href="https://spectaclesoftware.com" 
             class="inline-flex items-center gap-2 text-sm text-gray-300 hover:text-emerald-300 border border-emerald-500/30 hover:border-emerald-400/60 rounded-full px-3 py-1 transition-colors">
            <span>🕶️</span>
            <span>Spectacle Software</span>
          </a>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
// layout-only component
</script>

<style scoped>
/* No-op */
</style>
