# Copilot instructions for this repo

This repo is a tiny monorepo with two parts:

- PowerShell module at the root: `DirectoryListing.psm1/.psd1` (exports the `peek` experience)
- Website under `pwsh-peek/` (Vue 3 + Vite + Tailwind) that hosts docs and the installer (`/public/install.ps1`)

## Big picture

- Core command is `Get-DirectoryView` (alias: `peek`). It wraps `Get-ChildItem`, then emits friendly PSObjects with fields: Icon, Name, Type, Size, Modified, [Mode, FullName when `-Long`].
- Sort and filter behavior is opt-in via flags: `-All`, `-DirsFirst`, `-SortNewest`, `-SortSize`, `-OnlyFiles`, `-OnlyDirs`, `-Recurse -Depth`.
- Convenience wrappers (approved verbs) forward to `Get-DirectoryView`: `Get-PeekAll`, `Get-PeekAllRecurse`, `Get-PeekFiles`, `Get-PeekDirs`, `Get-PeekAllSize`, `Get-PeekAllNewest` with readable and short aliases (e.g., `peek-all`, `pka`).
- The website is content-only; it doesn’t call the module. It builds a static SPA and serves `/public/install.ps1` via Netlify.

## Workflows you’ll actually use

- Module quick check (Windows PowerShell 5.1+ compatible):
  ```pwsh
  Import-Module ./DirectoryListing.psd1 -Force
  peek -All -DirsFirst -SortNewest
  ```
- Installer smoke test (downloads from GitHub raw):
  ```pwsh
  iex (irm https://pwsh.peek.dev/install.ps1)
  ```
- Website dev/build (requires Node 20.19+ and pnpm):
  ```pwsh
  cd pwsh-peek
  pnpm install
  pnpm dev   # local
  pnpm build # prod
  ```
- CI: `.github/workflows/ci.yml` builds the site (Ubuntu) and does a Windows smoke import of the module.

## Conventions (PowerShell module)

- Keep PowerShell 5.1 syntax (no `Using:` class features, no PS7-only APIs). PSD1 sets `PowerShellVersion = '5.1'`.
- Public surface is declared in both places:
  - `DirectoryListing.psd1`: `FunctionsToExport`, `AliasesToExport`
  - `DirectoryListing.psm1`: `Export-ModuleMember -Function ... -Alias ...`
- If you add a wrapper (e.g., `Get-PeekNewest`):
  - Implement as a thin forwarder to `Get-DirectoryView` with switches.
  - Add readable alias (`peek-newest`) and short alias if useful.
  - Update both PSD1 exports and `Export-ModuleMember`.
- Output shape comes from `[PSCustomObject]` with keys exactly: `Icon, Name, Type, Size, Modified, Mode, FullName`. Respect `-Long` to include mode/full path and use `Format-Table -AutoSize` like the existing code.
- Icons are Unicode literals embedded in the module (📁/🔗/📄). Keep them simple and cross-shell safe.

## Conventions (website)

- Node engines are pinned: `"node": "^20.19.0 || >=22.12.0"`. Netlify uses `NODE_VERSION = 20.19.0` (see `pwsh-peek/netlify.toml`). Using Node 18 causes plugin hash errors.
- Vite + Vue 3 + Tailwind 4. Aliases: `@ -> /src` (see `vite.config.ts`).
- Static assets and the installer live in `pwsh-peek/public/`. Route `/install.ps1` is served directly (Netlify redirect 200 to itself).

## Integration points

- Installer: `pwsh-peek/public/install.ps1`
  - Params: `-InstallPath`, `-Branch` (default `master`, fallback to `main` on 404), `-Force`, `-AddToProfile`.
  - Downloads `DirectoryListing.psd1/.psm1/README.md` from GitHub raw into `$HOME\Documents\PowerShell\Modules\DirectoryListing` by default, then `Import-Module` and prints a short demo.
  - Uses TLS 1.2+ and no `-UseBasicParsing` (modern PowerShell).

## Gotchas

- Sorting with `-DirsFirst` is implemented by a compound `Sort-Object` expression; keep that pattern when adding new sort modes.
- Recursion honors `-Depth` only when `-Recurse` is set. Don’t change this contract.
- If Netlify builds fail with `[vite:vue] crypto.hash is not a function`, you’re on the wrong Node. Use 20.19+.

## Where to look

- Module: `DirectoryListing.psm1` (logic), `DirectoryListing.psd1` (metadata/exports)
- Installer: `pwsh-peek/public/install.ps1`
- Website: `pwsh-peek/src/**` with sections and views; `package.json`, `netlify.toml`, `vite.config.ts`

Questions or unclear areas? Call out any ambiguity around exports/aliases, installer behavior, or Node/Netlify setup so we can tighten these rules.
