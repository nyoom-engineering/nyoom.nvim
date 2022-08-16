## Note

The direction of the config is changing a bit, checkout [config.fnl](https://github.com/shaunsingh/nyoom.nvim/tree/main/fnl/config.fnl) for more info on how and why nyoom is changing the way it is, and the roadmap for the future!

# Nyoom.nvim

<div align="center">

[![Fennel](https://img.shields.io/badge/Made%20with%20Fennel-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://fennel-lang.org)
[![Rust](https://img.shields.io/badge/rustc-1.62+-b7410e?style=for-the-badge&logo=rust&logoColor=white)](https://www.rust-lang.org/)

</div>

<div align="center">

[![Stars](https://img.shields.io/github/stars/shaunsingh/nyoom.nvim?color=%23b66467&style=for-the-badge)](https://github.com/shaunsingh/nyoom.nvim/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/shaunsingh/nyoom.nvim?color=%238c977d&style=for-the-badge)](https://github.com/shaunsingh/nyoom.nvim/issues)
[![Forks](https://img.shields.io/github/forks/shaunsingh/nyoom.nvim?color=%23d9bc8c&logoColor=%23151515&style=for-the-badge)](https://github.com/shaunsingh/nyoom.nvim/network/members)
[![License](https://img.shields.io/github/license/shaunsingh/nyoom.nvim?color=%238da3b9&style=for-the-badge)](https://mit-license.org/)

</div>

> These are your father's parentheses.  
> Elegant weapons for a more... civilized age.  
— [xkcd/297](https://xkcd.com/297/)

![nyoombottomtext](https://user-images.githubusercontent.com/71196912/181908773-f7d7a700-d60d-47d2-a3db-3a2bbc6cd1aa.png)

Nyoom.nvim was an answer to abstracted and complex codebases that take away end-user extensibility, try to be a one-size-fits-all config, and needlessly lazy load *everything*. Nyoon.nvim provides a solution to these problems by providing easily readable and easy to work with code in order to make a functioning configuration. The end goal of nyoom.nvim is to be used as a base config for users to extend and add upon, leading to a more unique editing experience. Its relatively small and simple, offers the bare minimum needed plugins to have a powerful config, and is suited to my needs, but can just as easily be suited to yours!

I recommend not to clone and directly install this config, but to fork it, inspect the code, and adjust it to your liking. The best neovim configuration is what *you* make, and this config is only supposed to provide you the tools to do so.

## Credits

- [David Guevara](https://github.com/datwaft) For getting me into fennel, and for some of his beautiful macros. Without him Nyoom wouldn't exist! 
- [Oliver Caldwell](https://github.com/Olical/) For his excellent work on Aniseed, Conjure, and making fennel feel like a first class language in neovim

## Changelog
Moved to [CHANGELOG.md](CHANGELOG.md)

## Feature Overview

- Fast (avg. 30ms) loading and a declarative package manage system using Nyoom! macros and [Packer.nvim](https://github.com/wbthomason/packer.nvim).
- Lispy editing with [Conjure](https://github.com/Olical/conjure), [Hotpot](https://github.com/rktjmp/hotpot.nvim), and [Parinfennel](https://github.com/shaunsingh/nyoom.nvim/tree/main/fnl/parinfer) a custom ffi & vim.json wrapper around [parinfer-rust](https://github.com/eraserhd/parinfer-rust) written in fennel
- An "oxidized" Rust version of the [IBM Carbon](https://carbondesignsystem.com/guidelines/color/overview/#themes) light & dark colorschemes using [Nvim-Oxi](https://github.com/noib3/nvim-oxi)
- Easy to use mappings, motions, and hydras with [Hydra](https://github.com/anuvyklack/hydra.nvim) and [Leap](https://github.com/ggandor/leap.nvim). Don't worry, the heads don't bite!
- Fuzzy file navigation and selections with [Telescope](https://github.com/nvim-telescope/telescope.nvim), [Fzf-Native](https://github.com/nvim-telescope/telescope-fzf-native.nvim), and [Nvim-Tree](https://github.com/kyazdani42/nvim-tree.lua)
- Syntax highlighting, smarter textobjects, distinctive parenthesis, and better refactoring with [Nvim-Treesitter](https://github.com/nvim-treesitter/nvim-treesitter), [Nvim-Ts-Rainbow](https://github.com/p00f/nvim-ts-rainbow) and [Nvim-Treesitter-Textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- Beautiful diagnostics and easy to use lsp with [Mason](https://github.com/williamboman/mason.nvim), [Fidget](https://github.com/j-hui/fidget.nvim), [Trouble](https://github.com/folke/trouble.nvim), [Lsp-Lines](https://git.sr.ht/~whynothugo/lsp_lines.nvim), and [Lspconfig](https://github.com/neovim/nvim-lspconfig)
- Dedicated support for rust tooling and crates.io with [Rust-Tools](https://github.com/simrat39/rust-tools.nvim) and [Crates](https://github.com/Saecki/crates.nvim)
- Featureful emacs-like git integration with [Gitsigns](https://github.com/lewis6991/gitsigns.nvim) and [Neogit](https://github.com/TimUntersberger/neogit)
- Extensible and modular completion and snippet support with [Cmp](https://github.com/hrsh7th/nvim-cmp) and [Luasnip](https://github.com/L3MON4D3/LuaSnip)
- Notetaking with [Neorg](https://github.com/nvim-neorg/neorg)
- Lightweight statusline written in fennel and miscellaneous UI improvements with [Nvim-Notify](https://github.com/rcarriga/nvim-notify), [TrueZen](https://github.com/Pocco81/true-zen.nvim), [Nvim-Colorizer](https://github.com/norcalli/nvim-colorizer.lua), and [Matchparen](https://github.com/monkoose/matchparen.nvim)

## Showcase

https://user-images.githubusercontent.com/71196912/181876431-ebef3a0b-15fc-46dc-b86e-6b1ab240cbdf.mov

## Install

### Dependencies

The only dependencies are `neovim-nightly` (of course), `cargo/rustc` (for the rust modules and parinfer-rust),  and `git`. Optionally, you can install `ripgrep` for `:Telescope live_grep` support and `neovide` for a nice gui.

### Regular:

```bash
git clone --depth 1 https://github.com/shaunsingh/nyoom.nvim.git ~/.config/nvim 
cd ~/.config/nvim/
make hotpot
make compile
nvim
# exit out of neovim
nvim -c 'PackerSync'
```

### Using nix: 

(under construction)

## Design 
Nyoom.nvim is designed against the mantras of [doom-emacs](https://github.com/hlissner/doom-emacs): (shamelessly copy pasted)
- Gotta go fast. Startup and run-time performance are priorities.
- Close to metal. There's less between you and vanilla neovim by design. That's less to grok and less to work around when you tinker.
- Opinionated, but not stubborn. Nyoom (and Doom) are about reasonable defaults and curated opinions, but use as little or as much of it as you like.
- Your system, your rules. You know better. At least, Nyoom hopes so! There are no external dependencies (apart from rust), and never will be. 

It also aligns with many of Doom's features:
- Minimalistic good looks inspired by modern editors.
- A modular organizational structure for separating concerns in your config. 
- A standard library designed to simplify your fennel bike shedding.
- A declarative package management system (inspired by `use-package`, powered by [Packer.nvim](https://github.com/wbthomason/packer.nvim)). Install packages from anywhere, and pin them to any commit.
- A Space(vim)-esque keybinding scheme, centered around leader and localleader prefix keys (SPC and SPCm).
- Project search (and replace) utilities, powered by ripgrep, and telescope.

However, it also disagrees with some of those ideals
- Packages are not pinned to commits *by default*. Unlike Doom, this configuration includes fewer than 20 packages by default and breaking changes are usually few and far between. Everything is rolling release, and if a breaking change does occur I will push a fix within a day (pinky promise!). Of course, you are free to pin packages yourself (and use [:PackerSnapshot](https://github.com/wbthomason/packer.nvim/pull/370)). 

## Why fennel?
Fennel is a programming language that brings together the speed, simplicity, and reach of Lua with the flexibility of a lisp syntax and macro system. Macros are how lisps accomplish metaprogramming. You’ll see a lot of people treat lisp macros with a kind of mystical reverence. While several other languages have macro systems, the power of macros in lisps stem from allowance of lisps to you to write programs using the same notation you use for data structures. Remember: code is data, and we just need to manipulate data.

While people largely over exaggerate the usefulness of macros, there are a few places where macros shine, and configurations are one of them. Utilizing macros, we can essentially create our own syntax. For example, lets take a look at the `set!` macro I've used. `set!` is used for `vim.opt` options. For example, `(set! mouse :a)` expands to `vim.opt["mouse"]="a"`. If a string or number isn't passed to `set!`, it will assume true. e.g. `(set! list)` will expand to `vim.opt["list"]=true`. Similarly if the option starts with no, it will assume false e.g. `(set! noru)` will expand to `vim.opt["ru"]=false`.

With the macros provided, you can configure neovim just as easily, or dare I say easier than you can with Lua or vimscript, while retaining the performance benefits of LuaJIT.

All the magic happens in the `fnl/` folder. Some files to check out:
- `init.fnl`: Same as your init.lua would be, just in fennel! Disables some plugins and loads the core config
- `pack/`: This is where all your plugins go. The `pack.fnl` file is in charge of configuring packer, installing, as well as loading plugins
- `core/defs.fnl`: This is where neovim settings go. 
- `core/maps.fnl`: This is where mappings go. 
- `macros/`: In lisps, macros allow the user to define arbitrary functions that convert certain Lisp forms into different forms before evaluating or compiling them. This folder contains all the macros that I (and a few others, thanks David and Kat!) have written to help you out on your neovim journey. I don't recommend touching this file unless you know what you're doing

### Learning Fennel

For most people, chances are you haven't even heard of fennel before. So where should you start?
1. Read through the [Documentation](https://fennel-lang.org/)
2. [Install fennel](https://fennel-lang.org/setup#downloading-fennel) yourself! (Skip the part where it goes over adding fennel support to your editor, that's what this project is for :p)
3. [Learn lua](https://fennel-lang.org/lua-primer) first. I recommend reading through the [Neovim lua guide](https://github.com/nanotee/nvim-lua-guide) as well.
4. [Learn fennel](https://fennel-lang.org/tutorial)
5. Go over the [Style guide](https://fennel-lang.org/style).
6. [Learn macros](https://fennel-lang.org/macros). 

If you have trouble configuring neovim to your needs, check out [Antifennel](https://fennel-lang.org/see) to see how lua code compiles back to fennel! However, the generated code isn't always the cleanest, so its recommend you use it as a last resort. If you need any help, feel free to reach out to me via email or discord, and be sure to join the [Conjure Discord](https://conjure.fun/discord) too! 

### When Fiddling with Fennel Code

 While fiddling with the config, you can check if the things are not broken yet:
 1. evaluate form you just written (`<localleader>er`, by default `<space>mer`)
 2. evaluate buffer (`<localleader>eb`, by default `<space>meb`)
 3. start another neovim with a vim command: `:!neovim --headless +PlugSync`

## Notes

If you have an issue with a plugin in Nyoom.nvim, first you should report it to Nyoom.nvim to see if it's an issue with it. Please don't bother package maintainers with issues that are caused by my configs, and vice versa. I'm new to fennel, so don't hesitate to let me know my lisp-fu sucks! 

## Adressing NvChad

Originally, this README stated the following: 

> This config was a response to new configs that pop up, with very abstracted and complex codebases, such as NvChad. They try to be a one-size-fits-all config. NvChad and LunarVim both try to fit as much overall functionality as possible and needlessly lazy load *everything*, when it really isn't needed. Complex codebases lead to less freedom for end-user extensibility. Try forking NvChad and making your own configuration out of it. Everything is tied to the userConfig, and you rely on the maintainer of said code to implement features. 

While this still applies to LunarVIM and some other configuration, NvChad has changed quite a bit since I wrote this statement. They've done a great job on fixing and cleaning up their lazy-loading, and have made their configuration files easier to read for beginners. Additionally, their new approach to `user-config` is much closer to what you would expect to stock-neovim, and I'd wholeheartedly recommend NvChad as well if you need an easy to use lua config. 


