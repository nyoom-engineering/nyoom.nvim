# Nyoom.nvim

[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=for-the-badge&logo=lua)](https://lua.org)

</div>

<div align="center">

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

