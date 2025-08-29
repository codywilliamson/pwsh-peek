# DirectoryListing module

A modern, concise directory listing for PowerShell with a unique alias `peek`.

-   Human-readable sizes (KB/MB/GB)
-   Relative modified times (e.g., 5m ago, 2d ago)
-   Directory-first and sorting options (size or newest)
-   Optional long view with Mode and FullName

## Usage

-   `peek` — list current directory
-   `peek -All` — include hidden/system
-   `peek -DirsFirst` — directories before files
-   `peek -SortNewest` — newest first
-   `peek -SortSize` — largest files first
-   `peek -Long` — extended columns
-   `peek -Recurse -Depth 2` — descend 2 levels
-   `Get-DirectoryView -OnlyFiles` — only files

## Install

Loaded automatically by your profile via `Settings.ps1` as part of `Import-CustomModules`.
