# Pester tests for DirectoryListing module (compatible with Pester v3 and v5)

Describe 'DirectoryListing module' {
    BeforeAll {
        $here = Split-Path -Parent $PSCommandPath
        $repoRoot = Split-Path $here -Parent
        $psd1 = Join-Path $repoRoot 'DirectoryListing.psd1'
        if (-not (Test-Path $psd1)) { throw "Module manifest not found: $psd1" }
        Import-Module $psd1 -Force -ErrorAction Stop

        # Prepare a temporary test directory inside Pester's TestDrive (auto-cleaned)
    $tdRoot = 'TestDrive:\'
    $global:TestDir = Join-Path $tdRoot 'peek-tests'
    New-Item -ItemType Directory -Path $global:TestDir -Force | Out-Null

    # Create files first so we can use their physical FullName with .NET APIs
    $smallItem = New-Item -ItemType File -Path (Join-Path $global:TestDir 'small.bin') -Force
    $twoKBItem = New-Item -ItemType File -Path (Join-Path $global:TestDir 'twoKB.bin') -Force

    # Create files with exact sizes using FileStream.SetLength for determinism (use physical paths)
    $fs1 = [System.IO.File]::Open($smallItem.FullName, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write, [System.IO.FileShare]::None)
    $fs1.SetLength(512)
    $fs1.Dispose()

    $fs2 = [System.IO.File]::Open($twoKBItem.FullName, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write, [System.IO.FileShare]::None)
    $fs2.SetLength(2048)
    $fs2.Dispose()

    # Timestamps to exercise relative time (set on physical paths)
    (Get-Item $smallItem.FullName).LastWriteTime = (Get-Date).AddSeconds(-30)
    (Get-Item $twoKBItem.FullName).LastWriteTime = (Get-Date).AddMinutes(-5)
    }

    # No explicit cleanup required; Pester removes TestDrive automatically

    Context 'Size formatting via Get-DirectoryView' {
        It 'formats bytes under 1KB as 512 B' {
            $result = Get-DirectoryView -Path $global:TestDir -Raw | Where-Object Name -eq 'small.bin'
            $result.Size | Should -Match '^(?i)512\s+B$'
        }
        It 'formats 2048 bytes as 2.0 KB' {
            $result = Get-DirectoryView -Path $global:TestDir -Raw | Where-Object Name -eq 'twoKB.bin'
            # Accept comma or dot decimal separators depending on locale
            $result.Size | Should -Match '^(?i)2[\.,]0\s+KB$'
        }
    }

    Context 'Relative time via Get-DirectoryView' {
        It 'shows seconds for very recent times' {
            $result = Get-DirectoryView -Path $global:TestDir -Raw | Where-Object Name -eq 'small.bin'
            $result.Modified | Should -Match 's ago$'
        }
        It 'shows minutes for within the hour' {
            $result = Get-DirectoryView -Path $global:TestDir -Raw | Where-Object Name -eq 'twoKB.bin'
            $result.Modified | Should -Match 'm ago$'
        }
    }

    Context 'ASCII icon mode' {
        It 'emits ASCII icons with -NoIcons' {
            $result = Get-DirectoryView -Path $global:TestDir -NoIcons -Raw | Select-Object -First 1
            $result.Icon | Should -Match '^[DFL-]$'
        }
    }
}
