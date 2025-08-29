````markdown
# peek — Modern PowerShell directory listings

Blazing-fast, human-friendly directory listings for PowerShell with icons, human-readable sizes, relative timestamps, and intuitive aliases.

Website: https://pwsh-peek.netlify.app

## Features

-   Human-readable sizes (KB/MB/GB)
-   Relative timestamps (e.g., 5m ago, 2d ago)
-   Directory-first sorting and smart filters
-   Short, memorable aliases (pka, pkf, pkd, …)
-   Zero config; great defaults out of the box

## Quick Install

Run in PowerShell:

```powershell
iex (irm peek.pwsh.dev/install.ps1)
```
````

This installs the module to your PowerShell modules directory and imports it.

### Custom Install

```powershell
iex (irm peek.pwsh.dev/install.ps1) -InstallPath "C:\MyModules" -AddToProfile
```

## Commands

-   peek — Base listing. Options: -All, -DirsFirst, -Long, -SortNewest, -SortSize, -Recurse, -Depth
-   peek-all (alias: pka) — Include hidden/system items
-   peek-all-recurse (alias: pkar) — Recurse with -Depth
-   peek-files (alias: pkf) — Files only; supports -SortSize, -SortNewest
-   peek-dirs (alias: pkd) — Directories only
-   peek-all-size (alias: pkas) — All items, sorted by size
-   peek-all-newest (alias: pkan) — All items, newest first

## Aliases

-   peek → Get-DirectoryView
-   pka → peek-all
-   pkar → peek-all-recurse
-   pkf → peek-files
-   pkd → peek-dirs
-   pkas → peek-all-size
-   pkan → peek-all-newest

## Examples

```powershell
# See everything, directories first
pka -DirsFirst

# Biggest files first
pkf -SortSize

# Recurse with depth limit
pkar -Depth 2

# Newest items first with long view
peek -All -SortNewest -Long
```

## Developing the Website (Vue 3 + Vite + Tailwind)

This repo includes the marketing/docs site in `pwsh-peek/`.

```pwsh
pnpm install
pnpm dev   # run the site locally
pnpm build # production build
```

## License

MIT

```

```
