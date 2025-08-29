<script setup lang="ts">
import { RouterView } from 'vue-router'
import DefaultLayout from '@/layouts/DefaultLayout.vue'
</script>

<template>
  <div id="app" class="min-h-screen bg-slate-950 text-white gradient-animated">
    <!-- Keep layout here in case future routes want their own; HomeView already uses DefaultLayout internally. -->
    <RouterView />
  </div>
 </template>

<style>
html {
  scroll-behavior: smooth;
}

/* Custom glowing animations */
@keyframes glow-pulse {
  0%, 100% { 
    box-shadow: 0 0 20px rgba(16, 185, 129, 0.3), 0 0 40px rgba(16, 185, 129, 0.1), 0 0 60px rgba(59, 130, 246, 0.05);
  }
  50% { 
    box-shadow: 0 0 30px rgba(16, 185, 129, 0.5), 0 0 60px rgba(16, 185, 129, 0.2), 0 0 80px rgba(59, 130, 246, 0.1);
  }
}

@keyframes glow-pulse-purple {
  0%, 100% { 
    box-shadow: 0 0 20px rgba(147, 51, 234, 0.3), 0 0 40px rgba(147, 51, 234, 0.1);
  }
  50% { 
    box-shadow: 0 0 30px rgba(147, 51, 234, 0.5), 0 0 60px rgba(147, 51, 234, 0.2);
  }
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-10px); }
}

@keyframes gradient-shift {
  0%, 100% { 
    background-position: 0% 50%;
  }
  50% { 
    background-position: 100% 50%;
  }
}

@keyframes sparkle {
  0%, 100% { opacity: 0.3; transform: scale(0.8); }
  50% { opacity: 0.8; transform: scale(1.2); }
}

.glow-emerald {
  animation: glow-pulse 3s ease-in-out infinite;
}

.glow-purple {
  animation: glow-pulse-purple 4s ease-in-out infinite;
}

.float-animation {
  animation: float 6s ease-in-out infinite;
}

.sparkle-animation {
  animation: sparkle 2s ease-in-out infinite;
}

.gradient-animated {
  background: linear-gradient(-45deg, #0f172a, #1e293b, #0f172a, #1e1b4b, #0f172a);
  background-size: 400% 400%;
  animation: gradient-shift 20s ease infinite;
}

.blur-glow {
  filter: blur(0.5px);
  box-shadow: 
    0 0 20px rgba(16, 185, 129, 0.4),
    0 0 40px rgba(16, 185, 129, 0.2),
    0 0 60px rgba(59, 130, 246, 0.1),
    0 0 80px rgba(147, 51, 234, 0.1);
}

.section-glow {
  background: rgba(16, 185, 129, 0.03);
  border: 1px solid rgba(16, 185, 129, 0.1);
  backdrop-filter: blur(10px);
}
</style>
