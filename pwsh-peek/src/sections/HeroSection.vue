<template>
  <section class="relative pt-32 pb-20 px-4">
    <div class="max-w-7xl mx-auto">
      <div class="absolute inset-0 overflow-hidden pointer-events-none">
        <div class="absolute top-1/4 left-1/4 w-32 h-32 bg-emerald-400/20 rounded-full blur-3xl float-animation"></div>
        <div class="absolute top-1/3 right-1/4 w-24 h-24 bg-blue-400/20 rounded-full blur-3xl float-animation" style="animation-delay: -2s;"></div>
        <div class="absolute bottom-1/4 left-1/3 w-28 h-28 bg-purple-500/20 rounded-full blur-3xl float-animation" style="animation-delay: -4s;"></div>
        <div class="radial-aura absolute -right-40 md:right-0 top-0 w-[760px] md:w-[1000px] h-[760px] md:h-[1000px] blur-[140px] opacity-90 mix-blend-screen aura-breathe-slow"></div>
        <div class="radial-aura-emerald absolute -left-24 top-28 w-[520px] h-[520px] blur-[120px] opacity-80 mix-blend-screen aura-breathe"></div>
        <div class="conic-aura absolute left-1/2 -translate-x-1/2 top-1/2 -translate-y-1/2 w-[1400px] h-[1400px] opacity-[0.12] blur-[180px] aura-fade-slow"></div>
      </div>

      <div class="relative z-10">
        <div class="grid lg:grid-cols-[1fr_2fr] gap-12 xl:gap-16 items-center">
          <div class="text-center lg:text-left">
            <div class="text-7xl md:text-8xl mb-6">👀</div>
            <h1 class="text-5xl md:text-7xl font-bold mb-4 bg-gradient-to-r from-emerald-400 via-blue-500 to-purple-600 bg-clip-text text-transparent">peek</h1>
            <p class="text-lg md:text-2xl text-gray-300 mb-6 leading-relaxed max-w-2xl">
              A modern, blazing-fast PowerShell directory listing with 
              <span class="text-emerald-400 font-semibold">human-readable sizes</span>, 
              <span class="text-blue-400 font-semibold">relative timestamps</span>, and 
              <span class="text-purple-400 font-semibold">intuitive aliases</span>
            </p>
            <div class="flex flex-col sm:flex-row gap-4 lg:justify-start justify-center items-center mb-6">
              <button @click="$emit('copy-install')" class="px-7 py-3 bg-emerald-600 hover:bg-emerald-500 rounded-lg font-semibold text-lg transition-all duration-300 glow-emerald hover:scale-105">Quick Install</button>
              <a href="#features" class="px-7 py-3 border-2 border-emerald-500/50 hover:border-emerald-500 rounded-lg font-semibold text-lg transition-all duration-300 hover:bg-emerald-500/10">Learn More</a>
            </div>
            <div class="section-glow rounded-xl p-4 max-w-xl lg:max-w-2xl overflow-x-auto">
              <div class="flex items-center justify-between mb-2">
                <div class="flex items-center space-x-2">
                  <div class="w-3 h-3 bg-red-500 rounded-full"></div>
                  <div class="w-3 h-3 bg-yellow-500 rounded-full"></div>
                  <div class="w-3 h-3 bg-green-500 rounded-full"></div>
                  <span class="text-gray-400 text-sm ml-3">PowerShell</span>
                </div>
                <button @click="$emit('copy-install')" class="text-emerald-400 hover:text-emerald-300 transition-colors">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                  </svg>
                </button>
              </div>
              <code class="text-emerald-400 font-mono text-xs sm:text-sm md:text-base whitespace-pre">iex (irm peek.codywilliamson.com/install.ps1)</code>
            </div>
          </div>

          <div class="w-full mx-auto lg:mx-0 flex justify-center items-center">
            <TerminalDemo :sessions="terminalSessions" :typing-speed-ms="8" :line-delay-ms="40" :pause-between-sessions-ms="1200" />
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import TerminalDemo from '@/components/TerminalDemo.vue'

const props = defineProps<{ terminalSessions: Array<{ command: string; output: string[] }> }>()
</script>
