<div align="center">

# Nyoom.nvim

[Install](#install) • [Documentation] • [FAQ] • [Screenshots] • [Contribute](#contribute)

</div>

<div align="center">

[![Fennel](https://img.shields.io/badge/Made%20with%20Fennel-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://fennel-lang.org)
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

Nyoom can be anything you'd like. Enable all the modules for the vscode-alternative in you, remove some and turn it into the prose editor of your dreams, or disable everything and have a nice set of macros to start your configuration from scratch!

At its core, Nyoom consists of a set of intuitive macros, a set of modules, and some opinionated default options, and nothing more.

If you want to jump right into it, see the FAQ page:

Designed against the mantras of doom-emacs [doom-emacs](https://github.com/hlissner/doom-emacs):
+ **Gotta go fast**. Startup and run-time performance are priorities.
+ **Close to metal**. There's less between you and vanilla neovim by design. That's less to grok and less to work around when you tinker. 
+ **Opinionated, but not stubborn**. Nyoom (and Doom) are about reasonable defaults and curated opinions, but use as little or as much of it as you like.
+ **Your system, your rules**. You know better. At least, Nyoom hopes so! There are no external dependencies (apart from rust), and never will be. 

It also aligns with many of Doom's features:
- Minimalistic good looks inspired by modern editors.
- A modular organizational structure for separating concerns in your config. 
- A standard library designed to simplify your fennel bike shedding.
- A declarative package management and module system (inspired by `use-package`, powered by [Packer.nvim](https://github.com/wbthomason/packer.nvim)). Install packages from anywhere, and pin them to any commit.
- A Space(vim)-esque keybinding scheme, centered around leader and localleader prefix keys (SPC and SPCm).
- Project search (and replace) utilities, powered by ripgrep, and telescope.

However, it also disagrees with some of those ideals
- Packages are not pinned to commits *by default*. This configuration is still quite a bit simpler than doom emacs, and breaking changes are usually few and far between.  Of course, you are free to pin packages yourself (and use [:PackerSnapshot](https://github.com/wbthomason/packer.nvim/pull/370)). 

For more info, checkout our (under construction) [FAQ](https://github.com/shaunsingh/nyoom.nvim/blob/master/docs/faq.md)

## Credits

- [David Guevara](https://github.com/datwaft) For getting me into fennel, and for some of his beautiful macros. Without him Nyoom wouldn't exist! 
- [Oliver Caldwell](https://github.com/Olical/) For his excellent work on Aniseed, Conjure, and making fennel feel like a first class language in neovim

## Changelog
Moved to [changelog.md](https://github.com/shaunsingh/nyoom.nvim/blob/master/docs/changelog.md)

## Feature Overview
- Fast (avg. 30ms) loading and a declarative package manage system using Nyoom! macros and [Packer.nvim](https://github.com/wbthomason/packer.nvim).
- Lispy editing with [Conjure](https://github.com/Olical/conjure), [Hotpot](https://github.com/rktjmp/hotpot.nvim), and Parinfer.
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

## Prerequisites

- Neovim v0.8.0+ (nightly)
- Cargo/rustc
- Git 

Nyoom works best with a modern terminal with [Truecolor](https://github.com/termstandard/colors) support. Optionally, you can install [Neovide](https://github.com/neovide/neovide) if you'd like a gui. 

Nyoom is comprised of optional modules, some of which may have additional dependencies. Run `:checkhealth` to check for what you may have missed

## Install

### Regular:

Nyoom replaces packer.nvim with a cli, enabling advanced features such as nyoom's module system

```bash
git clone --depth 1 https://github.com/shaunsingh/nyoom.nvim.git ~/.config/nvim 
cd ~/.config/nvim/
bin/nyoom install 
bin/nyoom sync
```

Its recommend you add `~/.config/nvim/bin/nyoom` to your shells `path`


### Using nix: 

(under construction)


## Roadmap

(under construction)

## Notes

If you have an issue with a plugin in Nyoom.nvim, first you should report it here. Please don't bother package maintainers with issues that are caused by my configs, and vice versa. I'm new to fennel, so don't hesitate to let me know my lisp-fu sucks! 

## Contribute
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com) 

Checkout the [Module Guide](https://github.com/shaunsingh/nyoom.nvim/blob/master/docs/modules.md)

+ I love pull requests and bug reports!
+ Don't hesitate to [tell me my lisp-fu
  sucks](https://github.com/shaunsingh/nyoom.nvim/issues/new), but please tell me
  why.
+ Don't see support for your language, or think it should be improved? Feel free to open an issue or PR with your changes.

## Adressing NvChad

Originally, this README stated the following: 

> This config was a response to new configs that pop up, with very abstracted and complex codebases, such as NvChad. They try to be a one-size-fits-all config. NvChad and LunarVim both try to fit as much overall functionality as possible and needlessly lazy load *everything*, when it really isn't needed. Complex codebases lead to less freedom for end-user extensibility. Try forking NvChad and making your own configuration out of it. Everything is tied to the userConfig, and you rely on the maintainer of said code to implement features. 

While this still applies to LunarVIM, and some other configuration, NvChad has changed quite a bit since I wrote this statement. They've done a great job on fixing and cleaning up their lazy-loading, and have made their configuration files easier to read for beginners. Additionally, their new approach to `user-config` is much closer to what you would expect to stock-neovim, and I'd wholeheartedly recommend NvChad as well if you need an easy to use lua config. 
