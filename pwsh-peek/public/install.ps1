# peek PowerShell Module Installer
<#
Downloads and installs the DirectoryListing (peek) module from this repository's root.
Designed to be fetched via: iex (irm https://peek.codywilliamson.com/install.ps1)
This script assumes the module files (psd1, psm1) live in the repo root (not nested paths).
#>

[CmdletBinding()]
param(
    [string]$InstallPath = "$HOME\Documents\PowerShell\Modules",
    [string]$Branch = "master",
    [switch]$Force,
    [switch]$AddToProfile
)

$ErrorActionPreference = "Stop"

# Module information
$ModuleName = "DirectoryListing"
$GitHubRepo = "codywilliamson/pwsh-peek"

Write-Host "🔧 Installing peek PowerShell Module..." -ForegroundColor Cyan
Write-Host ""

# Basic environment checks
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "⚠️  PowerShell 7+ recommended. You're on $($PSVersionTable.PSVersion). The module works, but emoji icons may not render in Windows PowerShell 5.1." -ForegroundColor Yellow
}

# Ensure TLS 1.2+ for GitHub
try {
    $proto = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
    try { $proto = $proto -bor [Net.SecurityProtocolType]::Tls13 } catch { }
    [Net.ServicePointManager]::SecurityProtocol = $proto
}
catch { }

# Create module directory
$ModuleInstallPath = Join-Path $InstallPath $ModuleName
if (Test-Path $ModuleInstallPath) {
    if ($Force) {
        Write-Host "⚠️  Removing existing module..." -ForegroundColor Yellow
        Remove-Item $ModuleInstallPath -Recurse -Force
    }
    else {
        Write-Host "❌ Module already exists at $ModuleInstallPath" -ForegroundColor Red
        Write-Host "   Use -Force to overwrite or uninstall first" -ForegroundColor Red
        exit 1
    }
}

Write-Host "📁 Creating module directory: $ModuleInstallPath" -ForegroundColor Green
New-Item -ItemType Directory -Path $ModuleInstallPath -Force | Out-Null

# Download module files from repo root
$BaseUrl = "https://raw.githubusercontent.com/$GitHubRepo/$Branch"
$Files = @(
    "DirectoryListing.psd1",
    "DirectoryListing.psm1",
    "README.md"
)

Write-Host "⬇️  Downloading module files..." -ForegroundColor Green

foreach ($File in $Files) {
    $Url = "$BaseUrl/$File"
    $Destination = Join-Path $ModuleInstallPath $File
    try {
        Write-Host "   📄 $File" -ForegroundColor Gray
        Invoke-WebRequest -Uri $Url -OutFile $Destination -ErrorAction Stop
    }
    catch {
        Write-Host "❌ Failed to download $File from $Url" -ForegroundColor Red
        Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
        if ($Branch -eq 'master') {
            Write-Host "   Retrying against 'main' branch..." -ForegroundColor Yellow
            try {
                $fallbackUrl = "https://raw.githubusercontent.com/$GitHubRepo/main/$File"
                Invoke-WebRequest -Uri $fallbackUrl -OutFile $Destination -ErrorAction Stop
                Write-Host "   ✅ Fallback succeeded for $File" -ForegroundColor Green
            }
            catch {
                Write-Host "   ❌ Fallback failed for $File" -ForegroundColor Red
                exit 1
            }
        }
        else {
            exit 1
        }
    }
}

# Import the module
Write-Host "📦 Importing module..." -ForegroundColor Green
try {
    Import-Module $ModuleInstallPath -Force
    Write-Host "✅ Module imported successfully!" -ForegroundColor Green
}
catch {
    Write-Host "❌ Failed to import module" -ForegroundColor Red
    Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Test the module
Write-Host "🧪 Testing module..." -ForegroundColor Green
try {
    $Commands = Get-Command -Module DirectoryListing
    Write-Host "   Found $($Commands.Count) commands:" -ForegroundColor Gray
    foreach ($Cmd in $Commands) {
        Write-Host "     • $($Cmd.Name)" -ForegroundColor Gray
    }
}
catch {
    Write-Host "⚠️  Warning: Could not test module commands" -ForegroundColor Yellow
}

# Add to profile if requested
if ($AddToProfile) {
    Write-Host "📝 Adding to PowerShell profile..." -ForegroundColor Green
    
    $ProfilePath = $PROFILE
    if (!(Test-Path $ProfilePath)) {
        New-Item -ItemType File -Path $ProfilePath -Force | Out-Null
        Write-Host "   Created new profile: $ProfilePath" -ForegroundColor Gray
    }
    
    $ImportLine = "Import-Module DirectoryListing"
    $ProfileContent = Get-Content $ProfilePath -ErrorAction SilentlyContinue
    
    if ($ProfileContent -notcontains $ImportLine) {
        Add-Content -Path $ProfilePath -Value "`n# peek module"
        Add-Content -Path $ProfilePath -Value $ImportLine
        Write-Host "   Added import statement to profile" -ForegroundColor Gray
    }
    else {
        Write-Host "   Import statement already exists in profile" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "🎉 Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "ℹ️  Tip: If icons look like empty boxes, switch to PowerShell 7+ in Windows Terminal and a font with color emoji (e.g., Segoe UI Emoji)." -ForegroundColor DarkGray
Write-Host "     Optional: Install 'Terminal-Icons' for nicer ls/dir output (peek already includes basic icons)." -ForegroundColor DarkGray
Write-Host "     Fallback: Use 'peek -NoIcons' (alias: -Ascii) or make it default with 'Set-NoIconsForPeek -Scope User'." -ForegroundColor DarkGray
Write-Host "     Revert later with 'Set-NoIconsForPeek -Off -Scope User'." -ForegroundColor DarkGray
Write-Host "     For paging, prefer 'Out-Host -Paging' instead of 'more' to avoid Unicode issues." -ForegroundColor DarkGray
Write-Host ""
Write-Host "Try these commands:" -ForegroundColor White
Write-Host "  peek              # Basic directory listing" -ForegroundColor Cyan
Write-Host "  peek-all          # Show all files including hidden" -ForegroundColor Cyan  
Write-Host "  peek-files -All   # Show only files" -ForegroundColor Cyan
Write-Host "  peek-dirs         # Show only directories" -ForegroundColor Cyan
Write-Host "  pka               # Short alias for peek-all" -ForegroundColor Cyan
Write-Host ""
Write-Host "For full documentation, visit:" -ForegroundColor White
Write-Host "  https://peek.codywilliamson.com" -ForegroundColor Blue
Write-Host ""

# Show a quick demo
Write-Host "📺 Quick demo:" -ForegroundColor Yellow
try {
    & peek
}
catch {
    Write-Host "   (Demo failed - but module should work!)" -ForegroundColor Gray
}
