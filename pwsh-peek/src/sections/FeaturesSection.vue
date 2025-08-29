<template>
  <section id="features" class="py-20 px-4">
    <div class="max-w-7xl mx-auto">
      <div class="text-center mb-16">
        <h2 class="text-4xl md:text-5xl font-bold mb-6 bg-gradient-to-r from-emerald-400 to-blue-500 bg-clip-text text-transparent">
          Why peek?
        </h2>
        <p class="text-xl text-gray-300 max-w-3xl mx-auto">
          Transform your PowerShell experience with modern directory listing that actually makes sense
        </p>
      </div>

      <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
        <div v-for="(feature, index) in features" :key="index"
             class="section-glow rounded-xl p-6 transform hover:scale-105 transition-all duration-300"
             :style="{ animationDelay: index * 0.1 + 's' }">
          <div class="text-4xl mb-4 emoji">{{ feature.icon }}</div>
          <h3 class="text-xl font-semibold mb-3 text-emerald-400">{{ feature.title }}</h3>
          <p class="text-gray-300 leading-relaxed">{{ feature.description }}</p>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const props = defineProps<{ features: Array<{ icon: string; title: string; description: string }> }>()
</script>
