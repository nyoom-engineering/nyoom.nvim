# Nyoom Module Guide

Want to contribute a module to nyoom? Heres an overview of the module syntax, the types of modules, how to create a module, and style guidelines!

## What is a Nyoom module?

Non-core functionality in nyoom is broken into modules: sets of configurations that users can enable or disable. Modules can be enabled and disabled in `fnl/modules.fnl`, and will be compiled and installed when you run `nyoom sync`. 

Modules are sorted into categories:
- completion: These modules provide interfaces and frameworks completion, including code completion.
- ui: For modules concerned with changing Neovims' appearance or providing interfaces for its features, like statuslines, tabs, or fonts.
- editor: For modules concerned with the insertion and editing of text.
- term: The modules in this category bring (or enhance) varying degrees of terminal emulation into Neovim.
- checkers: For modules dedicated to linting plain text (primarily code and prose).
- tools: Modules that integrate external tools into Emacs.
- lang: These modules specialize in integration particular languages and their ecosystems into Nyoom
- config: Modules in this category provide sane defaults or improve your ability to configure Emacs.

If you have a module but don't know where it goes, feel free to reach out for help.

## How do Nyoom modules work?

Before you create modules, its also important to know *how* Nyoom's module system works:
1. Modules are defined in init.fnl files, either through the `:nyoom-module` key in `use-package!` or through the standalone separate `nyoom-module!` macro.
2. Users enable/disable these modules through the `nyoom!` macro in `modules.fnl`
3. When `nyoom sync` is run, the contents of `init.fnl` files in the users enabled modules are compiled and inline-required into `packages.lua` (the compiled/cached version of `packages.fnl`).
4. Each enabled module is checked for an optional `config.fnl`. If a config file is found, hotpot compiles it. Compiling these files ahead of time ensures that conditionally enabled code (code wrapped in `nyoom-module-p!`) is correctly compiled, as the `_G.nyoom/modules` table containing the list of modules is cleared after `packages.fnl` has been compiled
5. Packer.nvim installs and compiles all packages/modules into a `packer_compiled.lua` file.

## How can I create a Nyoom module?

Now we can get into making nyoom modules. There are four types of modules
1. Package modules: These just install and configure packages. These modules have an `init.fnl` file, but no `config.fnl` file
2. Package-Config modules: These modules contain both packages, as well non-default configurations for those packages and/or integrations with other modules. These modules have both an `init.fnl` and `config.fnl` file
3. Configuration-Only modules: These modules don't contain any packages. They contain configuration or extra code. They have both a `init.fnl` and `config.fnl` file. You won't be dealing with these very often
4. Shim modules: These modules have a blank `init.fnl` file and thats it. Usually these modules are `lang.*` modules. Instead of containing configuration, enabling these modules enables integrations within other modules (e.g. format, lsp, completion, mason)

Determine which category (editor, tools, completion, etc.) your module falls under and what type (package, package-config, config-only, shim) it is.

Add your module to the list of `modules.fnl`. Modules are put in their respective categories, and are sorted alphabetically. Modules are named as following: `<category>.<nameofmodule>`. Its also recommend you put a comment next to your module which either explains what the module does, or serves as a funny tagline.

Create your module folder under `fnl/modules/<category>/<nameofmodule>/init.fnl`. E.g. the `tools.tree-sitter` module would be under `fnl/modules/tools/tree-sitter/init.fnl`

## Creating a Package module

In your `init.fnl` file, put the following. The `use-package!` statement follows the same syntax as the one in `packages.fnl`

```fennel
(import-macros {: use-package!} :macros)

(use-package! :nameofpackage {:whateverconfigurationyouwant})
```

## Creating a Package-Config module

Here we have two options. If you would like to load your module when `:nameofpackage` is loaded:

```fennel
(import-macros {: use-package!} :macros)

(use-package! :nameofpackage {:nyoom-module <category>.<nameofmodule>
                              :whateverconfigurationyouwant})
```

E.x. for `tools.tree-sitter`

```fennel
(import-macros {: use-package!} :macros)

(use-package! :nvim-treesitter/nvim-treesitter {:nyoom-module tools.tree-sitter})
```

If you would like to load `tools.tree-sitter.config` independently of when `nvim-treesitter` is loaded:

```fennel
(import-macros {: nyoom-module!} :macros)

(nyoom-module! tools.tree-sitter)

(use-package! :nvim-treesitter/nvim-treesitter {:whateverconfigurationyouwant})
```

Either of these will load `fnl/modules/tools/tree-sitter/config.fnl`. Inside config.fnl you can also use the `nyoom-module-p!` macro, which compiles code conditionally only if the requested module is enabled. See `tools.mason` or `macros.fnl` for sample usage.

### Creating a Configuration-Only module

Put the following in your modules `init.fnl`:

```fennel
(import-macros {: nyoom-module!} :macros)

(nyoom-module! <category>.<modulename>)
```

This will load `fnl/modules/<catagory>/<modulename>/config.fnl` on Nyoom's startup

### Creating a Shim module

For Shim modules, you can just create `fnl/modules/<catagory>/<modulename>/init.fnl` and leave it empty

## Module flags 

Nyoom also supports adding flags to modules. With flags you can gate extra features that relate to a module, but aren't needed in the main modules and don't fit anywhere else. Flags are just modules within modules, named after the flag.

For example, the `default` module has a `+bindings` flag, as you can see in `modules.fnl`. It looks like this
```fennel
(nyoom! :config
        (default +bindings))
```

The code for that modules is stored under `fnl/modules/config/default/+bindings`, and it is loaded and/or configured the same as any other module

## Adding support for a language

You're likely here because you want to add support for a language. For most languages you can use a Shim module, unless you need language-specific plugins (e.g. rust-tools). 

For this guide, replace `langname` with the language you'd like to add

1. Add `lang.langname` to `modules.fnl`.
2. Create `fnl/modules/lang/langname/init.fnl`
3. Use `nyoom-module-p!` to add support for your language's parsers to `tools.tree-sitter`
4. Use `nyoom-module-p!` to add support for your language's language server to `tools.lsp`
5. (optional) Use `nyoom-module-p!` to add support for formatting to `editor.format` if available
6. (optional) Use `nyoom-module-p!` to add support for linting to `checkers.synatx`
7. (optional) Use `nyoom-module-p!` to add debugging support to `tools.debugger`
8. (recommended) If available, add the newly configured tooling to mason in `tools.mason`
9. (optional) Add any language-specific plugins to `fnl/modules/lang/langmane/init.fnl`
