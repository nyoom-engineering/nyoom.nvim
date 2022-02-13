# Nyoom.nvim

Note: Requires neovim-nightly (v0.7)

This config was a response to new configs that pop up, with very abstracted and complex codebases, such as NvChad. They try to be a one-size-fits-all config. NvChad and LunarVim both try to fit as much overall functionality as possible and needlessly lazy load *everything*, when it really isn't needed. Complex codebases lead to less freedom for end-user extensiblity. Try forking NvChad and making your own configuration out of it. Thats right, you can't. Everything is tied to the userConfig, and you rely on the maintainer of said code to implement features. 

Nyoom.nvim provides a solution to these problems by providing only the necessary code in order to make a functioning configuration. The end goal of nyoom.nvim is to be used as a base config for users to extend and add upon, leading to a more unique editing experience. Its relatively small and simple, offers the bare minimum needed plugins to have a powerful config, and is suited to my needs, but can just as easily be suited to yours!

I recommend not to clone and directly install this config, but to fork it, inspect the code, and adjust it to your liking. The best neovim configuration is what *you* make, and this config is only supposed to provide you the tools to do so.

## Showcase

![This might not be up to date, but its representative of the config as of 02/13/22](demo.png)

## Why fennel?
Fennel is a programming language that brings together the speed, simplicity, and reach of Lua with the flexibility of a lisp syntax and macro system. Macros are how lisps accomplish metaprogramming. You’ll see a lot of people treat lisp macros with a kind of mystical reverence. While several other languages have macro systems, the power of macros in lisps stem from allowance of lisps to you to write programs using the same notation you use for data structures. Remember: code is data, and we just need to manipulate data.

While people largely over exaggerate the usefulness of macros, there are a few places where macros shine, and configurations are one of them. Utilizing macros, we can essentially create our own syntax. For example, lets take a look at the `set!` macro I've used. `set!` is used for `vim.opt` options. For example, `(set! mouse :a)` expands to `vim.opt["mouse"]="a"`. If a string or number isn't passed to `set!`, it will assume true. e.g. `(set! list)` will expand to `vim.opt["list"]=true`. Similarly if the option starts with no, it will assume false e.g. `(set! noru)` will expand to `vim.opt["ru"]=false`.

With the macros provided, you can configure neovim just as easily, or dare I say easier than you can with Lua or vimscript, while retaining the performance benefits of LuaJIT.

All the magic happens in the `fnl/` folder. Some files to check out:
- `init.fnl`: This is where you require any "main" fennel files (i.e. not plugin configurations).
- `pack.fnl`: This is where all your plugins go. The pack file is in charge of configuring packer, installing, as well as loading plugins
- `config.fnl`: This is where neovim settings go. 
- `macros.fnl`: In lisps, macros allow the user to define arbitrary functions that convert certain Lisp forms into different forms before evaluating or compiling them. This file contains all the macros that I (and a few others, thanks David and Kat!) have written to help you out on your neovim journey. I don't recommend touching this file unless you know what you're doing
- `maps.fnl`: This is where all your mappings go
- `pack/`: This is where plugin configs go.

## Install

### Dependencies

The only dependencies are `neovim-nightly`, `git`, and optionally `rustc/cargo` if you plan to use `parinfer-rust`.

### Regular:

Install the following dependencies: 
- neovim-nightly (or neovim stable)
- ripgrep
- nodejs (optional, for copilot)
- fennel + fnlfmt (not required, but recommended)
- rustc + cargo (ideally via rustup, not required, but recommended for parinfer)
- font with nerdfont icons 

```bash
git clone --depth 1 shaunsingh/nyoom.nvim ~/.config/nvim 
nvim
```

Then run `:PackerSync`

### Using nix: 

Requires nix version > 21.11, with experimental features `flakes` and `nix-commands` enabled
```bash
git clone --depth 1 shaunsingh/nyoom.nvim && cd nyoom.nvim 
nix develop
```

Then run `nvim` as usual, and `:PackerSync` to update/install plugins

## Useful plugins

### Essentials

- packer.nvim
- impatient.nvim
- which-key.nvim

### Lisps

- conjure
- hotpot
- aniseed
- parinfer-rust

### Completion

- copilot
- Comment.nvim
- nvim-autopairs

### Utilities

- Telescope: 
 - File browser
 - Packer
 - frecency
 - fzf-native
- Treesitter: 
 - Playground
 - nvim-ts-rainbow
- Lsp: 
 - Lspconfig
 - Trouble.nvim
 - nvim-lsp-installer

### Looks

- nvim-base16
- TrueZen.nvim
- nvim-hlslens
- gitsigns.nvim
- nvim-notify

### Note-taking

- neorg
- orgmode

### Aniseed vs Hotpot

- Aniseed: Aniseed bridges the gap between Fennel and Neovim, Allowing you to easily write plugins or configuration in a Clojure-like Lisp with great runtime performance. As opposed to hotpot, aniseed provides macros, is slightly faster and more featureful, compiles fennel files to the lua/ directory, and has better integration with conjure. It aims to provide a more clojure-like experience, and behaves as a superset of fennel.

- Hotpot: Hotpot will transparently compile your Fennel code into Lua and then return the compiled module. Future calls to `require` (including in future Neovim sessions) will skip the compile step unless it's stale. Only compiles and caches fennel files, providing a more native experience for the user. On the other hand, it is slightly slower and less developed. Users looking for macros can use the builtin macros defined in macros.fnl, or the zest.nvim library.

In `init.lua`, you can set the compiler to aniseed/hotpot, and nyoom will handle the rest. All the current configuration is hotpot-compatible, so it doesn't use any aniseed macros by default. However, you are free to use them yourself. 

## Warning

If you have an issue with a plugin in Nyoom.nvim, first you should report it to Nyoom.nvim to see if it's an issue with it. Please don't bother package maintainers with issues that are caused by my configs, and vice versa. I'm new to fennel, so don't hesitate to tell me my lisp-fu sucks! 

