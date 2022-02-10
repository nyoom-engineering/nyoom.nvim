(import-macros {: pack : use-package! : init!} :conf.macros)

;; bootstrap stuff
(use-package! :wbthomason/packer.nvim)
(use-package! :rktjmp/hotpot.nvim)
(use-package! :Olical/conjure {:branch :develop})

;; jk/jj for escape
(use-package! :max397574/better-escape.nvim
              {:event :InsertCharPre
               :config (fn []
                         (local {: setup} (require :better_escape))
                         (setup {:mapping {1 :jk 2 :jj}
                                 :clear_empty_lines true
                                 :keys :<Esc>}))})

;; show bindings
(use-package! :folke/which-key.nvim {:init :which-key})

;; navigation
(use-package! :nvim-telescope/telescope.nvim
              {:config! :telescope_con
               :requires [:nvim-lua/popup.nvim
                          :nvim-lua/plenary.nvim
                          :nvim-telescope/telescope-fzy-native.nvim
                          (pack :nvim-telescope/telescope-smart-history.nvim
                                {:requires [:tami5/sqlite.lua]})]})

;; tree-sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:run :TSUpdate
               :config! :treesitter
               :requires [:p00f/nvim-ts-rainbow
                          (pack :nvim-treesitter/playground
                                {:cmd :TSPlayground})]})

;; lsp
(use-package! :github/copilot.vim)

; copilot completion
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
