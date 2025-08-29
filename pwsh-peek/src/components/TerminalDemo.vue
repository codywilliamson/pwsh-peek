<template>
  <div class="relative w-full overflow-hidden">
    <!-- enhanced glow aura with multiple layers -->
    <div class="pointer-events-none absolute -inset-6 rounded-3xl bg-gradient-to-r from-emerald-400/30 via-cyan-400/20 to-purple-500/25 blur-3xl animate-pulse"></div>
    <div class="pointer-events-none absolute -inset-4 rounded-2xl bg-gradient-to-br from-emerald-500/15 via-blue-400/10 to-purple-600/15 blur-xl"></div>
    
  <div class="section-glow rounded-2xl p-0 overflow-hidden dracula-terminal relative z-10 w-full max-w-[1040px] mx-auto shadow-2xl border border-dracula-current/30">
      <!-- enhanced window chrome with glassmorphism -->
  <div class="flex items-center justify-between px-4 py-3 dracula-chrome dracula-border backdrop-blur-md bg-gradient-to-r from-dracula-bg/90 to-dracula-current/60 rounded-t-2xl">
        <div class="flex items-center space-x-3">
          <div class="flex items-center space-x-2">
            <span class="w-3 h-3 bg-gradient-to-br from-red-400 to-red-600 rounded-full shadow-lg hover:scale-110 transition-transform cursor-pointer"></span>
            <span class="w-3 h-3 bg-gradient-to-br from-yellow-400 to-orange-500 rounded-full shadow-lg hover:scale-110 transition-transform cursor-pointer"></span>
            <span class="w-3 h-3 bg-gradient-to-br from-green-400 to-emerald-600 rounded-full shadow-lg hover:scale-110 transition-transform cursor-pointer"></span>
          </div>
          <div class="h-4 w-px bg-dracula-comment/40"></div>
          <span class="text-sm text-dracula-comment font-medium hidden sm:inline tracking-wide">pwsh — peek demo</span>
        </div>
        <div class="text-xs text-dracula-comment/80 bg-dracula-current/20 px-2 py-1 rounded-md hover:bg-dracula-current/30 transition-colors cursor-pointer">
          press any key ▶
        </div>
      </div>

      <!-- enhanced terminal body with better styling -->
  <div class="dracula-body p-0 font-mono text-[12px] sm:text-sm md:text-base leading-relaxed relative overflow-hidden rounded-b-2xl">
        <!-- subtle texture overlay -->
        <div class="absolute inset-0 opacity-[0.03] bg-gradient-to-br from-transparent via-white/5 to-transparent"></div>
        
        <div class="h-56 sm:h-64 overflow-y-auto px-5 py-4 custom-scrollbars relative z-10">
          <pre class="whitespace-pre-wrap break-words text-dracula-foreground selection:bg-dracula-purple/30 selection:text-dracula-fg" aria-live="polite">{{ renderedWithCursor }}</pre>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, onBeforeUnmount, ref, computed } from 'vue'

type Session = {
  prompt?: string
  command: string
  output: string[]
}

const props = defineProps<{
  sessions: Session[]
  typingSpeedMs?: number
  lineDelayMs?: number
  pauseBetweenSessionsMs?: number
}>()

const typingSpeed = props.typingSpeedMs ?? 40
const lineDelay = props.lineDelayMs ?? 450
const pauseBetween = props.pauseBetweenSessionsMs ?? 2200

const rendered = ref('')
let running = true
let timers: number[] = []
const cursorOn = ref(true)
const cursorChar = '▋'
let cursorTimer: number | null = null

const clearTimers = () => {
  timers.forEach(t => clearTimeout(t))
  timers = []
}

const sleep = (ms: number) => new Promise<void>(res => {
  const id = window.setTimeout(() => res(), ms)
  timers.push(id)
})

async function typeText(text: string) {
  for (let i = 0; i < text.length && running; i++) {
    rendered.value += text[i]
    await sleep(typingSpeed)
  }
}

async function run() {
  // Loop forever
  while (running) {
    for (const s of props.sessions) {
      if (!running) break
      // clear between sessions
      rendered.value = ''
  const prompt = s.prompt ?? 'pwsh src> '
      rendered.value += prompt
      await typeText(s.command + '\n\n')
      // Output lines
      for (const line of s.output) {
        if (!running) break
        rendered.value += line + '\n'
        await sleep(lineDelay)
      }
      rendered.value += '\n'
      await sleep(pauseBetween)
    }
    // loop will continue and clear on next session start
  }
}

function restartOnKey() {
  // Allow user to restart animation by pressing any key/tap
  rendered.value = ''
  clearTimers()
}

onMounted(() => {
  window.addEventListener('keydown', restartOnKey)
  window.addEventListener('pointerdown', restartOnKey)
  run()
  cursorTimer = window.setInterval(() => {
    cursorOn.value = !cursorOn.value
  }, 500)
})

onBeforeUnmount(() => {
  running = false
  clearTimers()
  window.removeEventListener('keydown', restartOnKey)
  window.removeEventListener('pointerdown', restartOnKey)
  if (cursorTimer) {
    clearInterval(cursorTimer)
    cursorTimer = null
  }
})

const renderedWithCursor = computed(() => rendered.value + (cursorOn.value ? cursorChar : ' '))
</script>

<style scoped>
/* Enhanced Dracula palette with gradients */
:root, .dracula-terminal {
  --dracula-bg: #282a36;
  --dracula-current: #44475a;
  --dracula-fg: #f8f8f2;
  --dracula-comment: #6272a4;
  --dracula-cyan: #8be9fd;
  --dracula-green: #50fa7b;
  --dracula-orange: #ffb86c;
  --dracula-pink: #ff79c6;
  --dracula-purple: #bd93f9;
  --dracula-red: #ff5555;
  --dracula-yellow: #f1fa8c;
}

.dracula-chrome { 
  background: linear-gradient(135deg, rgba(40, 42, 54, 0.95) 0%, rgba(68, 71, 90, 0.8) 100%);
  border-bottom: 1px solid rgba(80, 250, 123, 0.2);
}

.dracula-body { 
  background: radial-gradient(1200px 600px at 30% -10%, rgba(189,147,249,0.12), transparent 50%),
              radial-gradient(800px 400px at 70% 110%, rgba(139,233,253,0.08), transparent 50%), 
              linear-gradient(135deg, var(--dracula-bg) 0%, #1a1b23 100%);
}

.dracula-border { border-color: rgba(80, 250, 123, 0.25); }
.text-dracula-comment { color: var(--dracula-comment); }
.text-dracula-foreground { color: var(--dracula-fg); }

pre { 
  tab-size: 2; 
  text-shadow: 0 0 10px rgba(248, 248, 242, 0.1);
}

/* Enhanced scrollbars with hover effects */
.custom-scrollbars::-webkit-scrollbar { 
  width: 12px; 
  height: 12px; 
}

.custom-scrollbars::-webkit-scrollbar-thumb { 
  background: linear-gradient(135deg, var(--dracula-current) 0%, rgba(98, 114, 164, 0.8) 100%);
  border-radius: 10px; 
  border: 2px solid transparent;
  background-clip: content-box;
  transition: all 0.2s ease;
}

.custom-scrollbars::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(135deg, rgba(98, 114, 164, 0.9) 0%, rgba(189, 147, 249, 0.6) 100%);
  transform: scale(1.1);
}

.custom-scrollbars::-webkit-scrollbar-track { 
  background: rgba(40, 42, 54, 0.3); 
  border-radius: 10px; 
  margin: 4px;
}

.custom-scrollbars { 
  scrollbar-color: var(--dracula-current) rgba(40, 42, 54, 0.3); 
  scrollbar-width: thin; 
}
</style>
