---
title: Nyoom Modules
description: Overview of Nyoom Module System
author: shaunsingh
categories: docs
created: 2022-11-24
version: 0.1.0
---


# Official Modules

These modules are maintained by the Nyoom team and are considered stable. A good portion of the modules are looked after by me (@shaunsingh), but others are looked over by various contributors. Please feel free to open issues for feature requests or misbehaving modules. If you are experienced with a certain language or tool, feel free to contribute and adopt-a-module today! :tm:


## Maintainers

- @shaunsingh
  Become a maintainer :)


## Installation

Enable a module and/or its flags in `modules.fnl`.


# Module List

## `:app`

Application modules are opinionated transform Neovim toward a specific purpose, often one that is unrelated to text-editing but can be usefull with task management.

### calendar

```
Watch your missed deadlines in real time
```
Provides google calendar integration for vim/neovim.


## `:checkers`

For modules dedicated to linting plain text, primarily code and prose. 

### diagnostics

```
tasing you for every semicolon you forget
```
This module provides syntax checking and error highlighting using `vim.diagnostic`, `vim.lsp`, and `null-ls`.


### grammar

```
tasing grammar mistake every you make
```
This module adds grammar checking to neovim to aid your writing through languagetool.


### spell

```
tasing you for misspelling mispelling
```
This modules provides spellchecking powered by vim's builtin `spell` and `tree-sitter`.


## `:completion`

These modules provide interfaces and frameworks completion, including code completion.

### cmp

```
the ultimate code completion backend
```
This module provides code-completion, powered by nvim-cmp. 


### copilot

```
the code completion of the future
```
This module integrates github/microsoft's copilot program into nvim-cmp.
- requires `nodejs v16-17` and a valid copilot subscription and/or github education account
- requires the `cmp` module


### fzf-lua

```
TODO
```


### telescope +native

```
the search engine of the future
```
This module enhances neovim's search and completion experience through telescope.nvim integration, powered by ripgrep. It also provides a unified fuzzy menu for LSP tasks, file browsing, and `ui-select` tasks.
- requires `ripgrep` for `live_grep` and `grep_string`
- (optional) `ueberzug` for image previews
- (optional) `zoxide` for zoxide integration

#### flags: 

- `+native` adds support for `fzf-native`


## `:config`

Modules in this category provide sane defaults or improve your ability to configure neovim. 

### literate

```
Disguise your config as poor documentation
```
Enables support for literate configurations using `neorg` tangling. A literate config consists of a `fnl/config.norg`. All src blocks within are tangled into `config.fnl` by default. when `$ doom sync` is executed.
- requires the `neorg` module


### default +bindings +smartparens

```
Reasonable defaults for reasonable people
```
This module provides a reasonable set of defaults for neovim.

#### flags: 

- `+bindings` adds a set of doomemacs-inspired bindings for neovim, as well as enhanced vim motions through `leap` and `flit`
- `+smartparens` adds support for easy management of delimiters


## `:editor`

For modules concerned with the insertion and editing of text.

### fold

```
What you can't see won't hurt you
```
This module brings you marker, indent, and syntax-based performant code folding for a variety of languages
- (optional) its recommended to enable the `lsp` module and/or `tree-sitter` modules for more accurate and performant folding. Otherwise falls back to `indent` based folding


### format +onsave

```
Standardize your ugly code
```
This module integrates code formatters into neovim using `null-ls`
- (optional) its recommended to enable the `mason` module to automatically install and manage formatters. However, you can also manage the installation of formatters yourself. If you choose to do so, please reference the documentation of each language module for what binaries to install.

#### flags:

- `+onsave` if available, force formatting of the current buffer when saving.


### mutiple-cursors

```
TODO
```


### parinfer

```
turn lisp into python, sort of
```
Parinfer automatically infers parenthesis matching and indentation alignment, keeping your code balanced and beautiful.
- requires a valid `rust` installation


### hotpot +reflect

```
You take this home, throw it in a pot, add some broth, some neovim... baby, you got a stew going!
```
Hotpot is a fennel compiler plugin for neovim, with a few tricks up its sleeve. Its currently a required plugin for Nyoom to function. 

#### flags:

- `+reflect` provides a repl-like environment for evaluating and inspecting compiled fennel


### scratch

```
emacs-like scratch buffer functionality
```
This module provides a scratch buffer for neovim, allowing you to quickly create a new buffer for temporary notes, code, or anything else. It functions similar to Emacs' scratch functionality, by default providing an environ,ent for evaluating fennel expressions.


### word-wrap

```
language-aware smart soft and hard wrapping
```
This module intelligently wraps long lines in prose buffer without modifying the buffer content.


## `:lang`

These modules specialize in integration particular languages and their ecosystems into (Nyoom) Neovim.

### cc

```
C > C++ == 1
```
This module adds support for the C-family of languages: C, C++, and Objective-C.
- `tools.tree-sitter` Support for the `c` and `cpp` parsers
- `tools.lsp` and `completion.cmp` Off-spec lsp and completion support (`clangd_extensions`)
- `editor.format` Support for formatting through `clang-format`
- `tools.debugger` Support for debugging through `code-lldb`


### clojure

```
Java with a lisp
```
This module adds support for the Clojure(Script) language.
- `tools.tree-sitter` Support for the `clojure` parser
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `clojure-lsp`
- `editor.format` Support for formatting through `zprint`
- `editor.sexp` Support for paredit-like functionality through `vim-sexp`
- `editor.parinfer` Support for smart parenthesis management through the `parinfer` algorithm.
- `tools.eval` Support for interactive evaluation through `tree-sitter` and `conjure`



### common-lisp

```
If you've seen one lisp, you've seen them all
```
This module provides support for Common Lisp. Common Lisp is not a single language but a specification, with many competing compiler implementations. By default, Steel Bank Common Lisp (SBCL) is assumed to be installed, but this can be configured. The `vlime` package is used to provide `SLIME` like functionality
- `tools.tree-sitter` Support for the `commmonlisp` parser
- `completion.cmp` Support for completion through `conjure`
- `editor.sexp` Support for paredit-like functionality through `vim-sexp`
- `editor.parinfer` Support for smart parenthesis management through the `parinfer` algorithm.
- `tools.eval` Support for interactive evaluation through `tree-sitter` and `conjure`


### java

```
The poster child for carpal tunnel syndrome
```
This module adds support for the Java programming language.
- `tools.tree-sitter` Support for the `java` parser
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `jdtls`
- `editor.format` Support for formatting through `google-java-format`
- `tools.debugger` Support for debugging through `jdtls`



### julia

```
A better, faster MATLAB
```
This module adds support for the Julia language.
- `tools.tree-sitter` Support for the `julia` parser
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `julia-lsp`
- `tools.eval` Support for interactive evaluation through `tree-sitter` and `conjure`


### kotlin

```
a better, slicker Java(Script)
```
This module adds support for the Kotlin programming language.
- `tools.tree-sitter` Support for the `kotlin` parser
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `kotlin-language-server`
- `editor.format` Support for formatting through `ktlint`


### LaTeX

```
writing papers in Neovim has never been so fun
```
Provide a helping hand when working with LaTeX documents. Uses `vimtex` to provide tools for compilation, logging, previewing, completion, navigation, package management, motions, and much more
- `tools.tree-sitter` Support for the `latex` parser
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `texlab`
- `ui.hydra` Localleader (`<leader>m`) hydra using `hydra.nvim`


### lua

```
one-based indices? one-based indices
```
This module adds support for the lua programming language, as well as additional support for vim's lua support. 
- `tools.tree-sitter` Support for the `lua` parser
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `lua-language-server`
- `editor.format` Support for formatting through `stylua`
- `tools.debugger` Support for debugging through `one-small-step-for-vimkind`
- `checkers.syntax` Support for linting through `selene`
- `tools.eval` Support for interactive evaluation through `tree-sitter` and `conjure`


### markdown

```
tagline
```
This module adds support for the Markdown markup language.
- `tools.tree-sitter` Support for the `markdown` and `markdown_inline` parsers. Adds support for syntax highlighting of other languages within markdown documents
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `marksman`
- `editor.format` Support for formatting through `markdownlint`
- `checkers.grammar` Support for grammar-checking through `languagetool-rs`


### nim

```
Python + lisp at the speed of C
```
This module adds support for the Nim programming language.
- Support for semantic highlighting, autocomplete, indentation, and language feature using `nvim.nvim`
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `nimlsp`
- `editor.format` Support for formatting through `nimpretty`


### neorg

```
organize your plain life in plain text, the neovim way
```
This module adds support for the Neorg markup language, along with a number of adjustments and reasonable defaults to make it more performant and intuitive out of the box.
- `tools.tree-sitter` Support for the `norg`, `norg_table`, and `norg_meta` parsers
- `completion.cmp` Support for completion through `nvim-cmp`

#### flags: 

- `+pretty` adds prettier bullets, code blocks, and looks to neorg
- `+present` adds support for presentations through `ui.zen`
- `+export` adds support for exporting to markdown
- `+nabla` adds support for previewing LaTeX using `nabla.nvim`


### org

```
organize your plain life in plain text, the emacs way
```
This module adds support for the org markup language, along with a number of adjustments and reasonable defaults to make it more performant and intuitive out of the box.
- `tools.tree-sitter` Support for the `orgmode`parser
- `completion.cmp` Support for completion through `nvim-cmp`

#### flags: 

- `+pretty` adds prettier bullets, code blocks, and looks to org


### nix

```
I hereby declare "nix geht mehr!"
```
This module adds support for the Nix programming language.
- `tools.tree-sitter` Support for the `nix` parser
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `rnix-lsp`
- `editor.format` Support for formatting through `rnix-lsp`


### python

```
beautiful is better than ugly
```
This module adds support for the python programming language.
- `tools.tree-sitter` Support for the `python` parser
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `pyright`
- `editor.format` Support for formatting through `black` and `isort`
- `tools.debugger` Support for debugging through `nvim-dap-python`
- `tools.eval` Support for interactive evaluation through `tree-sitter` and `conjure`


### rust

```
Fe2O3.unwrap().unwrap().unwrap().unwrap()
```
This module adds support for the rust programming language, as well support for its off-spec language server implementation (inlay-hints, etc.) and support for the `crate` package management system.
- `tools.tree-sitter` Support for the `rust` and `toml` parsers
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `rust-analyzer` and `rust-tools.nvim`
- `editor.format` Support for formatting through `rustfmt`
- `tools.debugger` Support for debugging through `codelldb`
- `ui.hydra` Localleader (`<leader>m`) hydra using `hydra.nvim`
- `tools.eval` Support for interactive evaluation through `tree-sitter` and `conjure`


### sh

```
she sells {ba,z,fi}sh shells on the C xor
```
This module adds support for shell scripting languages (including Fish script).
- `tools.tree-sitter` Support for the `bash` parser
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `bash-language-server`
- `editor.format` Support for formatting through `shfmt`

#### flags: 

- `+fish` adds support for the Fish scripting language


### zig

```
C, but simpler
```
This module adds support for the zig programming language.
- `tools.tree-sitter` Support for the `zig` parser
- `tools.lsp` and `completion.cmp` Support for lsp and completion through `zls`
- `editor.format` Support for formatting through `zigfmt`


## `:term`

What’s an operating system without a terminal? The modules in this category bring varying degrees of terminal emulation into Neovim.

### fshell

```
the fennel shell that works everywhere
```
Implementation of eshell-esque shell in neovim. Functions as a fennel-repl unless passed a shell command, where it functions as a rudimentary terminal emulator/


### toggleterm

```
persistant/floating terminal wrapper for :term
```
Enhances builtin terminal by providing sensible bindings and window management.


## `:tools`

Modules that integrate external tools into Emacs.

### debugger

```
Step through code to help you add bugs
```
Introduces a code debugger to Emacs, powered by nvim-dap/


### docker

```
row row row your boat
```
This module allows you to manipulate Docker images, containers, and more from neovim.


### editorconfig

```
let someone else argue about tabs vs spaces
```
This module integrates EditorConfig into neovim, allowing users to dictate code style on a per-project basis with an .editorconfig file.


### magma

```
tame Jupyter notebooks
```
This module integrates Jupyter Notebooks into neovim, allowing users to edit and execute code interactively with a python instance.
- requires `python3.8+` as well as the following python packages: 
    - `pynvim` to connect python with neovim
    - `jupyter_client` to interact with jupyter
    - (optional) `ueberzug` and `Pillow` for image display
    - (optional) `cairosvg` for svg display
    - (optional) `pnglatex` for TeX display
    - (optional) `plotly` and `kaleido` for displaying plotly figures


### mason

```
setting your tools in stone
```
This module integrates Mason.nvim into neovim, allowing for the automatic installation of enabled modules' tooling (language-servers, linters, formatters, debuggers) through the `nyoom sync` cli. 


### eval

```
Run code, run (also, repls)
```
This module adds support for the interactive evaluation of lisps and languages through `tree-sitter`, and provides completion for a variety of lispy languages
- (optional) its recommended to enable the `tree-sitter` module for more accurate parsing and evaluation, as well as support for non-lisp languages. Otherwise falls back to `regex` based parsing. 
- requires the following external tools:
    - Clojure: Either install the Clojure Cli Tools or `leiningen`. Conjure also supports `babashka` as well as ClojureScript through `shadow-cljs`
    - Common-lisp: `roswell`
    - Julia: A working `julia` installation
    - Python: A working `python3` installation
    - Rust: `excvr`
    - (optional) Fennel: You can install `fennel` if you would like to execute fennel over stdio. By default the fennel execution will use neovim's builtin luajit interpretor


### antifennel

```
for all of the fennel haters out there
```
This module integrates the `antifennel` script into neovim, allowing users to transpile lua code into fennel, as well as save it to clipboard.


### pastebin

```
interacting with pastebin platforms
```
This module integrates pastebin platforms into neovim. By default it uses `paste.rs`.


### lsp

```
:vscode 
```
This module provides integration and a sensible set of default configurations for the language-server implementation of neovim. It also provides linting and formatting through `null-ls`. 
- requires: run `:checkhealth` to check for missing server executables. You can also use `tools.mason` to automatically install servers.


### neogit +forge +diffview

```
a git porclain for neovim
```
This module integrates Neogit, an intuitive interface to the Git version control system.
- requires a working `git` installation

#### flags: 

- `+forge` adds support for interacting (manging issues, pull-requests, labels) with git forges, e.g. github
- `+diffview` adds an intuitive interface to manage diffs and merging from within neovim.


### rgb

```
Creating color strings
```
Highlights color hex values and names with the color itself, and provides tools to easily modify color values or formats.


### tree-sitter

```
syntax and parsing, sitting in a tree...
```
This module configures adds a sensible set of defaults for neovim's tree-sitter integration. Tree-sitter provides improved syntax highlighting, quick parsing of code, as well as improved code navigation. Provides the following improvements:
- Installs parsers for enabled `lang.*` modules
- Enables quick syntax highlighting
- Enables improved indentation and code folding (`editor.fold`)
- Adds support for "rainbow parenthesis"
- Adds support for incremental selection and improved textobjects
- Adds support for interactive evaluatino of non-lisp languages (`tools.eval`)
- Adds support for improved vim motions with `leap-ast` 


## `:ui`

For modules concerned with changing Neovim’s appearance or providing interfaces for its features, like sidebars, tabs, or fonts.

### nyoom +modes +icons

```
what makes Nyoom look the way it does
```
This module gives Nyoom its signature look: powered by the oxocarbon theme. It also configures listchars/fillchars, as well as provides a hydra for easy UI configuration

#### flags: 

- `+modes` adds support for prismatic line decorations visualizing your current vim mode
- `+icons` adds support for material icons using `nvim-web-devicons`


### dashboard

```
a nifty splash screen for neovim
```
This module adds a minimalistic, Atom-inspired dashboard to neovim.
- `+startuptime` displays the time taken to start nyoom on your dashboard. In order to work, `nvim` needs to be alised to `nvim --startuptime /tmp/nvim-startuptime`


### nyoom-quit

Implementation of `doom-quit` for neovim


### hydra

```
Discount modality for mythological beast hunters
```
Adds a neovim implementation of the famous Emacs Hydra package, as well as a few default hydras to interface with git, files, lsp, and vim's options and looks.


### indent-guides

```
highlighted indent columns
```
Provides a visual  representation of the indentation of your code, using the `indent-blankline` plugin. Best works with `tools.tree-sitter` enabled.


### modeline

```
snazzy, nano-emacs-inspired modeline
```
This module provides a minimal modeline inspired by nano-emacs, as well as a winbar-esque header using `incline.nvim`. Has the following providers: 
- `modes`
- `filetype`
- `bufnr`
- `fileinfo`
- `searchcount`
- `vc` - powered by `ui.vc-gutter`
- `diagnostics` - powered by `tools.lsp` and `checkers.syntax`


### nvimtree

```
a project drawer, like NERDTree for vim
```
This module brings a side panel for browsing project files, inspired by vim’s NERDTree.


### tabs 

```
keep tabs on your buffers, literally
```
This module adds an Atom-esque tab bar to the Neovim UI.


### vc-gutter

```
Get your diff out of the gutter
```
This module displays a diff of the current file (against HEAD) in the fringe. Supports Git, Svn, Hg, and Bzr.


### window-select

```
Visually switch windows
```
This module provides several methods for selecting windows without the use of the mouse or spatial navigation


### zen

```
Distraction-free mode for the eternally distracted
```
This module uses `truezen` to turn neovim into a more comfortable writing or coding environment. Folks familiar with “distraction-free” or “zen” modes from other editors will feel right at home.


### noice

```
noice ui
```
This module uses `noice.nvim` to improve neovim's UI, notifications, cmdline, search, and lsp progress handler.