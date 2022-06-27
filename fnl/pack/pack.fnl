(require-macros :macros.package-macros)

;; Setup packer
(local {: init} (require :packer))
(init {:autoremove true
              :git {:clone_timeout 300}
              :profile {:enable true}
              :compile_path (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")
              :display {:header_lines 2
                        :title " packer.nvim"
                        :open_fn (λ open_fn []
                                   (local {: float} (require :packer.util))
                                   (float {:border :solid}))}})

;; There are some plugins we only want to load for lisps. Heres a list of lispy filetypes I use
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

(local lsp_cmds [:LspInfo
                 :LspStart
                 :LspRestart
                 :LspStop
                 :LspInstall
                 :LspUnInstall
                 :LspUnInstallAll
                 :LspInstall
                 :LspInstallInfo
                 :LspInstallLog
                 :LspLog
                 :LspPrintInstalled])

(local treesitter_cmds [:TSInstall
                        :TSBufEnable
                        :TSBufDisable
                        :TSEnable
                        :TSDisable
                        :TSModuleInhfo])

;; testing

;; Packer can manage itself
(use-package! :wbthomason/packer.nvim)

;; Mapping and Documentation
(use-package! :folke/which-key.nvim {:config (call-setup :which-key)})

;; lispy configs
(use-package! :rktjmp/hotpot.nvim {:branch :nightly})
(use-package! :eraserhd/parinfer-rust {:opt true :run "cargo build --release"})
(use-package! :Olical/conjure {:branch :develop
                               :ft lisp-ft
                               :config (tset vim.g "conjure#extract#tree_sitter#enabled" true)})

;; File navigation
(use-package! :kyazdani42/nvim-tree.lua {:cmd :NvimTreeToggle :config (load-file :nvimtree)})
(use-package! :nvim-lua/telescope.nvim
              {:config (load-file :telescope)
               :cmd :Telescope
               :requires [(pack :nvim-lua/plenary.nvim {:module :plenary})
                          (pack :nvim-telescope/telescope-project.nvim
                                {:module :telescope._extensions.project})
                          (pack :nvim-telescope/telescope-fzf-native.nvim
                                {:module :telescope._extensions.fzf
                                 :run :make})]})
;; tree-sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:run ":TSUpdate"
               :cmd treesitter_cmds
               :event [:BufRead :BufNewFile]
               :config (load-file :treesitter)
               :requires [(pack :nvim-treesitter/playground {:cmd :TSPlayground})
                          (pack :p00f/nvim-ts-rainbow {:after :nvim-treesitter})
                          (pack :nvim-treesitter/nvim-treesitter-refactor {:after :nvim-treesitter})
                          (pack :nvim-treesitter/nvim-treesitter-textobjects {:after :nvim-treesitter})]})

;; lsp
(use-package! :ray-x/lsp_signature.nvim {:module :lsp_signature})
(use-package! :nvim-lua/lsp_extensions.nvim {:after :nvim-lsp-installer})
(use-package! :folke/trouble.nvim {:cmd :Trouble :module :trouble :config (call-setup :trouble)})
(use-package! :j-hui/fidget.nvim {:after :nvim-lspconfig :config (call-setup :fidget)})
(use-package! :williamboman/nvim-lsp-installer {:opt true
                                                :cmd lsp_cmds
                                                :setup (fn []
                                                         ((. (require :utils.lazy-load)
                                                             :load-on-file-open!) :nvim-lsp-installer))})

(use-package! :neovim/nvim-lspconfig {:after :nvim-lsp-installer
                                      :module :lspconfig
                                      :config (fn []
                                                (require :pack.lspinstall)
                                                (require :pack.lsp))}) 

;; git
(use-package! :TimUntersberger/neogit {:config (call-setup :neogit) :cmd :Neogit})
(use-package! :lewis6991/gitsigns.nvim {:opt true
                                        :config (call-setup :gitsigns)
                                        :setup (fn []
                                                 ((. (require :utils.lazy-load)
                                                     :load-gitsigns)))})

;; completion/copilot
(use-package! :zbirenbaum/copilot.lua
              {:event :InsertEnter})

(use-package! :hrsh7th/nvim-cmp
              {:config (load-file :cmp)
               :wants :LuaSnip
               :event :InsertEnter
               :requires [(pack :hrsh7th/cmp-path {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-buffer {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-nvim-lsp {:after :nvim-cmp})
                          (pack :PaterJason/cmp-conjure {:after :conjure})
                          (pack :saadparwaiz1/cmp_luasnip {:after :nvim-cmp})
                          (pack :zbirenbaum/copilot-cmp {:after :copilot.lua})
                          (pack :lukas-reineke/cmp-under-comparator {:module :cmp-under-comparator})
                          (pack :L3MON4D3/LuaSnip {:event :InsertEnter
                                                   :wants :friendly-snippets
                                                   :config (load-file :luasnip)
                                                   :requires [(pack :rafamadriz/friendly-snippets)]})]})

;; aesthetics
(use-package! :kyazdani42/nvim-web-devicons {:module :nvim-web-devicons})
(use-package! :Pocco81/TrueZen.nvim {:cmd :TZAtaraxis :config (load-file :truezen)})
(use-package! :monkoose/matchparen.nvim {:opt true
                                         :config (load-file :matchparen)
                                         :setup (fn []
                                                  ((. (require :utils.lazy-load)
                                                      :load-on-file-open!) :matchparen.nvim))})
(use-package! :rcarriga/nvim-notify {:opt true
                                     :setup (fn []
                                              (set vim.notify
                                                   (fn [msg level opts]
                                                     ((. (require :packer) :loader) :nvim-notify)
                                                     (set vim.notify (require :notify))
                                                     (vim.notify msg level opts))))})
(use-package! :akinsho/bufferline.nvim {:opt true
                                        :config (load-file :bufferline) 
                                        :setup (fn []
                                                 ((. (require :utils.lazy-load)
                                                     :load-bufferline)))})
(use-package! :norcalli/nvim-colorizer.lua {:opt true
                                            :config (load-file :colorizer) 
                                            :setup (fn []
                                                     ((. (require :utils.lazy-load)
                                                         :load-colorizer)))})

;; buggy, memory leaks, disabled
;; (use-package! :VonHeikemen/fine-cmdline.nvim {:config (load-file :cmdline) 
;;                                               :requires [(pack :MunifTanjim/nui.nvim)]})

;; Notes: orgmode was previously supported, but its quite buggy and not up to part with emacs. I think neorg is the way to go. 
(use-package! :nvim-neorg/neorg {:config (load-file :neorg) :ft :norg :after :nvim-treesitter})

;; At the end of the file, the unpack! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(unpack!)
