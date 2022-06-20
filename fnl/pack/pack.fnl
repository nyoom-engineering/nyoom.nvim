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
(local lisp-ft [:fennel :clojure :lisp])

;; Packer can manage itself
(use-package! :wbthomason/packer.nvim)

;; Mapping and Documentation
(use-package! :folke/which-key.nvim {:config (load-file :which-key)})

;; Navigation
(use-package! :ggandor/lightspeed.nvim)
;; Terminal
;; (use-package! :hkupty/nvimux {:config (call-setup :nvimux)})
(use-package! :voldikss/vim-floaterm)
(use-package! :kevinhwang91/promise-async)
(use-package! :kevinhwang91/nvim-ufo
              {:config (load-file :ufo)
               :require [(pack :kevinhwang91/promise-async)]})
(use-package! :windwp/nvim-autopairs {:config (call-setup :nvim-autopairs)})
(use-package! :tpope/vim-surround)
(use-package! :numToStr/Comment.nvim {:config (call-setup :Comment)})
(use-package! :akinsho/toggleterm.nvim {:config (load-file :toggleterm)})
(use-package! :jose-elias-alvarez/null-ls.nvim {:config (load-file :null-ls)})
(use-package! :lukas-reineke/indent-blankline.nvim {:config (load-file :indent-blankline)})
(use-package! :luukvbaal/nnn.nvim {:config (load-file :nnn)})
(use-package! :pwntester/octo.nvim
              {:config (call-setup :octo)
               :requires [(pack :nvim-lua/plenary.nvim)
                          (pack :nvim-telescope/telescope.nvim)
                          (pack :kyazdani42/nvim-web-devicons)]})

;; lispy configs
(use-package! :Olical/conjure
              {:branch :develop
               :ft lisp-ft
               :config (tset vim.g "conjure#extract#tree_sitter#enabled" true)
               :requires [(match fennel_compiler
                             :hotpot (pack :rktjmp/hotpot.nvim {:branch :master})
                             :aniseed (pack :Olica/aniseed {:branch :develop :requires [(pack :lewis6991/impatient.nvim)]})
                             :tangerine (pack :udayvir-singh/tangerine.nvim {:requires [(pack :lewis6991/impatient.nvim)]}))]})

(use-package! :eraserhd/parinfer-rust {:opt true :run "cargo build --release"})

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
               :event [:BufRead :BufNewFile]
               :config (load-file :treesitter)
               :requires [(pack :nvim-treesitter/playground {:cmd :TSPlayground})
                          (pack :p00f/nvim-ts-rainbow {:after :nvim-treesitter})
                          (pack :nvim-treesitter/nvim-treesitter-textobjects {:after :nvim-treesitter})]})

;; lsp
(use-package! :williamboman/nvim-lsp-installer {:opt true
                                                :setup (defer! :nvim-lsp-installer 0)})

(use-package! :neovim/nvim-lspconfig {:after :nvim-lsp-installer
                                      :module :lspconfig
                                      :config (fn []
                                                (require :pack.lspinstall)
                                                (require :pack.lsp))}) 

(use-package! :ray-x/lsp_signature.nvim {:module :lsp_signature})
(use-package! :folke/trouble.nvim {:cmd :TroubleToggle :config (call-setup :trouble)})
(use-package! :j-hui/fidget.nvim {:after :nvim-lspconfig :config (call-setup :fidget)})

;; git
(use-package! :TimUntersberger/neogit {:config (call-setup :neogit) :cmd :Neogit})
(use-package! :lewis6991/gitsigns.nvim {:opt true :setup (defer! :gitsigns.nvim 0) :config (call-setup :gitsigns)})

;; completion/copilot
;; (use-package! :zbirenbaum/copilot.lua
;;               {:event :InsertEnter})

(use-package! :hrsh7th/nvim-cmp
              {:config (load-file :cmp)
               :wants [:LuaSnip]
               :event [:InsertEnter :CmdlineEnter]
               :requires [(pack :hrsh7th/cmp-path {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-buffer {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-cmdline {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-nvim-lsp {:after :nvim-cmp})
                          (pack :PaterJason/cmp-conjure {:after :conjure})
                          (pack :saadparwaiz1/cmp_luasnip {:after :nvim-cmp})
                          ;; (pack :zbirenbaum/copilot-cmp {:after :copilot.lua})
                          (pack :lukas-reineke/cmp-under-comparator {:module :cmp-under-comparator})
                          (pack :L3MON4D3/LuaSnip {:event :InsertEnter
                                                   :wants :friendly-snippets
                                                   :config (load-file :luasnip)
                                                   :requires [(pack :rafamadriz/friendly-snippets)]})]})

;; aesthetics
(use-package! :kyazdani42/nvim-web-devicons {:module :nvim-web-devicons})
(use-package! :monkoose/matchparen.nvim {:config (load-file :matchparen)})
(use-package! :Pocco81/TrueZen.nvim {:cmd :TZAtaraxis :config (load-file :truezen)})
(use-package! :norcalli/nvim-colorizer.lua {:config (load-file :colorizer) :event [:BufRead :BufNewFile]})

;; Disabled by default, just uncomment them and run :PackerSync if you want
;; (use-package! :akinsho/bufferline.nvim {:event :BufEnter :config (load-file :bufferline)})
;; (use-package! :rcarriga/nvim-notify {:config (load-file :notify)})

;; Notes: orgmode was previously supported, but its quite buggy and not up to part with emacs. I think neorg is the way to go. 
(use-package! :nvim-neorg/neorg {:config (load-file :neorg) :ft :norg :after :nvim-treesitter})

;; At the end of the file, the unpack! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(unpack!)
