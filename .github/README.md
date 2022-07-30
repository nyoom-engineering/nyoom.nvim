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


Nyoom.nvim was an answer to abstracted and complex codebases that take away end-user extensibility, try to be a one-size-fits-all config, and needlessly lazy load *everything*. Nyoon.nvim provides a solution to these problems by providing easily readable and easy to work with code in order to make a functioning configuration. The end goal of nyoom.nvim is to be used as a base config for users to extend and add upon, leading to a more unique editing experience. Its relatively small and simple, offers the bare minimum needed plugins to have a powerful config, and is suited to my needs, but can just as easily be suited to yours!

I recommend not to clone and directly install this config, but to fork it, inspect the code, and adjust it to your liking. The best neovim configuration is what *you* make, and this config is only supposed to provide you the tools to do so.

## Credits

- [David Guevara](https://github.com/datwaft) For getting me into fennel, and for some of his beautiful macros. Without him Nyoom wouldn't exist! 
- [Oliver Caldwell](https://github.com/Olical/) For his excellent work on Aniseed, Conjure, and making fennel feel like a first class language in neovim

## Changelog
Moved to [.github/CHANGELOG.md]

## Showcase

Will update soon

## Install

### Dependencies

The only dependencies are `neovim-nightly` (of course), `cargo/rustc` (for the rust modules and parinfer-rust),  and `git`. Optionally, you can install `ripgrep` for `:Telescope live_grep` support.

### Regular:

```bash
git clone --depth 1 https://github.com/shaunsingh/nyoom.nvim.git ~/.config/nvim 
cd ~/.config/nvim/
./install.sh
```

### Using nix: 

Requires nix version > 21.11, with experimental features `flakes` and `nix-commands` enabled
```bash
git clone --depth 1 https://github.com/shaunsingh/nyoom.nvim.git && cd nyoom.nvim
nix develop
```

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

### Why Rust?

I'm sure one of the thousands of rustaceans can tell you all about how excellent rust is. In the context of neovim, I just wanted to try something new. Ideally in the future I'd like to write some of the more performance sensitive parts (e.g. completion) fully in rust.

That and now I can add a rust tag to my repository. Someone told me that gets github stars

## Notes

If you have an issue with a plugin in Nyoom.nvim, first you should report it to Nyoom.nvim to see if it's an issue with it. Please don't bother package maintainers with issues that are caused by my configs, and vice versa. I'm new to fennel, so don't hesitate to let me know my lisp-fu sucks! 

## Adressing NvChad

Originally, this README stated the following: 

> This config was a response to new configs that pop up, with very abstracted and complex codebases, such as NvChad. They try to be a one-size-fits-all config. NvChad and LunarVim both try to fit as much overall functionality as possible and needlessly lazy load *everything*, when it really isn't needed. Complex codebases lead to less freedom for end-user extensibility. Try forking NvChad and making your own configuration out of it. Everything is tied to the userConfig, and you rely on the maintainer of said code to implement features. 

While this still applies to LunarVIM and some other configuration, NvChad has changed quite a bit since I wrote this statement. They've done a great job on fixing and cleaning up their lazy-loading, and have made their configuration files easier to read for beginners. Additionally, their new approach to `user-config` is much closer to what you would expect to stock-neovim, and I'd wholeheartedly recommend NvChad as well if you need an easy to use lua config. 


