# Nyoom.nvim

<div align="center">
  
[![Lua](https://img.shields.io/badge/Made%20With-Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)]()
[![Repo_Size](https://img.shields.io/github/languages/code-size/shaunsingh/nyoom.nvim?color=orange&label=Repo%20Size&style=for-the-badge)]()
[![Pull_Requests](https://img.shields.io/github/issues-pr/shaunisngh/nyoom.nvim?style=for-the-badge)]()
[![Issues](https://img.shields.io/github/issues/shausingh/nyoom.nvim?color=red&style=for-the-badge)]()
[![Neovim Minimum Version](https://img.shields.io/badge/Neovim-0.5+-blueviolet.svg?style=flat-square&logo=Neovim&logoColor=white)](https://github.com/neovim/neovim)

</div> 

## Install

### Using nix: 

Requires nix version > 21.11, with experimental features `flakes` and `nix-commands` enabled
```bash
git clone --depth 1 shaunsingh/nyoom.nvim && cd nyoom.nvim 
nix develop
nvim
```

Then run `:PackerSync`

### Regular:

Install the following dependencies: 

- neovim-nightly (or neovim stable)
- luajit
- ripgrep
- nodejs (optional, for copilot)

```bash
git clone --depth 1 shaunsingh/nyoom.nvim ~/.config/nvim 
nvim
```

Then run `:PackerSync`

## Showcase

## Theme Showcase

## Features

## TODO

- Rewrite statusline w/o plugins (+async)
- Redo Cmp/LspConfig/Copilot configs and integrations
- Rewrite theme to use `nvim_set_hl`
- Remove hardcoded hex values + theme switcher (dark/light)

## Warning

If you have an issue with a plugin in Nyoom.nvim, first you should report it to Nyoom.nvim to see if it's an issue with it. Please don't bother package maintainers with issues that are caused by my configs, and vice versa

