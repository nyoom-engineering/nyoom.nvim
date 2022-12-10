<div align="center">

# Nyoom.nvim

</div>

<div align="center">

[![Fennel](https://img.shields.io/badge/Made%20with%20Fennel-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://fennel-lang.org)
[![Stars](https://img.shields.io/github/stars/nyoom-engineering/nyoom.nvim?color=%23b66467&style=for-the-badge)](https://github.com/nyoom-engineering/nyoom.nvim/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/nyoom-engineering/nyoom.nvim?color=%238c977d&style=for-the-badge)](https://github.com/nyoom-engineering/nyoom.nvim/issues)
[![Forks](https://img.shields.io/github/forks/nyoom-engineering/nyoom.nvim?color=%23d9bc8c&logoColor=%23151515&style=for-the-badge)](https://github.com/nyoom-engineering/nyoom.nvim/network/members)
[![License](https://img.shields.io/github/license/nyoom-engineering/nyoom.nvim?color=%238da3b9&style=for-the-badge)](https://mit-license.org/)
![Discord Server](https://img.shields.io/discord/1050624267592663050?color=738adb&label=Discord&Color=white&style=for-the-badge)

</div>

> These are your father's parentheses.  
> Elegant weapons for a more... civilized age.  
— [xkcd/297](https://xkcd.com/297/)

![merged](https://user-images.githubusercontent.com/71196912/206819620-af569a8f-87ad-4b27-b08c-01bb547fa570.png)

Nyoom.nvim was an answer to abstracted and complex codebases that take away end-user extensibility, try to be a one-size-fits-all config, and needlessly lazy load *everything*. It solves this problem by providing a set of well integrated modules similar to doom-emacs. Modules contain curated plugins and configurations that work together to provide a unified look and feel across all of Nyoom. The end goal of nyoom.nvim is to be used as a framework config for users to extend and add upon, leading to a more unique editing experience.

Nyoom can be anything you'd like. Enable all the modules for the vscode-alternative in you, remove some and turn it into the prose editor of your dreams, or disable everything and have a nice set of macros to start your configuration from scratch!

At its core, Nyoom consists of a set of intuitive macros, a nice standard library, a set of modules, and some opinionated default options, and nothing more.

Designed against the mantras of doom-emacs [doom-emacs](https://github.com/hlissner/doom-emacs):

+ **Gotta go fast**. Startup and run-time performance are priorities.
+ **Close to metal**. There's less between you and vanilla neovim by design. That's less to grok and less to work around when you tinker.
+ **Opinionated, but not stubborn**. Nyoom (and Doom) are about reasonable defaults and curated opinions, but use as little or as much of it as you like.
+ **Your system, your rules**. You know better. At least, Nyoom hopes so! There are no external dependencies (apart from rust), and never will be.
+ **Nix/Guix is a great idea!** The Neovim ecosystem is temperamental. Things
break and they break often. Disaster recovery should be a priority! Nyoom's
package management should be declarative and your private config reproducible,
and comes with a means to roll back releases and updates (still a WIP).

It also aligns with many of Doom's features:
+ Minimalistic good looks inspired by modern editors.
+ A modular organizational structure for separating concerns in your config.
+ A standard library designed to simplify your fennel bike shedding.
+ A declarative package management and module system (inspired by `use-package`, powered by [Packer.nvim](https://github.com/wbthomason/packer.nvim)). Install packages from anywhere, and pin them to any commit.
+ A Space(vim)-esque keybinding scheme, centered around leader and localleader prefix keys (SPC and SPCm).
+ Project search (and replace) utilities, powered by ripgrep, and telescope.
+ Per-file indentation style detection and [editorconfig] integration. Let
someone else argue about tabs vs *spaces*
+ Support for modern tooling and navigation through language-servers, null-ls, and tree-sitter.

For more info, checkout our (under construction) [FAQ](https://github.com/nyoom-engineering/nyoom.nvim/blob/master/docs/faq.md)

## Prerequisites

+ Neovim v0.8.0+
+ Git
+ Ripgrep 11.0+

Nyoom works best with a modern terminal with [Truecolor](https://github.com/termstandard/colors) support. Optionally, you can install [Neovide](https://github.com/neovide/neovide) if you'd like a gui.

Nyoom is comprised of optional [modules](https://github.com/nyoom-engineering/nyoom.nvim/blob/master/docs/modules.md), some of which may have additional dependencies. Run `:checkhealth` to check for what you may have missed.

## Install

```bash
git clone --depth 1 https://github.com/nyoom-engineering/nyoom.nvim.git ~/.config/nvim 
cd ~/.config/nvim/
bin/nyoom install 
bin/nyoom sync
```
Then read [getting started](https://github.com/nyoom-engineering/nyoom.nvim/blob/master/docs/getting_started.md) to be walked through
installing, configuring and maintaining Nyoom Nvim.

It's a good idea to add `~/.config/nvim/bin` to your `PATH`! Other `bin/nyoom`
commands you should know about:

+ `nyoom sync` to synchronize your private config with Nyoom by installing missing
packages, removing orphaned packages, and regenerating caches. Run this
whenever you modify your `packages.fnl` and `modules.fnl`
+ `nyoom upgrade` to update Nyoom to the latest release
+ `nyoom lock` to dump a snapshot of your currently installed packages to a lockfile file.

## Getting help
Neovim is no journey of a mere thousand miles. You _will_ run into problems and
mysterious errors. When you do, here are some places you can look for help:

+ [Our Documentation](https://github.com/nyoom-engineering/nyoom.nvim/blob/master/docs/) covers many use cases.
+ The builtin `:help` is your best friend
+ To search available keybinds: `<SPC>fk`
+ Run `:check health` to detect common issues with your development
environment.
+ Search [Nyoom's issue tracker](https://github.com/nyoom-engineering/nyoom.nvim/issues) in case your issue was already
reported.
+ Hop on [our Discord server][https://discord.gg/JcypH4UtYW]; it's active and friendly!

If you have an issue with a plugin in Nyoom.nvim, first you should report it here. Please don't bother package maintainers with issues that are caused by my configs, and vice versa. 

## Roadmap

(under construction)

## Contribute

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

Checkout the [Contributor Guide](https://github.com/nyoom-engineering/nyoom.nvim/blob/master/docs/contributing.md)

+ I love pull requests and bug reports!
+ Don't hesitate to [tell me my lisp-fu
sucks](https://github.com/nyoom-engineering/nyoom.nvim/issues/new), but please tell me
why.
+ Don't see support for your language, or think it should be improved? Feel free to open an issue or PR with your changes.

## Credits

+ [David Guevara](https://github.com/datwaft) For getting me into fennel, and for some of his beautiful macros. Without him Nyoom wouldn't exist!
+ [Oliver Caldwell](https://github.com/Olical/) For his excellent work on Aniseed, Conjure, and making fennel feel like a first class language in neovim


