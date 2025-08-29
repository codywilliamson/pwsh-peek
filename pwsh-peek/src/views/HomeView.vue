<template>
  <DefaultLayout>
    <HeroSection :terminal-sessions="terminalSessions" @copy-install="copyInstallCommand" />
    <FeaturesSection :features="features" />
    <ExamplesSection :flags="flags" />
    <CommandsSection :commands="commands" />
    <AliasesSection :aliases="aliases" />
    <InstallSection />

    <Transition name="toast">
      <div v-if="showToast" 
           class="fixed bottom-4 right-4 bg-emerald-600 text-white px-6 py-3 rounded-lg shadow-lg glow-emerald z-50">
        {{ toastMessage }}
      </div>
    </Transition>
  </DefaultLayout>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import DefaultLayout from '@/layouts/DefaultLayout.vue'
import HeroSection from '@/sections/HeroSection.vue'
import FeaturesSection from '@/sections/FeaturesSection.vue'
import ExamplesSection from '@/sections/ExamplesSection.vue'
import CommandsSection from '@/sections/CommandsSection.vue'
import AliasesSection from '@/sections/AliasesSection.vue'
import InstallSection from '@/sections/InstallSection.vue'

const showToast = ref(false)
const toastMessage = ref('')

const features = [
  {
    icon: '🚀',
    title: 'Blazing Fast',
    description: 'Optimized PowerShell cmdlets that respond instantly, even in large directories.'
  },
  {
    icon: '📊',
    title: 'Human Readable',
    description: 'File sizes in KB/MB/GB and relative timestamps like "5m ago" or "2d ago".'
  },
  {
    icon: '🎯',
    title: 'Smart Filtering',
    description: 'Built-in filters for files, directories, hidden items, and custom sorting.'
  },
  {
    icon: '⚡',
    title: 'Intuitive Aliases',
    description: 'Short, memorable commands like "peek-all", "peek-files", or just "pka".'
  },
  {
    icon: '🌈',
    title: 'Rich Display',
    description: 'Colorized output with file type icons and clean, organized formatting.'
  },
  {
    icon: '🔧',
    title: 'Zero Config',
    description: 'Works out of the box with sensible defaults. No complex setup required.'
  }
]

const commands = [
  { 
    name: 'peek', alias: '', 
    description: 'Basic directory listing with icons and human sizes',
    options: ['-All', '-DirsFirst', '-Long', '-SortNewest', '-SortSize', '-Recurse', '-Depth'],
    example: 'peek -All -DirsFirst'
  },
  { 
    name: 'peek-all', alias: 'pka', 
    description: 'Show all files including hidden ones',
    options: ['-DirsFirst', '-Long', '-SortNewest', '-SortSize'],
    example: 'pka -SortNewest'
  },
  { 
    name: 'peek-all-recurse', alias: 'pkar', 
    description: 'Recursively show all files with depth control',
    options: ['-Depth', '-DirsFirst', '-Long'],
    example: 'pkar -Depth 2'
  },
  { 
    name: 'peek-files', alias: 'pkf', 
    description: 'Show only files with sorting options',
    options: ['-All', '-SortSize', '-SortNewest', '-Long'],
    example: 'pkf -SortSize'
  },
  { 
    name: 'peek-dirs', alias: 'pkd', 
    description: 'Show only directories',
    options: ['-All', '-SortNewest', '-Long'],
    example: 'pkd -All'
  },
  { 
    name: 'peek-all-size', alias: 'pkas', 
    description: 'Show all files sorted by size (largest first)',
    options: ['-DirsFirst', '-Long'],
    example: 'pkas -DirsFirst'
  },
  { 
    name: 'peek-all-newest', alias: 'pkan', 
    description: 'Show all files sorted by modification time',
    options: ['-DirsFirst', '-Long'],
    example: 'pkan -DirsFirst'
  }
]

const aliases = [
  { alias: 'peek', command: 'Get-DirectoryView' },
  { alias: 'pka', command: 'peek-all' },
  { alias: 'pkar', command: 'peek-all-recurse' },
  { alias: 'pkf', command: 'peek-files' },
  { alias: 'pkd', command: 'peek-dirs' },
  { alias: 'pkas', command: 'peek-all-size' },
  { alias: 'pkan', command: 'peek-all-newest' },
]

// Terminal sessions built from user's captured output
const terminalSessions = [
  {
    command: 'peek',
    output: [
      'Icon Name       Type Size   Modified',
      '---- ----       ---- ----   --------',
      '📄   App.vue    File 1.9 MB 9m ago',
      '📁   assets     Dir  -      34m ago',
      '📁   components Dir  -      34m ago',
      '📄   main.ts    File 242 B  2w ago',
      '📁   router     Dir  -      34m ago',
      '📁   stores     Dir  -      34m ago',
      '📁   views      Dir  -      8m ago',
    ],
  },
  {
    command: 'peek-files',
    output: [
      'Icon Name    Type Size   Modified',
      '---- ----    ---- ----   --------',
      '📄   App.vue File 1.9 MB 9m ago',
      '📄   main.ts File 242 B  2w ago',
    ],
  },
  {
    command: 'peek-dirs',
    output: [
      'Icon Name       Type Size Modified',
      '---- ----       ---- ---- --------',
      '📁   assets     Dir  -    34m ago',
      '📁   components Dir  -    34m ago',
      '📁   router     Dir  -    34m ago',
      '📁   stores     Dir  -    34m ago',
      '📁   views      Dir  -    8m ago',
    ],
  },
  {
    command: 'peek-all-newest',
    output: [
      'Icon Name       Type Size   Modified',
      '---- ----       ---- ----   --------',
      '📁   views      Dir  -      8m ago',
      '📄   App.vue    File 1.9 MB 9m ago',
      '📁   stores     Dir  -      34m ago',
      '📁   router     Dir  -      34m ago',
      '📁   components Dir  -      34m ago',
      '📁   assets     Dir  -      34m ago',
      '📄   main.ts    File 242 B  2w ago',
    ],
  },
  {
    command: 'peek-all-size',
    output: [
      'Icon Name       Type Size   Modified',
      '---- ----       ---- ----   --------',
      '📄   App.vue    File 1.9 MB 9m ago',
      '📄   main.ts    File 242 B  2w ago',
      '📁   assets     Dir  -      34m ago',
      '📁   components Dir  -      34m ago',
      '📁   router     Dir  -      34m ago',
      '📁   stores     Dir  -      34m ago',
      '📁   views      Dir  -      8m ago',
    ],
  },
]

const flags = [
  { name: '-All', desc: 'Include hidden and system items' },
  { name: '-Recurse', desc: 'Recurse into subdirectories' },
  { name: '-Depth', desc: 'Limit recursion depth when using -Recurse' },
  { name: '-DirsFirst', desc: 'List directories before files' },
  { name: '-SortNewest', desc: 'Sort by LastWriteTime (newest first)' },
  { name: '-SortSize', desc: 'Sort by size (largest first)' },
  { name: '-Long', desc: 'Show extended columns (Mode, FullName)' },
]

const copyInstallCommand = async () => {
  try {
    await navigator.clipboard.writeText('iex (irm peek.pwsh.dev/install.ps1)')
    toastMessage.value = 'Install command copied to clipboard!'
    showToast.value = true
    setTimeout(() => {
      showToast.value = false
    }, 3000)
  } catch (err) {
    toastMessage.value = 'Please copy manually: iex (irm peek.pwsh.dev/install.ps1)'
    showToast.value = true
    setTimeout(() => {
      showToast.value = false
    }, 5000)
  }
}
</script>

<style scoped>
.toast-enter-active, .toast-leave-active {
  transition: all 0.3s ease;
}
.toast-enter-from, .toast-leave-to {
  opacity: 0;
  transform: translateX(100%);
}

/* Subtle animated background auras for hero */
.radial-aura {
  background: radial-gradient(closest-side, rgba(59,130,246,0.35), rgba(16,185,129,0.28), rgba(168,85,247,0.24), transparent 70%);
}
.radial-aura-emerald {
  background: radial-gradient(closest-side, rgba(16,185,129,0.45), rgba(34,197,94,0.3), transparent 70%);
}
.conic-aura {
  background: conic-gradient(from 0deg, rgba(168,85,247,0.35), rgba(59,130,246,0.25), rgba(16,185,129,0.25), rgba(168,85,247,0.35));
}

@keyframes breathe {
  0%, 100% { transform: scale(0.98); opacity: 0.55; }
  50% { transform: scale(1.03); opacity: 0.8; }
}
@keyframes breathe-slow {
  0%, 100% { transform: scale(0.96); opacity: 0.5; }
  50% { transform: scale(1.05); opacity: 0.75; }
}
@keyframes aura-fade {
  0%, 100% { opacity: 0.06; }
  50% { opacity: 0.1; }
}

.aura-breathe { animation: breathe 6s ease-in-out infinite; }
.aura-breathe-slow { animation: breathe-slow 10s ease-in-out infinite; }
.aura-fade-slow { animation: aura-fade 12s ease-in-out infinite; }
</style>
