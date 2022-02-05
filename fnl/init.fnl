(module init {require-macros [macros] autoload {c aniseed.compile}})

; call global settings
(require :au)
(require :config)
(require :maps)

((. (require :packer) :startup) {1 (fn [use]
                                     ;; bootstrap stuff
                                     (package! :wbthomason/packer.nvim) ; plugin manager
                                     (package! :Olical/aniseed
                                               {:branch :develop})
                                     ; fennel environment
                                     (package! :lewis6991/impatient.nvim) ; faster loading
                                     ;; fennel dev
                                     (package! {1 :Olical/conjure
                                                :branch :develop
                                                :config (fn []
                                                          (require :plug/conjure))})
                                     ;; navigation
                                     (package! {1 :nvim-telescope/telescope.nvim
                                                :requires :nvim-lua/plenary.nvim})
                                     ;; treesitter
                                     (package! {1 :nvim-treesitter/nvim-treesitter
                                                :run ":TSUpdate"
                                                :config (fn []
                                                          (require :plug/treesitter))})
                                     ; tree-sitter main plugin
                                     (package! {1 :p00f/nvim-ts-rainbow
                                                :config (fn []
                                                          (require :plug/rainbow_con))})
                                     ; color matching brackets
                                     (package! {1 :romgrk/nvim-treesitter-context
                                                :config (fn []
                                                          (require :plug/treesitter-context_con))})
                                     ; enhanced colors for embedded languages
                                     ;; lsp
                                     (package! :github/copilot.vim)
                                     (package! {1 :neovim/nvim-lspconfig
                                                :requires :williamboman/nvim-lsp-installer
                                                :config (fn []
                                                          (require :plug/lspconfig_con))})

                                     ;; aesthetics
                                     (package! {1 :RRethy/nvim-base16
                                                :config (fn []
                                                          (require :plug/base16))})
                                     (package! {1 :nvim-lualine/lualine.nvim
                                                :config (fn []
                                                          (require :plug/lualine_con))})
                                     ;; notes
                                     (package! {1 :nvim-neorg/neorg
                                                :config (fn []
                                                          (require :plug/neorg_con))
                                                :requires :nvim-lua/plenary.nvim}))
                                 :config {:display {:open_fn (. (require :packer.util)
                                                                :float)}
                                          :compile_path (.. (vim.fn.stdpath :config)
                                                            :/lua/packer_compiled.lua)}})
