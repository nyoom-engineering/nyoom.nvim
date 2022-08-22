# Frequently Asked Questions

# General

This is the section for questions on how Nyoom works, is it for you, how does it compare to other configurations, and how can you get started.

## Is Nyoom for me?

If you don't mind tinkering with lisps, and don't want to start entirely from scratch, then of course! However, if you prefer something that is truly *yours*, don't mind a little boilerplate here and there, or don't like fennel, checkout some other configurations!

### How does Nyoom compare to (insert premade configuration)

(wip)

- http://neovimcraft.com/plugin/siduck76/NvChad/index.html

- http://neovimcraft.com/plugin/LunarVim/LunarVim/index.html

- http://neovimcraft.com/plugin/NTBBloodbath/doom-nvim/index.html

## How does Nyoom work?

Nyoom has four parts: 
1. Core configuration
2. Macros
3. Package management 
4. User Configuration

First and foremost is the core configuration. Located in the `fnl/core` folder, Nyoom's core contains a set of opinionated defaults for neovim. It optimizes startup, loads compiled modules, user configurations, and loads essential functionality that makes Nyoom work.

Second are the Macros. To keep it brief, macros allow fennel, Nyoom, and its users to manipulate code as data. This allows us to simplify syntax and add features to neovim, while still keeping everything feeling natural. If you want more of an in-depth dive, you can checkout the "Why fennel?" section below.

Third is the package management. While Nyoom wraps Packer.nvim, similar to how doom-emacs wraps straight.el and use-package, it adds quite a few features and changes its core functionality. 

Nyoom adds additional keys to `Packer.nvim` to make it easier to configure packages: 
```fennel
(use-package! :repo/test {:defer packer.nvim
                          :call-setup test
                          :nyoom-module tools.test})
```
The `use-package!` macro simplifies the fennel syntax for `use`, while also keeping track of what packages have been requested, enabling us to spread our package statements across different files. 

The `:defer` keyword works similarly to the keyword of the same name in `straight-use-package`. It defers the startup of a plugin until after startup, unless a file argument is passed to neovim

The `:call-setup` keyword sets up a plugin with its default settings

Finally, the `:nyoom-module` keyword declares a Nyoom.nvim "config module", i.e. a module that requires extra configuration. For example `:nyoom-module tools.tree-sitter` will tell Nyoom to load `modules.tools.tree-sitter.config.fnl` as well, and log that it's loaded.

Additionally, your plugins are dealt with in advance. Plugins & modules are collected ahead of time through the nyoom cli. Through a set of compile-time macros, Nyoom conditionally compiles parts of these modules only for what you need. 

For example, here's a section from `tools.treesitter`:

```fennel
(import-macros {: nyoom-module-p!} :macros)

(local treesitter-filetypes [:comment
                             :help
                             :fennel
                             :lua])

(nyoom-module-p! neorg
  (do
    (local tsp (require :nvim-treesitter.parsers))
    (local parser-config (tsp.get_parser_configs))
    (set parser-config.norg {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg"
                                            :files [:src/parser.c :src/scanner.cc]
                                            :branch :main}})
    (set parser-config.norg_meta
         {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
                         :files [:src/parser.c]
                         :branch :main}})
    (set parser-config.norg_table
         {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
                         :files [:src/parser.c]
                         :branch :main}})
    (table.insert treesitter-filetypes :norg)
    (table.insert treesitter-filetypes :norg_table)
    (table.insert treesitter-filetypes :norg_meta)))
```

If you've enabled `lang.neorg`, that compiles to the following: 
```lua
local treesitter_filetypes = {"comment", "help", "fennel", "lua"}
do
  local tsp = require("nvim-treesitter.parsers")
  local parser_config = tsp.get_parser_configs()
  parser_config.norg = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg", files = {"src/parser.c", "src/scanner.cc"}, branch = "main"}}
  parser_config.norg_meta = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg-meta", files = {"src/parser.c"}, branch = "main"}}
  parser_config.norg_table = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg-table", files = {"src/parser.c"}, branch = "main"}}
  table.insert(treesitter_filetypes, "norg")
  table.insert(treesitter_filetypes, "norg_table")
  table.insert(treesitter_filetypes, "norg_meta")
end
```

When you disable `lang.neorg`. that compiles to just this:
```lua
local treesitter_filetypes = {"comment", "help", "fennel", "lua"}
```

 Another example you disable the `lang.rust` module, Nyoom won't compile the rust-ui for the `ui.hydra` module, won't set up language servers for `tools.lsp` and `tools.mason`, and won't install the tree-sitter parser for the rust language. This structure allows Nyoom to feel just as fast as stock neovim, because in a way it is! The compiled lua code won't contain a trace of rust, anywhere!

 You can check out our [Module Guide](https://github.com/shaunsingh/nyoom.nvim/blob/master/docs/modules.md) for more information on modules and how they work.


### Why is startuptime important?

Of course that lends us to the question. Why go so far to ensure Nyoom starts up quickly? Personally to me runtime performance is a bigger priority, though the two rarely stray far from each other. Each release of Nyoom is heavily profiled to ensure all modules and core code aren't bogging down your workflow

However, when a user first opens up nyoom, the startuptime is the first thing they're greated with. Startuptime adds up quickly. With one or two plugins sure, it only adds a few milliseconds here or there, but add support for debugging, profiling, language servers, and several languages and neovim can easily take multiple seconds to get going.

Users shouldn't be scared of enabling modules. I shouldn't be scared of affecting users by adding more. By ensuring that the core modules and base of Nyoom are loaded and compiled optimally, everything is left in the hands of the user. It’s left to the user to know or care about lazy loading, auto commands, autoloading, and how to implement them in their own configurations, and by all means use the `use-package!` macro to configure your plugins as well, even if its a bit slower than doing it yourself.

By making it easy to properly manage packages, I hope users will have more incentive to keep neatly loaded neovim configurations 

### Why fennel?
Fennel is a programming language that brings together the speed, simplicity, and reach of Lua with the flexibility of a lisp syntax and macro system. Macros are how lisps accomplish metaprogramming. You’ll see a lot of people treat lisp macros with a kind of mystical reverence. While several other languages have macro systems, the power of macros in lisps stem from allowance of lisps to you to write programs using the same notation you use for data structures. Remember: code is data, and we just need to manipulate data.

While people largely exaggerate the usefulness of macros, there are a few places where macros shine, and configurations are one of them. Utilizing macros, we can essentially create our own syntax. For example, lets take a look at the `set!` macro I've used. `set!` is used for `vim.opt` options. For example, `(set! mouse :a)` expands to `vim.opt["mouse"]="a"`. If a string or number isn't passed to `set!`, it will assume true. e.g. `(set! list)` will expand to `vim.opt["list"]=true`. Similarly if the option starts with no, it will assume false e.g. `(set! noru)` will expand to `vim.opt["ru"]=false`. Of course, this is a very simple example and macros can get very, very complex but you get the idea.

With the macros provided, you can configure neovim just as easily, or dare I say easier than you can with Lua or vimscript, while retaining the performance benefits of LuaJIT.

#### Learning Fennel

For most people, chances are you haven't even heard of fennel before. So where should you start?
1. Read through the [Documentation](https://fennel-lang.org/)
2. [Install fennel](https://fennel-lang.org/setup#downloading-fennel) yourself! (Skip the part where it goes over adding fennel support to your editor, that's what this project is for :p). A copy of fennel is provided within neovim through `hotpot.nvim`
3. [Learn lua](https://fennel-lang.org/lua-primer) first. I recommend reading through the [Neovim lua guide](https://github.com/nanotee/nvim-lua-guide) as well.
4. [Learn fennel](https://fennel-lang.org/tutorial)
5. Go over the [Style guide](https://fennel-lang.org/style).
6. [Learn macros](https://fennel-lang.org/macros). 

If you have trouble configuring neovim to your needs, check out [Antifennel](https://fennel-lang.org/see) to see how lua code compiles back to fennel! However, the generated code isn't always the cleanest, so its recommend you use it as a last resort. If you need any help, feel free to reach out to me via email or discord, and be sure to join the [Conjure Discord](https://conjure.fun/discord) too! 

#### When Fiddling with Fennel Code

Feel free to open the Scratch buffer (`:Scratch`) to get a nice working eviornment to start with

While fiddling with the config, you can check if the things are not broken yet:
1. evaluate form you just written (`<localleader>er`, by default `<space>mer`)
2. evaluate buffer (`<localleader>eb`, by default `<space>meb`)
3. live-compile (refelect) your changes with `<leader>hr`

## Why is the project named Nyoom? 

For fun, no major reason really. Also somewhat goes well with the mantras Nyoom lives by.

# How do I ...

This is the section for learning the basics of how to get the most out of Nyoom.

## Update my plugins/modules?

As you've probably noticed, all the main Packer commands such as  `:PackerSync` don't work in Nyoom. Instead, its recommend to use the `nyoom` cli command, a small shell script that lives in `bin/`. Run `bin/nyoom sync` to get everything recompiled, updated, and cached.

## Find out what version of Nyoom I'm running?

`bin/nyoom sync` will also spit out the commit of Nyoom you're using. As Nyoom uses git under the hood, any and all git commands will works just as well.

## Turn Nyoom into an "IDE" ?

Enabling a language module (e.g. `lang.rust`) will do the following: 
1. Install its tree-sitter parser with `tools.tree-sitter`
2. Install its language server with `tools.lsp`
3. Set it up for debugging with `tools.debugger` if available
4. Register it under mason to auto-install with `:Mason` with `tools.mason`
5. Set up a minor GUI with `ui.hydra` if available
6. Install any language-specific plugins (e.g `rust-tools` and `crates.nvim`). 

Currently formatting is only available through language-servers that supply a formatter (e.g. `sumneko_lua`), though `null-ls` support will come at a later date

If you find support for a language lacking, or want to add a plugin/integration to a module, feel free to pull-request or open an issue about it!

## Update Nyoom?

As Nyoom uses git under the hood, simply `git pull`.

## Add packages

Additional packages go in `packages.fnl`, under the `;; User packages` section. You can decide to configure packages through `use-package`, or separately in `config.fnl`. The former is recommended, especially if you want to lazy-load your plugins. 

## Add configuration

As mentioned above, any and all user configuration can go under `config.fnl`. As this is loaded after the core, you can override any of Nyoom's defaults. However, you cannot at the moment override configurations that Nyoom's modules provide. It's recommend in that case you disable the module, and install/configure it yourself

# Contributing

(under construction)






