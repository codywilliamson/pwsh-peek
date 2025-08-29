# peek — Modern PowerShell directory listings (monorepo)

[![Netlify Status](https://api.netlify.com/api/v1/badges/bc85d29e-a297-4f04-a94f-ba0f1b89c3db/deploy-status)](https://app.netlify.com/projects/pwsh-peek/deploys)
[![CI](https://github.com/codywilliamson/pwsh-peek/actions/workflows/ci.yml/badge.svg)](https://github.com/codywilliamson/pwsh-peek/actions/workflows/ci.yml)
[![Module Version](https://img.shields.io/badge/Module-v1.0.0-5391FE.svg)](#)
[![Website Version](https://img.shields.io/badge/Website-v0.9.1-646CFF.svg)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Built with Vite](https://img.shields.io/badge/Built%20with-Vite-646CFF.svg)](https://vite.dev)
[![Vue 3](https://img.shields.io/badge/Vue-3-42b883.svg)](https://vuejs.org)
[![PowerShell](https://img.shields.io/badge/PowerShell-Module-5391FE.svg)](https://learn.microsoft.com/powershell/)

Blazing-fast, human-friendly directory listings for PowerShell with icons, human-readable sizes, relative timestamps, and intuitive aliases.

-   Website: https://peek.codywilliamson.com
-   Author: https://codywilliamson.com • https://spectaclesoftware.com • cody@spectaclesoftware.com

## Layout

-   `DirectoryListing.psm1` / `DirectoryListing.psd1` — the PowerShell module (exporting `Get-DirectoryView` and related commands)
-   `pwsh-peek/` — the marketing/docs website (Vue 3 + Vite + Tailwind)

## Features

-   Human-readable sizes (KB/MB/GB)
-   Relative timestamps (e.g., 5m ago, 2d ago)
-   Directory-first sorting and smart filters
-   Short, memorable aliases (pka, pkf, pkd, …)
-   Zero config; great defaults out of the box

## Quick Install

Run in PowerShell:

```powershell
iex (irm peek.codywilliamson.com/install.ps1)
```

Custom path / profile:

```powershell
iex "& { $(irm peek.codywilliamson.com/install.ps1) } -InstallPath 'C:\\MyModules' -AddToProfile"
```

## Commands

-   `peek` — Base listing. Options: `-All`, `-DirsFirst`, `-Long`, `-SortNewest`, `-SortSize`, `-Recurse`, `-Depth`
-   `peek-all` (alias: `pka`) — Include hidden/system items
-   `peek-all-recurse` (alias: `pkar`) — Recurse with `-Depth`
-   `peek-files` (alias: `pkf`) — Files only; supports `-SortSize`, `-SortNewest`
-   `peek-dirs` (alias: `pkd`) — Directories only
-   `peek-all-size` (alias: `pkas`) — All items, sorted by size
-   `peek-all-newest` (alias: `pkan`) — All items, newest first

## Develop the website

```pwsh
cd pwsh-peek
pnpm install
pnpm dev   # run locally
pnpm build # production build
```

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for setup, coding standards, and how to propose changes.

## License

MIT © Cody Williamson — see [LICENSE](LICENSE)

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
