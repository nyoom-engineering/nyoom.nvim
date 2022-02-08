(module init {require-macros [macros] autoload {c aniseed.compile}})

; call global settings
(require :au)
(require :config)
(require :maps)

(opt- packer startup {1 (fn [use]
                          ;; bootstrap stuff
                          (use-package :wbthomason/packer.nvim) ; package manager
                          (use-package :lewis6991/impatient.nvim) ; faster loading
                          (use-package {1 :tweekmonster/startuptime.vim
                                     :cmd :StartupTime}) ; profiling
                          (use-package {1 :Olical/aniseed
                                     :branch :develop})
                          ;; keybindings
                          (use-package {1 :max397574/better-escape.nvim
                                     :event :InsertCharPre
                                     :config (fn []
                                               (opt- better_escape setup {:mapping {1 :jk
                                                                                    2 :jj}
                                                                          :clear_empty_lines true
                                                                          :keys :<Esc>}))})
                          (use-package {1 :folke/which-key.nvim
                                     ;; :keys :<space>
                                     :config (fn []
                                               (opt- which-key setup {}))})
                          ;; fennel dev
                          (use-package {1 :Olical/conjure
                                     :branch :develop
                                     :config (fn []
                                               (require :plug/conjure))})
                          ;; navigation
                          ; buffer/fuzzy navigation
                          (use-package {1 :nvim-telescope/telescope.nvim
                                     :requires :nvim-lua/plenary.nvim})
                          ; faster vim motions
                          (use-package {1 :ggandor/lightspeed.nvim
                                     :config (fn []
                                               (opt- lightspeed setup {}))})
                          ;; treesitter
                          ; tree-sitter main plugin
                          (use-package {1 :nvim-treesitter/nvim-treesitter
                                     :run ":TSUpdate"
                                     :config (fn []
                                               (require :plug/treesitter))})
                          ; color matching brackets
                          (use-package {1 :p00f/nvim-ts-rainbow
                                     :after :nvim-treesitter
                                     :config (fn []
                                               (require :plug/rainbow_con))})
                          ; enhanced colors for embedded languages
                          (use-package {1 :romgrk/nvim-treesitter-context
                                     :after :nvim-treesitter
                                     :config (fn []
                                               (require :plug/treesitter-context_con))})
                          (use-package {1 :nvim-treesitter/playground 
                                     :cmd :TSPlayground})

                          ;; lsp
                          ; copilot completion
                          (use-package :github/copilot.vim)
                          ; actual lsp
                          (use-package {1 :neovim/nvim-lspconfig
                                     :requires :williamboman/nvim-lsp-installer
                                     :config (fn []
                                               (require :plug/lspconfig_con))})
                          ; diagnostics
                          (use-package {1 :folke/trouble.nvim
                                     :cmd :Trouble
                                     :config (fn []
                                               (opt- trouble setup {}))})
                          ;; aesthetics
                          ; colorscheme
                          (use-package {1 :RRethy/nvim-base16
                                     :config (fn []
                                               (require :plug/base16))})
                          ; git modifications
                          (use-package {1 :lewis6991/gitsigns.nvim
                                     :config (fn []
                                               (require :plug/gitsigns_con))})
                          ; statusline
                          (use-package {1 :nvim-lualine/lualine.nvim
                                     :config (fn []
                                               (require :plug/lualine_con))})
                          ; minimalism
                          (use-package {1 :Pocco81/TrueZen.nvim
                                     :cmd {1 :TZAtaraxis 2 :TZMinimalist 3 :TZFocus}
                                     :config (fn []
                                               (require :plug/truezen_con))}) 
                          ; focus
                          (use-package {1 :folke/twilight.nvim
                                     :cmd {1 :Twilight 2 :TwilightEnable}
                                     :config (fn []
                                               (opt- twilight setup {}))})
                          ; notifications
                          (use-package {1 :rcarriga/nvim-notify
                                     :config (fn []
                                               (set vim.notify (require :notify))
                                               (opt- notify setup {:stages :slide
                                                                              :timeout 2500
                                                                              :minimum_width 50
                                                                              :icons {:ERROR ""
                                                                                      :WARN ""
                                                                                      :INFO ""
                                                                                      :DEBUG ""
                                                                                      :TRACE "✎"}}))})
                          ;; notes
                          (use-package {1 :nvim-neorg/neorg
                                     :config (fn []
                                               (require :plug/neorg_con))
                                     :requires :nvim-lua/plenary.nvim}))
                      :config {:display {:open_fn (. (require :packer.util)
                                                     :float)}
                               :compile_path (.. (vim.fn.stdpath :config)
                                                 :/lua/packer_compiled.lua)}})
