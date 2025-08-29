# peek PowerShell Module Installer
# This script downloads and installs the peek module for enhanced directory listing

[CmdletBinding()]
param(
    [string]$InstallPath = "$HOME\Documents\PowerShell\Modules",
    [switch]$Force,
    [switch]$AddToProfile
)

$ErrorActionPreference = "Stop"

# Module information
$ModuleName = "DirectoryListing"
$GitHubRepo = "codywilliamson/pwsh-peek"
$ModuleFolder = "modules/DirectoryListing"

Write-Host "🔧 Installing peek PowerShell Module..." -ForegroundColor Cyan
Write-Host ""

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

# Download module files
$BaseUrl = "https://raw.githubusercontent.com/$GitHubRepo/master/"
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
        $WebClient = New-Object System.Net.WebClient
        $WebClient.DownloadFile($Url, $Destination)
        $WebClient.Dispose()
    }
    catch {
        Write-Host "❌ Failed to download $File" -ForegroundColor Red
        Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
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
Write-Host "Try these commands:" -ForegroundColor White
Write-Host "  peek              # Basic directory listing" -ForegroundColor Cyan
Write-Host "  peek-all          # Show all files including hidden" -ForegroundColor Cyan  
Write-Host "  peek-files -All   # Show only files" -ForegroundColor Cyan
Write-Host "  peek-dirs         # Show only directories" -ForegroundColor Cyan
Write-Host "  pka               # Short alias for peek-all" -ForegroundColor Cyan
Write-Host ""
Write-Host "For full documentation, visit:" -ForegroundColor White
Write-Host "  https://peek.pwsh.dev" -ForegroundColor Blue
Write-Host ""

# Show a quick demo
Write-Host "📺 Quick demo:" -ForegroundColor Yellow
try {
    & peek
}
catch {
    Write-Host "   (Demo failed - but module should work!)" -ForegroundColor Gray
}
