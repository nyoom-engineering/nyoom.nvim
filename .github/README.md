# Nyoom.nvim

This config was a reponse to new configs that pop up, with very abstracted and complex codebases, such as NvChad. They try to be a one-size-fits-all config. NvChad and LunarVim both try to fit as much overall functionality as possible and needlessly lazy load *everything*, when it really isn't needed. Complex codebases lead to less freedom for end-user extensiblity. Try forking NvChad and making your own configuration out of it. Thats right, you can't. Everything is tied to the userConfig, and you rely on the maintainer of said code to implement features. 

Nyoom.nvim provides a solution to these problems by providing only the necessary code in order to make a functioning configuration. The end goal of nyoom.nvim is to be used as a base config for users to extend and add upon, leading to a more unique editing experience. Its relatively small and simple, offers the bare minimum needed plugins to have a powerful config, and is suited to my needs, but can just as easily be suited to yours!

Fennel is a programming language that brings together the speed, simplicity, and reach of Lua with the flexibility of a lisp syntax and macro system. With the macros provided, you can configure neovim just as easily, or dare I say *easier* than you can with Lua, while retaining the performance benefits of LuaJIT.

I recommend not to clone and directly install this config, but to fork it, inspect the code, and adjust it to your liking. The best neovim configuration is what *you* make, and this config is only supposed to provide you the tools to do so.

All the magic happens in the `fnl/` folder. Some files to check out:
- `init.fnl`: This is where all your plugins go. The init file is in charge of configuring packer, installing, as well as loading plugins
- `config.fnl`: This is where neovim settings go
- `macros.fnl`: In lisps, macros allow the user to define arbitrary functions that convert certain Lisp forms into different forms before evaluating or compiling them. This file contains all the macros that I (and a few others, thanks kat!) have written to help you out on your neovim journey. I don't recommend touching this file unless you know what you're doing
- `maps.fnl`: This is where all your mappings go
- `pack/`: This is where plugin configs go.

## Showcase

Coming soon!

## Install

### Using nix: 

Requires nix version > 21.11, with experimental features `flakes` and `nix-commands` enabled
```bash
git clone --depth 1 shaunsingh/nyoom.nvim && cd nyoom.nvim 
nix develop
```

Then run `nvim` as usual, and `:PackerSync` to update/install plugins

### Regular:

Install the following dependencies: 

- neovim-nightly (or neovim stable)
- ripgrep
- nodejs (optional, for copilot)
- fennel + fnlfmt (not required, but recommended)
- font with nerdfont icons 

```bash
git clone --depth 1 shaunsingh/nyoom.nvim ~/.config/nvim 
nvim
```

Then run `:PackerSync`

## Features

Nyoom.nvim provides the following: 
- Fast plugin management via Packer.nvim
- Optimized startup and caching via filetype.lua and impatient.nvim
- Macros and easy to configure plugins via Fennel
- Colorful syntax highlighting, indentation, and parenthesis via nvim-treesitter
- Diagonstics and lsp support using nvim_lsp

## Warning

If you have an issue with a plugin in Nyoom.nvim, first you should report it to Nyoom.nvim to see if it's an issue with it. Please don't bother package maintainers with issues that are caused by my configs, and vice versa

