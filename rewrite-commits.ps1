# <#!
# Rewrite recent commit messages to cleaner Conventional Commit style.

# What it does
# - Creates a safety backup tag: backup/pre-reword-YYYYMMDD-HHmmss
# - Rewrites commit messages via git filter-branch using a mapping
# - Shows before/after log (last N commits)
# - Optionally pushes with --force-with-lease

# Usage
#   pwsh ./rewrite-commits.ps1            # rewrite + push (default)
#   pwsh ./rewrite-commits.ps1 -NoPush    # rewrite only, do not push

# Notes
# - Requires Git for Windows with bash available on PATH (installed with Git)
# - Rewrites all commits but only alters messages that match known subjects
# !>

[CmdletBinding()]
param(
    [int]$ShowCount = 12,
    [switch]$NoPush
)

$ErrorActionPreference = 'Stop'

function Exec([string]$cmd) {
    Write-Host "→ $cmd" -ForegroundColor DarkGray
    $out = & powershell -NoProfile -NonInteractive -Command $cmd 2>&1
    if ($LASTEXITCODE -ne 0) { throw "Command failed ($LASTEXITCODE): $cmd`n$out" }
    return $out
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'git is required on PATH'
}
if (-not (Get-Command bash -ErrorAction SilentlyContinue)) {
    throw 'bash is required (Git for Windows provides bash). Ensure it is on PATH.'
}

# Ensure clean working tree
git diff-index --quiet HEAD -- || throw 'Working tree is dirty. Commit or stash changes first.'

$branch = (git rev-parse --abbrev-ref HEAD).Trim()
Write-Host "Current branch: $branch" -ForegroundColor Cyan

Write-Host "Current log (last $ShowCount):" -ForegroundColor Yellow
git --no-pager log --oneline -n $ShowCount | Write-Host

# Create backup tag
$ts = Get-Date -Format 'yyyyMMdd-HHmmss'
$backupTag = "backup/pre-reword-$ts"
git tag $backupTag
Write-Host "Created backup tag: $backupTag" -ForegroundColor Green

# Prepare msg-filter script (bash)
$msgFilter = @'
#!/usr/bin/env bash
set -euo pipefail
orig="$(cat)"
first="$(printf "%s" "$orig" | head -n1)"
rest="$(printf "%s" "$orig" | tail -n +2 || true)"
case "$first" in
  "release tagging") echo "chore(ci): add automated release tagging workflow"; echo "$rest" ;;
  "installer cmd with params fix, pnpm workspace addition") echo "fix(installer): bind -InstallPath params; chore(pnpm): add workspace config"; echo "$rest" ;;
  "repo cleanup, install.ps1 updates, instructions") echo "chore(repo): cleanup; docs(installer): update instructions"; echo "$rest" ;;
  "install ps1 fix") echo "fix(installer): correct install.ps1 syntax/links"; echo "$rest" ;;
  "install update") echo "feat(installer): add Branch param & TLS hardening"; echo "$rest" ;;
  "net fix") echo "fix(netlify): set NODE_VERSION & installer redirect"; echo "$rest" ;;
  "netlify fixes, mobile fix") echo "fix(netlify): pnpm/node alignment; fix(ui): mobile responsiveness"; echo "$rest" ;;
  "more mobile fixes") echo "fix(ui): improve examples responsiveness & code overflow"; echo "$rest" ;;
  "mobile push") echo "feat(ui): initial mobile layout improvements"; echo "$rest" ;;
  "landing page") echo "feat(site): landing page structure & sections"; echo "$rest" ;;
  "peek init") echo "feat(module): initial DirectoryListing module"; echo "$rest" ;;
  "vue init") echo "chore(site): initialize Vue 3 + Vite + Tailwind"; echo "$rest" ;;
  "readme updates") echo "docs(readme): add CI + release badges and process"; echo "$rest" ;;
  *) printf "%s" "$orig" ;;
esac
'@

$tempDir = New-Item -ItemType Directory -Path (Join-Path $env:TEMP "rewrite-commits-$ts") -Force
$msgFilterPath = Join-Path $tempDir 'msgfilter.sh'
Set-Content -Path $msgFilterPath -Value $msgFilter -Encoding UTF8
& git update-index -q --refresh

Write-Host "Rewriting commit messages (this may take a moment)..." -ForegroundColor Yellow
& bash -lc "chmod +x '$msgFilterPath' && git filter-branch -f --msg-filter 'bash \''$msgFilterPath\''' -- --all" 2>&1 | Write-Host

Write-Host "New log (last $ShowCount):" -ForegroundColor Yellow
git --no-pager log --oneline -n $ShowCount | Write-Host

if (-not $NoPush) {
    Write-Host "Pushing rewritten history (force-with-lease)..." -ForegroundColor Yellow
    git push --force-with-lease
    git push --force-with-lease --tags
    Write-Host "Push complete." -ForegroundColor Green
}
else {
    Write-Host "NoPush specified. Skipping push. Use: git push --force-with-lease && git push --force-with-lease --tags" -ForegroundColor DarkYellow
}

Write-Host "Backup tag: $backupTag (delete when satisfied)" -ForegroundColor DarkGray
