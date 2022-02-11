(import-macros {: pack : use-package! : init!} :conf.macros)

;; Emacs' use-package is not a package manager! Although use-package does have the useful capability to interface with package managers, its mainly for configuring and loading packages. 
;; Still, as packer.nvim is use-package inspired, lets just think of it as a vim-y version of straight-use-package for now :)

;; The syntax is simple:
;; (use-package! <repo-name> {:keyword :arg ...} ...)
;; Please refer to :h packer.nvim for more information.

;; Bootstrap essential plugins
(use-package! :wbthomason/packer.nvim)

;; One catch to the use-package! macro: It doesn't obey code. It will get sent to packer whether its in an if/else statement or not. To work around this, we can add aniseed/hotpot as requirements for the conjure package, then use the pack macro to load them instead
(use-package! :Olical/conjure {:branch :develop
                               :requires [(if (= fennel_compiler :aniseed)
                                              (do
                                                (pack :Olical/aniseed {:branch :develop}))
                                              (= fennel_compiler :hotpot)
                                              (do
                                                (pack :rktjmp/hotpot.nvim)))]})

;; optimizations
(use-package! :lewis6991/impatient.nvim)
(use-package! :tweekmonster/startuptime.vim {:cmd :StartupTime})

;; lispy configs
;; This config also introduces :init and :config! keywords. 

;; :init! is used to initialize any package which as the form require("<name>").setup
;; e.g. (use-package! :folke/which-key.nvim {:init :which-key}) expands to use({config = "require('which-key').setup()", "folke/which-key.nvim"})
;; :config! is used to load a configuration file for a package, from the pack/ directory.
;; e.g. (use-package! :nvim-telescope/telescope.nvim {:config! :telescope_con}) will load the file telescope_con.fnl in the pack/ directory.

;; bindings
(use-package! :folke/which-key.nvim {:init :which-key})

;; completion (note: I don't really like completion, so I just have some paren and comment help for now)
(use-package! :github/copilot.vim)
(use-package! :numToStr/Comment.nvim {:init :Comment})
(use-package! :windwp/nvim-autopairs {:init :nvim-autopairs})

;; Lastly, you can use the pack macro to create package declarations within a use-package! block.
;; e.g. (use-package! :nvim-telescope/telescope.nvim {:requires [(pack :nvim-telescope/telescope-frecency.nvim {:requires [:tami5/sqlite.lua]})]}) will create a package declaration for telescope-frecency.nvim, which requires sqlite.

;; navigation
(use-package! :nvim-telescope/telescope.nvim
              {:cmd :Telescope
               :config! :telescope_con
               :requires [:nvim-lua/popup.nvim
                          :nvim-lua/plenary.nvim
                          :nvim-telescope/telescope-file-browser.nvim
                          :nvim-telescope/telescope-packer.nvim
                          (pack :nvim-telescope/telescope-frecency.nvim
                                {:requires [:tami5/sqlite.lua]})
                          (pack :nvim-telescope/telescope-fzf-native.nvim
                                {:run :make})]})

;; tree-sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:config! :treesitter
               :requires [:p00f/nvim-ts-rainbow
                          (pack :nvim-treesitter/playground
                                {:cmd :TSPlayground})]})

;; lsp
(use-package! :neovim/nvim-lspconfig
              {:config! :lspconfig_con
               :requires :williamboman/nvim-lsp-installer})
(use-package! :folke/trouble.nvim {:cmd :Trouble
                                   :config (fn []
                                             (local {: setup} (require :trouble))
                                             (setup {:icons false}))})

;; aesthetics
(use-package! :RRethy/nvim-base16 {:config! :base16})
(use-package! :lewis6991/gitsigns.nvim {:config! :gitsigns_con})
(use-package! :Pocco81/TrueZen.nvim {:cmd :TZAtaraxis :config! :truezen_con})
(use-package! :kevinhwang91/nvim-hlslens {:confg! :hlslens_con})

;; notifications
(use-package! :rcarriga/nvim-notify
              {:config (fn []
                         (set vim.notify (require :notify))
                         (local {: setup} (require :notify))
                         (setup {:stages :slide
                                 :timeout 2500
                                 :minimum_width 50
                                 :icons {:ERROR ""
                                         :WARN ""
                                         :INFO ""
                                         :DEBUG ""
                                         :TRACE "✎"}}))})

;; notes
(use-package! :nvim-neorg/neorg
              {:requires :nvim-lua/plenary.nvim :config! :neorg_con})

;; At the end of the file, the init! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(init!)
