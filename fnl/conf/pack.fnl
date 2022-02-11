(import-macros {: pack : use-package! : init!} :conf.macros)

;; bootstrap stuff
(use-package! :wbthomason/packer.nvim)
(use-package! :rktjmp/hotpot.nvim)
(use-package! :Olical/conjure {:branch :develop})

;; bindings
(use-package! :folke/which-key.nvim {:init :which-key})

;; completion (note: I don't really like completion, so I just have some paren and comment help for now)
(use-package! :github/copilot.vim)
(use-package! :numToStr/Comment.nvim {:init :Comment})
(use-package! :windwp/nvim-autopairs {:init :nvim-autopairs})

;; navigation
(use-package! :nvim-telescope/telescope.nvim
              {:config! :telescope_con
               :requires [:nvim-lua/popup.nvim
                          :nvim-lua/plenary.nvim
                          :nvim-telescope/telescope-file-browser.nvim
                          :nvim-telescope/telescope-packer.nvim
                          (pack :nvim-telescope/telescope-frecency.nvim
                                {:requires [:tami5/sqlite.lua]})]})

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

;; and send it all to packer
(init!)
