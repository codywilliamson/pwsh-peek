# Pester tests for DirectoryListing module
# Requires: Pester v5+

BeforeAll {
    $here = Split-Path -Parent $PSCommandPath
    $repoRoot = Split-Path $here -Parent
    Import-Module (Join-Path $repoRoot 'DirectoryListing.psd1') -Force
}

Describe 'Convert-ToHumanSize' {
    It 'formats bytes under 1KB' {
        (Convert-ToHumanSize -Bytes 512) | Should -Be '512 B'
    }
    It 'formats KB with one decimal' {
        (Convert-ToHumanSize -Bytes 2048) | Should -Be '2.0 KB'
    }
}

Describe 'Convert-ToRelativeTime' {
    It 'shows seconds for very recent times' {
        $dt = (Get-Date).AddSeconds(-30)
        (Convert-ToRelativeTime -DateTime $dt) | Should -Match '30s ago|3\ds ago'
    }
    It 'shows minutes for within the hour' {
        $dt = (Get-Date).AddMinutes(-5)
        (Convert-ToRelativeTime -DateTime $dt) | Should -Match '5m ago'
    }
}

Describe 'Get-DirectoryView' {
    It 'returns some objects for current directory' {
        $result = Get-DirectoryView
        $result | Should -Not -BeNullOrEmpty
    }
    It 'supports -NoIcons ASCII output' {
        $result = Get-DirectoryView -NoIcons | Select-Object -First 1
        $result.Icon | Should -Match '^[DFL-]$'
    }
}
