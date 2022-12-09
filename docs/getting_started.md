---
title: Getting Started Guide
description: Getting Started with Nyoom Nvim
author: shaunsingh
categories: docs
created: 2022-12-09
version: 0.1.0
---


This guide assumes a basic understanding of programming and fennel. If you haven't already, its recommended to look over [why-fennel](https://github.com/shaunsingh/nyoom.nvim/blob/main/docs/faq.md#why-fennel).

While its possible to use lua for configuration as well, its not officially supported. See [lua-support](https://github.com/shaunsingh/nyoom.nvim/blob/main/docs/getting_started.md#lua-support).

If you have questions about how Nyoom works, why I choose fennel, comparison to other configurations, or other common questions, its recommended to read the [FAQ](https://github.com/shaunsingh/nyoom.nvim/blob/main/docs/faq.md)


# Structure

Nyoom is configured through three files: `config.fnl`, `packages.fnl`, and `modules.fnl`. These files can be found under `~/.config/nvim/fnl/` and under `~/.config/nyoom`. Feel free to use either location, as both are symlinked and represent the same file. Here's a brief overview of what these files do

**_modules.fnl_**
Where you’ll find your `nyoom!` block, which controls what Nyoom modules are enabled and in what order they will be loaded.
This file is only loaded by Nyoom's Cli, and is not loaded directly by neovim. As such, avoid putting code here unless you know what you're doing

**_config.fnl_**
Here is where 99.99% of your private configuration should go. Anything in here is evaluated before all other modules have loaded, but right after Nyoom's core.

**_packages.fnl_**
Package management is done from this file; where you’ll declare what packages to install and where from


# Modules

A Nyoom module is a bundle of packages, configuration and commands, organized into a unit that can be toggled easily by tweaking your `nyoom!` block (found in `~/.config/nvim/fnl/modules.fnl` or `~/.config/nyoom/modules.fnl`).

If `modules.fnl` doesn’t exist, you haven’t run `nyoom install` yet. See the “Install” section above. Your `nyoom!` block should look something like this:
```fennel
;; To comment something out, you insert at least one semicolon before it and the
;; The interpreter will ignore everything until the end of the line.
(nyoom! :lang
        python        ; this module is not commented, therefore enabled
        ;;javascript  ; this module is commented out, therefore disabled
        ;;lua         ; this module is disabled
        ruby          ; this module is enabled
        php)          ; this module is enabled
```

It controls what modules are enabled and in what order they are loaded. Some modules have optional features that can be enabled by passing them flags, denoted by a plus prefix:
```fennel
(nyoom! :completion
        (telescope +native)
        :lang
        (neorg
          +pretty
          +present
          +export
          +nabla)
        (sh +fish))
``` 

Different modules support different flags. You’ll find a comprehensive list of available modules and their supported flags in Module Index. Flags that a module does not recognize will be silently ignored.
**IMPORTANT:** any changes to your doom! block won’t take effect until you run `nyoom sync` on the command line.



# Packages

Nyoom nvim uses a wrapper around the popular `packer.nvim` to make it feel and function close to emacs' `use-package`. This wrapper also enables features such as Nyoom's lockfile support and advanced scripting.
Packages are declared in the `packages.fnl` file (found under `~/.config/nvim/fnl/packages.fnl` or `~/.config/nyoom/packages.fnl`).


## Installing packages

To install a package with Nyoom you must declare them here and run `nyoom sync` on the command line, then restart nvim for the changes to take effect. The overall syntax matches `packer.nvim` apart from some custom keys. The syntax is as follows: 
```fennel
(use-package! :username/repo {:opt true
                              :defer reponame-to-defer
                              :call-setup pluginname-to-setup
                              :cmd [:cmds :to :lazyload]
                              :event [:events :to :lazyload]
                              :ft [:ft :to :load :on]
                              :requires [(pack :plugin/dependency)]
                              :run :commandtorun
                              :as :nametoloadas
                              :branch :repobranch
                              :setup (fn [])
                              :config (fn [])})
```


## Loading packages

By default packages are loaded automatically. You can either specify `:opt true` (and then use the `packadd!` macro to manually load the packad), or (recommended) you can use one of packer's lazy loading tags


### Manually loading packages

Here is an example of manually loading a package
`packages.fnl`
```fennel
(use-package! :shaunsingh/nord.nvim {:opt true})
```

`config.fnl`
```fennel
(packadd! nord.nvim)
```


### Lazy loading 

As mentioned earlier, its recommended to use packer's lazy-loading keys if you can. These consist of
- `cmd` to load on a vim command
- `event` to load on a vim event
- `ft` to load on a filetype
- `keys` to load on a keymap
- `cond` to conditionally load on a function or string
- `after` to load after another defined plugin
  Nyoom also provides the `:defer` tag, which should be combined with `:opt true` and can accept the name of a plugin to "defer" a plugins loading until after neovim's start. However, this should only be used when nessecary and is best avoided
  Here is an example with `cmd`
```fennel
(use-package! :uga-rosa/ccc.nvim {:cmd [:CccPick
                                        :CccHighlighterEnable
                                        :CccHighlighterToggle]})
```

For further examples its recommended to look at the documentation for `packer.nvim`


## Configuring packages

Its recommended to use `packages.fnl` only for installing packages and use `config.fnl` for configuring them, as its slightly more performant. However, you are free to use the `use-package!` macro for configuring plugins as well. Packer has several keys for configuring plugins, such as
- `config` code to run after a plugin has been loaded. Accepts a function
- `setup` code run before a plugin has loaded. Accepts a function
  A lot of the time neovim plugins will have a `setup()` function you can call. Nyoom adds a `:call-setup` key to the `use-package!` macro that uses its builtin `autoload` functionality to effeciently load plugins

Here is an example of using the `:call-setup` key to configure https://github.com/kevinhwang91/nvim-bqf
The plugin requires you to call the following code
```lua
require('bqf').setup()
```

You can install the plugin and call this function using
```fennel
(use-package! :kevinhwang91/nvim-bqf {:call-setup bqf})
```

Here is an example of using the `:config` key to set up a more advanced configuration
The plugin can be configured through the following lua code
```lua
require('bqf').setup({
  auto_enable = true,
  auto_resize_height = true
})
```

This can be translated to the following
```fennel
(use-package! :kevininhwang91/nvim-bqf 
   {:config (fn []
               (local {: setup} (require :bqf))
               (setup {:auto_enable true :auto_resize_height true}))})
```


## Specifying dependencies

Certain plugins will require depencies to be installed. To do this, you can use the `pack` macro inside the `requires` key. An example is given below with `nvim-ufo`. The `pack` macro accepts all the same arguements a `use-package!` statement does.
```fennel
(use-package! :kevinhwang91/nvim-ufo
              {:after :nvim-treesitter
               :requires [(pack :kevinhwang91/promise-async {:opt true})]})
```


## Additional keys

Packer also has a few additional keys that may be useful
- `disable` can disable a plugin
- `rtp` can add files to runtimpath
- `branch` can specify a specific branch to clone
- `tag` can specify a release tag to clone
- `commit` can specify a commit to clone
  Nyoom also provides the `:nyoom-module` key, used internally to define new modules.


# Config

Your personal configuration will start within `config.fnl`, which can be located at either `~/.config/nvim/fnl/config.fnl` or `~/.config/nyoom/config.fnl`. While its recommended to contain your config within the one file, this file can also `require` or `autoload` files in `~/.config/nvim/fnl/` and `~/.config/nvim/lua`.

The Nyoom config file is loaded after Nyoom's core, but before all of its modules. Nyoom provides a set of macros to aid you in configuring neovim, as well as a "standard library" inspired by aniseed to ease fennel development. For a list of all available macros and functions, please refer to [macro library](https://github.com/shaunsingh/nyoom.nvim/blob/main/docs/macros.md) and [core library](https://github.com/shaunsingh/nyoom.nvim/blob/main/docs/corelib.md).

Your `config.fnl` will already contain some example code to get you started. At the top you will notice three lines
```fennel
(require-macros :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: after} (autoload :core.lib.setup))
```

The first line imports all of nyoom's macros into `config.fnl`. Its recommended to replace this with `import-macros` and import only the macros you need, but you're free to use either format.

The second line imports Nyoom's `autoload` functionality. `autoload` is a drop in replacement for `require` that only loads the `required` table when its absolutely needed. Its recommended to use `autoload` instead of `require` when possible

The third line imports Nyoom's `after` functionality. `after` will be familiar if you've ever used doom's `after!` macro. The `after` function can be used to adjust the configurations of plugins pre-configured by nyoom. 

The rest of the default `config.fnl` is quite straightforward. Please take a look at the additional documentation if you'd like to learn more about nyoom's module system, package management, core library, and macros. Additionally, feel free to reference the [examples](https://github.com/shaunsingh/nyoom.nvim/blob/main/docs/examples.md) if you prefer learning by example. If you still need additional help, feel free to ask the loving community over at our discord server.


## Lua support

While Nyoom is written in Fennel, it also unofficially supports Lua. If you'd like to use Lua, you can delete `config.fnl`, create a `config.lua` file in `~/.config/nvim/lua/`, and optionally symlink it to `~/.config/nyoom. Nyoom will automatically load this file in place of `config.fnl` if it exists. Keep in mind that while support for lua will be provided, nyoom will always be written with fennel in mind. This may mean certain functionality will not work with lua-based configs in the future.

You may use `antifennel` to aid in converting code from fennel to lua and vice versa

Here is the example `config.fnl` adapted to lua:
```lua
-- macros are not supported in lua
-- load provide functions
local autoload = require("core.lib.autoload")["autoload"]
local after = autoload("core.lib.setup")["after"]

-- set colorscheme through `vim.cmd`
vim.cmd.colorschme "carbon"

-- set options through `vim.opt`
vim.opt.number = false

-- set global variables
vim.g.maplocalleader = " m"

-- set mapping
vim.keymap.set({"n"}, "<esc>", "<esc><cmd>noh<cr>", {desc = "<esc><cmd>noh<cr>"})

-- modify builtin neorg config to load custom neorg directory
after("neorg", {load = {["core.norg.dirman"] = {config = {workspaces = {main = "~/neorg"}}}}}) 
```

