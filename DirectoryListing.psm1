function Convert-ToHumanSize {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [long]$Bytes
    )
    if ($Bytes -lt 1KB) { return "$Bytes B" }
    $sizes = @('KB', 'MB', 'GB', 'TB', 'PB')
    $val = [double]$Bytes
    $i = 0
    while ($val -ge 1024 -and $i -lt $sizes.Count - 1) {
        $val = $val / 1024
        $i++
    }
    '{0:N1} {1}' -f $val, $sizes[$i]
}

function Convert-ToRelativeTime {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [datetime]$DateTime
    )
    $span = (Get-Date) - $DateTime
    if ($span.TotalSeconds -lt 60) { return "{0:N0}s ago" -f $span.TotalSeconds }
    if ($span.TotalMinutes -lt 60) { return "{0:N0}m ago" -f $span.TotalMinutes }
    if ($span.TotalHours -lt 24) { return "{0:N0}h ago" -f $span.TotalHours }
    if ($span.TotalDays -lt 7) { return "{0:N0}d ago" -f $span.TotalDays }
    if ($span.TotalDays -lt 30) { return "{0:N0}w ago" -f ($span.TotalDays / 7) }
    if ($span.TotalDays -lt 365) { return "{0:N0}mo ago" -f ($span.TotalDays / 30) }
    return "{0:N0}y ago" -f ($span.TotalDays / 365)
}

function Get-DirectoryView {
    <#
    .SYNOPSIS
    A modern, concise directory listing with icons, human sizes, and relative times.

    .DESCRIPTION
    Get-DirectoryView wraps Get-ChildItem and emits friendly objects for interactive use.
    It supports hidden files, directory-first sorting, and size/time formatting.

    .PARAMETER Path
    The path to list. Defaults to current directory.

    .PARAMETER Depth
    Depth for recursion when -Recurse is used. Defaults to 1.

    .PARAMETER Recurse
    Recurse into subdirectories.

    .PARAMETER All
    Include hidden and system items.

    .PARAMETER Long
    Show extended columns (Mode, FullName).

    .PARAMETER DirsFirst
    List directories before files.

    .PARAMETER SortNewest
    Sort by LastWriteTime descending.

    .PARAMETER SortSize
    Sort by length descending (files only; directories grouped by DirsFirst).

    .PARAMETER OnlyFiles
    Show only files.

    .PARAMETER OnlyDirs
    Show only directories.

    .EXAMPLE
    peek

    .EXAMPLE
    peek -All -DirsFirst -SortNewest

    .NOTES
    Exported alias: peek
    #>
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)]
        [string]$Path = '.',

        [int]$Depth = 1,
        [switch]$Recurse,
        [switch]$All,
        [switch]$Long,
        [switch]$DirsFirst,
        [switch]$SortNewest,
        [switch]$SortSize,
        [switch]$OnlyFiles,
        [switch]$OnlyDirs,
        [Alias('Ascii')]
        [switch]$NoIcons
    )

    # If caller didn't specify -NoIcons, honor environment or config preference
    if (-not $PSBoundParameters.ContainsKey('NoIcons')) {
        $pref = Get-PeekPreference
        if ($pref.NoIcons) { $NoIcons = $true }
    }

    # Build Get-ChildItem parameters
    $gciParams = @{ Path = $Path; ErrorAction = 'SilentlyContinue' }
    if ($Recurse) { $gciParams['Recurse'] = $true; $gciParams['Depth'] = $Depth }
    if ($All) { $gciParams['Force'] = $true }

    $items = Get-ChildItem @gciParams | Where-Object { $_ } # drop nulls

    if ($OnlyFiles) { $items = $items | Where-Object { -not $_.PSIsContainer } }
    if ($OnlyDirs) { $items = $items | Where-Object { $_.PSIsContainer } }

    # Sorting
    if ($SortSize) {
        if ($DirsFirst) {
            $items = $items | Sort-Object @{Expression = { $_.PSIsContainer -eq $false }; Descending = $true }, @{Expression = { $_.Length }; Descending = $true }, Name
        }
        else {
            $items = $items | Sort-Object @{Expression = { $_.Length }; Descending = $true }, Name
        }
    }
    elseif ($SortNewest) {
        if ($DirsFirst) {
            $items = $items | Sort-Object @{Expression = { $_.PSIsContainer -eq $false }; Descending = $true }, @{Expression = { $_.LastWriteTime }; Descending = $true }, Name
        }
        else {
            $items = $items | Sort-Object @{Expression = { $_.LastWriteTime }; Descending = $true }, Name
        }
    }
    else {
        if ($DirsFirst) {
            $items = $items | Sort-Object @{Expression = { $_.PSIsContainer -eq $false }; Descending = $true }, Name
        }
        else {
            $items = $items | Sort-Object Name
        }
    }

    $out = foreach ($it in $items) {
        $isDir = $it.PSIsContainer
        $type = if ($isDir) { 'Dir' } elseif ($it.LinkType) { 'Link' } else { 'File' }
        if ($NoIcons) {
            $icon = if ($isDir) { 'D' } elseif ($it.LinkType) { 'L' } else { 'F' }
        }
        else {
            $icon = if ($isDir) { '📁' } elseif ($it.LinkType) { '🔗' } else { '📄' }
        }
        $size = if ($isDir) { '-' } else { Convert-ToHumanSize -Bytes ($it.Length) }
        $when = Convert-ToRelativeTime -DateTime $it.LastWriteTime

        [PSCustomObject]@{
            Icon     = $icon
            Name     = $it.Name
            Type     = $type
            Size     = $size
            Modified = $when
            Mode     = $it.Mode
            FullName = $it.FullName
        }
    }

    if ($Long) {
        $out | Select-Object Icon, Name, Type, Size, Modified, Mode, FullName | Format-Table -AutoSize
    }
    else {
        $out | Select-Object Icon, Name, Type, Size, Modified | Format-Table -AutoSize
    }
}

# Convenience wrappers (approved verb names) and user-friendly aliases

function Get-PeekAll {
    [CmdletBinding()]
    param(
        [string]$Path = '.',
        [switch]$DirsFirst,
        [switch]$Long,
        [Alias('Ascii')]
        [switch]$NoIcons
    )
    Get-DirectoryView -Path $Path -All -DirsFirst:$DirsFirst -Long:$Long -NoIcons:$NoIcons
}

function Get-PeekAllRecurse {
    [CmdletBinding()]
    param(
        [string]$Path = '.',
        [int]$Depth = 1,
        [switch]$DirsFirst,
        [switch]$Long,
        [Alias('Ascii')]
        [switch]$NoIcons
    )
    Get-DirectoryView -Path $Path -All -Recurse -Depth $Depth -DirsFirst:$DirsFirst -Long:$Long -NoIcons:$NoIcons
}

function Get-PeekFiles {
    [CmdletBinding()]
    param(
        [string]$Path = '.',
        [switch]$All,
        [switch]$DirsFirst,
        [switch]$Long,
        [switch]$SortNewest,
        [switch]$SortSize,
        [Alias('Ascii')]
        [switch]$NoIcons
    )
    Get-DirectoryView -Path $Path -OnlyFiles -All:$All -DirsFirst:$DirsFirst -Long:$Long -SortNewest:$SortNewest -SortSize:$SortSize -NoIcons:$NoIcons
}

function Get-PeekDirs {
    [CmdletBinding()]
    param(
        [string]$Path = '.',
        [switch]$All,
        [switch]$DirsFirst,
        [switch]$Long,
        [switch]$SortNewest,
        [switch]$SortSize,
        [Alias('Ascii')]
        [switch]$NoIcons
    )
    Get-DirectoryView -Path $Path -OnlyDirs -All:$All -DirsFirst:$DirsFirst -Long:$Long -SortNewest:$SortNewest -SortSize:$SortSize -NoIcons:$NoIcons
}

function Get-PeekAllSize {
    [CmdletBinding()]
    param(
        [string]$Path = '.',
        [switch]$DirsFirst,
        [switch]$Long,
        [Alias('Ascii')]
        [switch]$NoIcons
    )
    Get-DirectoryView -Path $Path -All -SortSize -DirsFirst:$DirsFirst -Long:$Long -NoIcons:$NoIcons
}

function Get-PeekAllNewest {
    [CmdletBinding()]
    param(
        [string]$Path = '.',
        [switch]$DirsFirst,
        [switch]$Long,
        [Alias('Ascii')]
        [switch]$NoIcons
    )
    Get-DirectoryView -Path $Path -All -SortNewest -DirsFirst:$DirsFirst -Long:$Long -NoIcons:$NoIcons
}

# Aliases (readable plus short forms)
Set-Alias -Name peek -Value Get-DirectoryView
Set-Alias -Name 'peek-all' -Value Get-PeekAll
Set-Alias -Name 'peek-all-recurse' -Value Get-PeekAllRecurse
Set-Alias -Name 'peek-files' -Value Get-PeekFiles
Set-Alias -Name 'peek-dirs' -Value Get-PeekDirs
Set-Alias -Name 'peek-all-size' -Value Get-PeekAllSize
Set-Alias -Name 'peek-all-newest' -Value Get-PeekAllNewest

# Short convenience aliases
Set-Alias -Name pka -Value Get-PeekAll
Set-Alias -Name pkar -Value Get-PeekAllRecurse
Set-Alias -Name pkf -Value Get-PeekFiles
Set-Alias -Name pkd -Value Get-PeekDirs
Set-Alias -Name pkas -Value Get-PeekAllSize
Set-Alias -Name pkan -Value Get-PeekAllNewest

Export-ModuleMember -Function Get-DirectoryView, Get-PeekAll, Get-PeekAllRecurse, Get-PeekFiles, Get-PeekDirs, Get-PeekAllSize, Get-PeekAllNewest -Alias peek, 'peek-all', 'peek-all-recurse', 'peek-files', 'peek-dirs', 'peek-all-size', 'peek-all-newest', pka, pkar, pkf, pkd, pkas, pkan

# ---- Preferences & configuration helpers ----

function Get-PeekConfigPath {
    $appData = $env:APPDATA
    if ($appData) {
        return Join-Path $appData 'DirectoryListing/config.json'
    }
    # Fallback to ~/.config
    $cfgHome = Join-Path $HOME '.config/DirectoryListing/config.json'
    return $cfgHome
}

function Get-PeekPreference {
    [CmdletBinding()]
    param()
    $noIcons = $false
    $source = 'Default'

    if ($env:PEEK_NO_ICONS) {
        $noIcons = ($env:PEEK_NO_ICONS -ne '0')
        $source = 'Env'
    }
    else {
        try {
            $cfgPath = Get-PeekConfigPath
            if (Test-Path $cfgPath) {
                $json = Get-Content -Path $cfgPath -Raw -ErrorAction Stop | ConvertFrom-Json
                if ($null -ne $json.NoIcons) {
                    $noIcons = [bool]$json.NoIcons
                    $source = 'Config'
                }
            }
        }
        catch { }
    }
    [PSCustomObject]@{ NoIcons = $noIcons; Source = $source }
}

function Set-NoIconsForPeek {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [switch]$Off,
        [ValidateSet('Process', 'User', 'Config')]
        [string]$Scope = 'Process'
    )

    $enable = -not $Off

    switch ($Scope) {
        'Process' {
            if ($PSCmdlet.ShouldProcess("Process env", ($enable ? 'Enable' : 'Disable'))) {
                if ($enable) { $env:PEEK_NO_ICONS = '1' } else { Remove-Item Env:\PEEK_NO_ICONS -ErrorAction SilentlyContinue }
            }
        }
        'User' {
            if ($PSCmdlet.ShouldProcess("User env", ($enable ? 'Enable' : 'Disable'))) {
                [Environment]::SetEnvironmentVariable('PEEK_NO_ICONS', ($enable ? '1' : $null), 'User') | Out-Null
            }
        }
        'Config' {
            if ($PSCmdlet.ShouldProcess("Config file", ($enable ? 'Enable' : 'Disable'))) {
                $cfgPath = Get-PeekConfigPath
                $dir = Split-Path $cfgPath -Parent
                if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
                $obj = @{ NoIcons = $enable }
                $obj | ConvertTo-Json -Depth 4 | Set-Content -Path $cfgPath -Encoding UTF8
            }
        }
    }
}

Export-ModuleMember -Function Get-PeekPreference, Set-NoIconsForPeek -Alias
