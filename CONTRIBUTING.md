# Contributing to peek / DirectoryListing

Thanks for your interest in contributing! This repo contains:

-   A PowerShell module (`DirectoryListing.psm1`)
-   A website (Vue 3 + Vite + Tailwind) under `pwsh-peek/`

## Getting started

1. Fork the repo and clone your fork
2. Create a branch: `git checkout -b feature/your-change`
3. For the website:
    - `cd pwsh-peek`
    - `pnpm install`
    - `pnpm dev`
4. For the module:
    - Import locally: `Import-Module ./DirectoryListing.psd1 -Force`
    - Run: `Get-DirectoryView` or aliases like `peek`, `pkf`, `pkd`

## Coding standards

-   Keep the module fast and readable; prefer plain PowerShell with clear names
-   Avoid breaking changes to parameters or aliases without discussion
-   Keep web UI mobile friendly and accessible

## Commit and PR

-   Use clear commit messages (`feat:`, `fix:`, `docs:`, etc.)
-   Open a PR to `master` with a concise description and screenshots if UI changes

## Release & License

-   Licensed under MIT (see LICENSE)
-   By contributing, you agree your contributions are under MIT

## Contact / Links

-   Site: https://peek.codywilliamson.com
-   Author: https://codywilliamson.com • https://spectaclesoftware.com • cody@spectaclesoftware.com
