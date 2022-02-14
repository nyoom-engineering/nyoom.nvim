(import-macros {: use-package! : pack : rock : rock!} :conf.macros)

;;; Emacs' use-package is not a package manager! Although use-package does have the useful capability to interface with package managers, its mainly for configuring and loading packages.
;;; Still, as packer.nvim is use-package inspired, lets just think of it as a vim-y version of straight-use-package for now :)

;;; The syntax is simple:
;;; (use-package! <repo-name> {:keyword :arg ...} ...)
;;; Please refer to :h packer.nvim for more information. I trust the examples below are enough to get you started.

;;; One catch to the use-package! macro: It doesn't obey whats around it, whatever package declaration you create gets directly added to the global conf/pack list. To work around this, we can add aniseed/hotpot as requirements for the conjure package, then use the pack macro to load them instead.
;;; You can use the pack macro to create package declarations within a use-package! block.
;;; e.g. (use-package! :nvim-telescope/telescope.nvim {:requires [(pack :nvim-telescope/telescope-frecency.nvim {:requires [:tami5/sqlite.lua]})]}) will create a package declaration for telescope-frecency.nvim, which requires sqlite.

;;; This config also introduces the init! keyword
;;; :init! is used to initialize any package which as the form require("<name>").setup
;;; e.g. (use-package! :folke/which-key.nvim {:init :which-key}) expands to use({config = "require('which-key').setup()", "folke/which-key.nvim"})

;;; Some other notes about the package macros
;;; Packages can be added with use-package! anywhere you please, as they are added to a global list. However, make sure to call packitup! after you have declared all the packages you need to install, as the configuration will ignore everything *after* packitup! is called.
;;; Similar to use-package and pack, there are also the rock and rock! macros for declaring, you guessed it, luarock dependencies. As I don't like external dependencies (and because luarocks is *extremely* finicky on macOS), you don't see it used in this config by default. Feel free to use it yourself though.
;;; rock vs rock!: rock is to rock! as pack is to use-package!

;;; for lazy loading, here is a quick reference of the events you should use.
;;; 1. BufRead (read the contexts of demo.txt into the new buffer)
;;; 2. InsertEnter (swap into Insert mode)
;;; 3. InsertCharPre (swap into Insert mode, right when you press the first input)
;;; you can also lazy load packages on commands (:cmd), filetypes (:ft), and after other plugins (:after).

