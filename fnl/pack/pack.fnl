(require-macros :macros.package-macros)
(import-macros {: cmd!} :macros.command-macros)

;; Load packer from opt
(cmd! packadd packer.nvim)

;; Setup packer
(let [packer (require :packer)]
   (packer.init {:git {:clone_timeout 300}
                 :compile_path (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")
                 :display {:header_lines 2
                           :title " packer.nvim"
                           :open_fn (λ open_fn []
                                      (local {: float} (require :packer.util))
                                      (float {:border :solid}))}}))

;; There are some plugins we only want to load for lisps. Heres a list of lispy filetypes I use
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

(local treesitter-cmds [:TSInstall
                        :TSBufEnable
                        :TSBufDisable
                        :TSEnable
                        :TSDisable
                        :TSModuleInfo])

(local mason-cmds [:Mason
                   :MasonInstall
                   :MasonInstallAll
                   :MasonUninstall
                   :MasonUninstallAll
                   :MasonLog])

;; The package manager can manage itself
(use-package! :wbthomason/packer.nvim {:opt true})

;; Used by quite a few plugins
(use-package! :nvim-lua/plenary.nvim {:module :plenary})

;; profiling
;; (use-package! :stevearc/profile.nvim {:config (load-file profile)})
(use-package! :dstein64/vim-startuptime {:cmd :StartupTime})

;; lispy configs
(use-package! :Olical/conjure {:branch :develop
                               :ft lisp-ft
                               :config (tset vim.g "conjure#extract#tree_sitter#enabled" true)
                               :requires [(pack :eraserhd/parinfer-rust {:opt true :run "cargo build --release"})
                                          (match FENNEL_COMPILER
                                            :aniseed (pack :Olical/aniseed {:branch :develop})
                                            :hotpot (pack :rktjmp/hotpot.nvim {:branch :nightly}))
                                          (match FENNEL_COMPILER
                                            :aniseed (pack :lewis6991/impatient.nvim {:module :impatient}))]})

;; Mappings
(use-package! :anuvyklack/hydra.nvim {:keys :<space> :config (load-file hydras)})
(use-package! :windwp/nvim-autopairs {:event :InsertEnter :config (load-file autopairs)})
(use-package! :ggandor/leap.nvim {:setup (fn []
                                          ((. (require :utils.lazy-load)
                                              :load-on-file-open!) :leap.nvim))
                                  :config (fn []
                                            ((. (require :leap) :set_default_keymaps)))})

;; File navigation
(use-package! :kyazdani42/nvim-tree.lua {:cmd :NvimTreeToggle :config (load-file nvimtree)})
(use-package! :nvim-lua/telescope.nvim
              {:cmd :Telescope
               :config (load-file telescope)
               :requires [(pack :nvim-telescope/telescope-project.nvim
                                {:module :telescope._extensions.project})
                          (pack :nvim-telescope/telescope-ui-select.nvim
                                {:module :telescope._extensions.ui-select})
                          (pack :nvim-telescope/telescope-fzf-native.nvim
                                {:module :telescope._extensions.fzf
                                 :run :make})]})
;; tree-sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:run ":TSUpdate"
               :cmd treesitter_cmds
               :module :nvim-treesitter
               :config (load-file treesitter)
               :setup (fn []
                       ((. (require :utils.lazy-load)
                           :load-on-file-open!) :nvim-treesitter))
               :requires [(pack :nvim-treesitter/playground {:cmd :TSPlayground})
                          (pack :p00f/nvim-ts-rainbow {:after :nvim-treesitter})
                          (pack :nvim-treesitter/nvim-treesitter-textobjects {:after :nvim-treesitter})]})

;; lsp
(use-package! :williamboman/mason.nvim {:cmd mason-cmds :config (load-file mason)})
(use-package! :j-hui/fidget.nvim {:after :nvim-lspconfig :config (call-setup fidget)})
(use-package! :folke/trouble.nvim {:cmd :Trouble :module :trouble :config (call-setup trouble)})
(use-package! "https://git.sr.ht/~whynothugo/lsp_lines.nvim" {:after :nvim-lspconfig :config (call-setup lsp_lines)})
(use-package! :neovim/nvim-lspconfig {:opt true
                                      :setup (fn []
                                              ((. (require :utils.lazy-load)
                                                  :load-on-file-open!) :nvim-lspconfig))
                                      :config (load-file lsp)}) 

;; Language-specific functionality
;; (use-package! :mfussenegger/nvim-jdtls {:ft :java :config (load-lang java)})
(use-package! :saecki/crates.nvim {:event ["BufRead Cargo.toml"] :config (call-setup crates)})
(use-package! :simrat39/rust-tools.nvim {:ft :rust :branch :modularize_and_inlay_rewrite :config (load-lang rust)}) 

;; git
(use-package! :TimUntersberger/neogit {:config (call-setup neogit) :cmd :Neogit})
(use-package! :lewis6991/gitsigns.nvim {:ft :gitcommit
                                        :config (call-setup gitsigns)
                                        :setup (fn []
                                                 ((. (require :utils.lazy-load)
                                                     :load-gitsigns)))})

;; completion
(use-package! :hrsh7th/nvim-cmp
              {:config (load-file cmp)
               :after :cmp-under-comparator
               :requires [(pack :hrsh7th/cmp-path {:after :cmp-buffer})
                          (pack :hrsh7th/cmp-buffer {:after :cmp-nvim-lsp})
                          (pack :hrsh7th/cmp-nvim-lsp {:after :cmp_luasnip})
                          (pack :PaterJason/cmp-conjure {:after :conjure})
                          (pack :saadparwaiz1/cmp_luasnip {:after :LuaSnip})
                          (pack :lukas-reineke/cmp-under-comparator {:module [:cmp :cmp_nvim_lsp] :event :InsertEnter})
                          (pack :L3MON4D3/LuaSnip {:event :InsertEnter
                                                   :wants :friendly-snippets
                                                   :config (load-file luasnip)
                                                   :requires [(pack :rafamadriz/friendly-snippets {:module [:cmp :cmp_nvim_lsp] :event :InsertEnter})]})]})

;; aesthetics
(use-package! :kyazdani42/nvim-web-devicons {:module :nvim-web-devicons})
(use-package! :Pocco81/true-zen.nvim {:cmd :TZAtaraxis :config (load-file truezen)})
(use-package! :shaunsingh/oxocarbon.nvim {:run :./install.sh}) 
(use-package! :rcarriga/nvim-notify {:opt true
                                     :setup (fn []
                                              (set vim.notify
                                                   (fn [msg level opts]
                                                     ((. (require :packer) :loader) :nvim-notify)
                                                     (set vim.notify (require :notify))
                                                     (vim.notify msg level opts))))})
(use-package! :monkoose/matchparen.nvim {:opt true
                                         :config (load-file matchparen)
                                         :setup (fn []
                                                  ((. (require :utils.lazy-load)
                                                      :load-on-file-open!) :matchparen.nvim))})
(use-package! :norcalli/nvim-colorizer.lua {:opt true
                                            :config (load-file colorizer)
                                            :setup (fn []
                                                     ((. (require :utils.lazy-load)
                                                         :load-on-file-open!) :nvim-colorizer.lua))})

;; Notes: orgmode was previously supported, but its quite buggy and not up to part with emacs. I think neorg is the way to go. Feel free to add back org-mode if you want to though!
(use-package! :nvim-neorg/neorg {:config (load-file neorg) :ft :norg :after :nvim-treesitter})

;; At the end of the file, the unpack! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(unpack!)
