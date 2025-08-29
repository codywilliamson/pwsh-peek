<template>
  <section id="install" class="py-20 px-4">
    <div class="max-w-4xl mx-auto text-center">
      <h2 class="text-3xl sm:text-4xl md:text-5xl font-bold mb-4 sm:mb-6 bg-gradient-to-r from-emerald-400 to-blue-500 bg-clip-text text-transparent">
        Get Started
      </h2>
      <p class="text-base sm:text-xl text-gray-300 mb-8 sm:mb-12">
        One command. Zero configuration. Instant productivity.
      </p>

      <div class="space-y-8">
        <div class="section-glow rounded-xl p-6 sm:p-8 glow-emerald">
          <h3 class="text-xl sm:text-2xl font-semibold mb-3 sm:mb-4 text-emerald-400">⚡ Quick Install</h3>
          <div class="bg-slate-900/50 rounded-lg p-3 sm:p-4 mb-4 overflow-x-auto">
            <code class="text-emerald-400 font-mono text-xs sm:text-lg whitespace-pre">iex (irm peek.codywilliamson.com/install.ps1)</code>
          </div>
          <p class="text-gray-300">Installs to your PowerShell modules directory and imports automatically</p>
        </div>

        <div class="section-glow rounded-xl p-6 sm:p-8">
          <h3 class="text-xl sm:text-2xl font-semibold mb-3 sm:mb-4 text-blue-400">🔧 Custom Install</h3>
          <div class="bg-slate-900/50 rounded-lg p-3 sm:p-4 mb-4 overflow-x-auto">
            <code class="text-blue-400 font-mono text-[11px] sm:text-sm whitespace-pre">iex (irm peek.codywilliamson.com/install.ps1) -InstallPath "C:\MyModules" -AddToProfile</code>
          </div>
          <p class="text-gray-300">Install to a custom location and automatically add to your PowerShell profile</p>
        </div>

        <div class="section-glow rounded-xl p-6 sm:p-8">
          <h3 class="text-xl sm:text-2xl font-semibold mb-3 sm:mb-4 text-purple-400">📦 Manual Install</h3>
          <div class="space-y-2 text-left">
            <p class="text-gray-300">1. Download the module files:</p>
            <div class="bg-slate-900/50 rounded-lg p-2 sm:p-3 mb-2 overflow-x-auto">
              <code class="text-purple-400 font-mono text-[11px] sm:text-sm whitespace-pre">git clone https://github.com/codywilliamson/pwsh-peek.git</code>
            </div>
            <p class="text-gray-300">2. Copy to PowerShell modules directory</p>
            <p class="text-gray-300">3. Import with <code class="text-purple-400">Import-Module DirectoryListing</code></p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
// presentational only
</script>
