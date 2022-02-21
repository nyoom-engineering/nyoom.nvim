
# Nyoom.nvim

<div align="center">

[![Fennel](	https://img.shields.io/badge/Made%20with%20Fennel-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://fennel-lang.org)

</div>

<div align="center">

[![License](https://img.shields.io/github/license/shaunsingh/nyoom.nvim?style=flat-square)](https://mit-license.org/)
[![Open Issues](https://img.shields.io/github/issues-raw/shaunsingh/nyoom.nvim?style=flat-square)](https://github.com/shaunsingh/nyoom.nvim/issues)
[![Neovim Minimum Version](https://img.shields.io/badge/Neovim-0.7.0-blueviolet.svg?style=flat-square&logo=Neovim&logoColor=white)](https://github.com/neovim/neovim)

</div>

> \<leader\>\<space\> Nyoommmmm!
>
> ~ Nyoom.nvim users (probably)

This config was a response to new configs that pop up, with very abstracted and complex codebases, such as NvChad. They try to be a one-size-fits-all config. NvChad and LunarVim both try to fit as much overall functionality as possible and needlessly lazy load *everything*, when it really isn't needed. Complex codebases lead to less freedom for end-user extensiblity. Try forking NvChad and making your own configuration out of it. Thats right, you can't. Everything is tied to the userConfig, and you rely on the maintainer of said code to implement features. 

Nyoom.nvim provides a solution to these problems by providing only the necessary code in order to make a functioning configuration. The end goal of nyoom.nvim is to be used as a base config for users to extend and add upon, leading to a more unique editing experience. Its relatively small and simple, offers the bare minimum needed plugins to have a powerful config, and is suited to my needs, but can just as easily be suited to yours!

I recommend not to clone and directly install this config, but to fork it, inspect the code, and adjust it to your liking. The best neovim configuration is what *you* make, and this config is only supposed to provide you the tools to do so.

## Design 
Nyoom.nvim is designed against the mantras of [doom-emacs](https://github.com/hlissner/doom-emacs): (shamelessly copypasted)
- Gotta go fast. Startup and run-time performance are priorities.
- Close to metal. There's less between you and vanilla neovim by design. That's less to grok and less to work around when you tinker.
- Opinionated, but not stubborn. Nyoom (and Doom) are about reasonable defaults and curated opinions, but use as little or as much of it as you like.
- Your system, your rules. You know better. At least, Nyoom hopes so! There are no external dependencies, and there never will be. 

It also aligns with many of Doom's features:
- Minimalistic good looks inspired by modern editors.
- A modular organizational structure for separating concerns in your config. (somewhat, I plan to improve on this in the future by turning sets of packages into nyoom modules :tm:, and loading them via a macro like doom does)
- A standard library designed to simplify your fennel bike shedding.
- A declarative package management system (inspired by `use-package`, powered by [Packer.nvim](https://github.com/wbthomason/packer.nvim)). Install packages from anywhere, and pin them to any commit.
- A Space(vim)-esque keybinding scheme, centered around leader and localleader prefix keys (SPC and SPCm).
- Project search (and replace) utilities, powered by ripgrep, fzf-native, sqlite, and telescope.

However, it also disagrees with some of those ideals
- Packages are not pinned to commits *by default*. Unlike Doom, this configuration includes fewer than 20 packages by default and breaking changes are usually few and far between. Everything is rolling release, and if a breaking change does occur I will push a fix within a day (pinky promise!). Of course, you are free to pin packages yourself (and use [:PackerSnapshot](https://github.com/wbthomason/packer.nvim/pull/370)). I may reconsider as nyoom grows. 

## Credits

- [David Guevara](https://github.com/datwaft) For getting me into fennel, and for some of his beautiful macros. Without him Nyoom wouldn't exist! 
- [Oliver Caldwell](https://github.com/Olical/) For his excellent work on Aniseed, Conjure, and making fennel feel like a first class langugae in neovim

## Showcase

Lispy editing using [conjure](https://github.com/Olical/conjure) and [parinfer-rust](https://github.com/eraserhd/parinfer-rust)

<img width="1368" alt="conjure" src="https://user-images.githubusercontent.com/71196912/153767677-ecb3b82a-d57d-4cf7-bd42-a67b5d56df4f.png">

https://user-images.githubusercontent.com/71196912/153767688-a5e0cfc9-6437-43d1-9205-ed8ca7a07ae5.mov

Note-taking and Getting Things Done with [neorg](https://github.com/nvim-neorg/neorg) and [orgmode](https://github.com/nvim-orgmode/orgmode)

<img width="1402" alt="neorg" src="https://user-images.githubusercontent.com/71196912/153767720-2a021786-a99d-43ec-81f1-7c6078bc684e.png">

Syntax highlighting and Error checking with Neovim's builtin LSP, [lspconfig](https://github.com/neovim/nvim-lspconfig), [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer/), [trouble.nvim](https://github.com/folke/trouble.nvim) and [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

<img width="1402" alt="lsp" src="https://user-images.githubusercontent.com/71196912/153767871-f3416e7a-93f9-4842-bfbd-16a3ff7b1d8f.png">

https://user-images.githubusercontent.com/71196912/153768142-b35ac2aa-eb3d-489d-918d-b11870758c8f.mov

Quick Completion powered by [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) and [copilot.vim](https://github.com/github/copilot.vim)

<img width="271" alt="Screen Shot 2022-02-13 at 4 45 22 PM" src="https://user-images.githubusercontent.com/71196912/153777271-61726ee5-6677-450e-8864-d38cf2216c13.png">

Pretty notifications and focused editing using [TrueZen](https://github.com/pocco81/truezen.nvim), [nvim-notify](https://github.com/rcarriga/nvim-notify), and [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens)

<img width="1402" alt="notifymap" src="https://user-images.githubusercontent.com/71196912/153767963-dcc51971-0a05-40e3-84f4-0870dc4fcbde.png">

Informative Keybinds, Native Fuzzy Finding, and fast file history using [nvim-telescope](https://github.com/nvim-telescope/telescope.nvim), [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim), [telescope-frecency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim), [sqlite.lua](https://github.com/tami5/sqlite.lua) and [which-key.nvim](https://github.com/folke/which-key.nvim)

<img width="1350" alt="which-key" src="https://user-images.githubusercontent.com/71196912/153768853-7e87a72a-0fff-4416-a63e-6252cd85b3a1.png">

https://user-images.githubusercontent.com/71196912/153768858-7b3cd304-03ba-4958-b0d6-c743ebb4642b.mov

## Install

### Dependencies

The only dependencies are `neovim-nightly` and `git`.

### Regular:

Install the following dependencies: 
- neovim-nightly (or neovim stable)
- ripgrep
- nodejs (optional, for copilot)
- fennel + fnlfmt (not required, but recommended)
- font with nerdfont icons 

```bash
git clone --depth 1 https://github.com/shaunsingh/nyoom.nvim.git ~/.config/nvim 
nvim
```

Then run `:PackerSync`

### Using nix: 

Requires nix version > 21.11, with experimental features `flakes` and `nix-commands` enabled
```bash
git clone --depth 1 https://github.com/shaunsingh/nyoom.nvim.git && cd nyoom.nvim
nix develop
```

Then run `nvim` as usual, and `:PackerSync` to update/install plugins

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

### Learning Fennel

For most people, chances are you haven't even heard of fennel before. So where should you start?
1. Read through the [Documentation](https://fennel-lang.org/)
2. [Install fennel](https://fennel-lang.org/setup#downloading-fennel) yourself! (Skip the part where it goes over adding fennel support to your editor, thats what this project is for :p)
3. [Learn lua](https://fennel-lang.org/lua-primer) first. I recommend reading through the [Neovim lua guide](https://github.com/nanotee/nvim-lua-guide) as well.
4. [Learn fennel](https://fennel-lang.org/tutorial)
5. Go over the [Style guide](https://fennel-lang.org/style).
6. [Learn macros](https://fennel-lang.org/macros). 

If you have trouble configuring neovim to your needs, check out [Antifennel](https://fennel-lang.org/see) to see how lua code compiles back to fennel! However, the generated code isn't always the cleanest, so its recommend you use it as a last resort. If you need any help, feel free to reach out to me via email or discord, and be sure to join the [Conjure Discord](https://conjure.fun/discord) too! 

### Aniseed vs Hotpot

- Aniseed: Aniseed bridges the gap between Fennel and Neovim, Allowing you to easily write plugins or configuration in a Clojure-like Lisp with great runtime performance. As opposed to hotpot, aniseed provides macros, is slightly faster and more featureful, compiles fennel files to the lua/ directory, and has better integration with conjure. It aims to provide a more clojure-like experience, and behaves as a superset of fennel.

- Hotpot: Hotpot will transparently compile your Fennel code into Lua and then return the compiled module. Future calls to `require` (including in future Neovim sessions) will skip the compile step unless it's stale. Only compiles and caches fennel files, providing a more native experience for the user. On the other hand, it is slightly slower and less developed. Users looking for macros can use the builtin macros defined in macros.fnl, or the zest.nvim library.

In `init.lua`, you can set the compiler to aniseed/hotpot, and nyoom will handle the rest. All the current configuration is hotpot-compatible, so it doesn't use any aniseed macros by default. However, you are free to use them yourself. 

## Notes

If you have an issue with a plugin in Nyoom.nvim, first you should report it to Nyoom.nvim to see if it's an issue with it. Please don't bother package maintainers with issues that are caused by my configs, and vice versa. I'm new to fennel, so don't hesitate to tell me my lisp-fu sucks! 

