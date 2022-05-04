(require-macros :macros.package-macros)

;; Setup packer
(local {: init} (require :packer))
(init {:autoremove true
       :git {:clone_timeout 300}
       :profile {:enable true :threshold 0}
       :compile_path (.. (vim.fn.stdpath :config)
                         :/lua/packer_compiled.lua)
       :display {:header_lines 2
                 :title " packer.nvim"
                 :open_fn (λ open_fn []
                            (local {: float} (require :packer.util))
                            (float {:border :solid}))}})
 

;; There are some plugins we only want to load for lisps. Heres a list of lispy filetypes I use
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

;; Packer can manage itself
(use-package! :wbthomason/packer.nvim)

;; Essential plugins
(use-package! :lewis6991/impatient.nvim)
(use-package! :folke/which-key.nvim {:init :which-key})

;; lispy configs
(use-package! :udayvir-singh/tangerine.nvim)
(use-package! :gpanders/nvim-parinfer {:ft lisp-ft})
(use-package! :Olical/conjure {:branch :develop :ft lisp-ft})

;; File navigation
(use-package! :kyazdani42/nvim-tree.lua {:cmd :NvimTreeToggle :config! :nvimtree})
(use-package! :nvim-lua/telescope.nvim {:cmd :Telescope 
                                        :config! :telescope 
                                        :requires [(pack :nvim-lua/plenary.nvim {:module :plenary})]})

;; tree-sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:run ":TSUpdate"
               :config! :treesitter
               :event [:BufRead :BufNewFile]
               :requires [(pack :p00f/nvim-ts-rainbow {:event [:BufRead :BufNewFile]})
                          (pack :nvim-treesitter/playground {:cmd :TSPlayground})
                          (pack :nvim-treesitter/nvim-treesitter-textobjects {:event [:BufRead :BufNewFile]})]})

;; lsp
(use-package! :neovim/nvim-lspconfig
              {:config! :lsp
               :requires [(pack :j-hui/fidget.nvim {:after :nvim-lspconfig :init :fidget})]})

(use-package! :folke/trouble.nvim
              {:cmd :Trouble
               :config (λ []
                         (local {: setup} (require :trouble))
                         (setup {:icons false}))})

;; git
(use-package! :TimUntersberger/neogit {:init :neogit :cmd :Neogit})

;; completion/copilot
(use-package! :zbirenbaum/copilot.lua
              {:event :InsertEnter
               :config (λ []
                         (vim.schedule (fn []
                                         ((. (require :copilot) :setup)))))})

(use-package! :hrsh7th/nvim-cmp
              {:config! :cmp
               :wants [:LuaSnip]
               :event [:InsertEnter :CmdlineEnter]
               :requires [(pack :hrsh7th/cmp-path {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-buffer {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-cmdline {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-nvim-lsp {:after :nvim-cmp})
                          (pack :onsails/lspkind-nvim {:module :lspkind})
                          (pack :PaterJason/cmp-conjure {:after :conjure})
                          (pack :saadparwaiz1/cmp_luasnip {:after :nvim-cmp})
                          (pack :zbirenbaum/copilot-cmp {:after :copilot.lua})
                          (pack :lukas-reineke/cmp-under-comparator {:module :cmp-under-comparator})
                          (pack :L3MON4D3/LuaSnip {:event :InsertEnter
                                                   :wants :friendly-snippets
                                                   :config! :luasnip
                                                   :requires [(pack :rafamadriz/friendly-snippets
                                                                    {:opt false})]})]})

;; aesthetics
(use-package! :RRethy/nvim-base16 {:config! :base16})
(use-package! :rcarriga/nvim-notify {:config! :notify})
(use-package! :Pocco81/TrueZen.nvim {:cmd :TZAtaraxis :config! :truezen})
(use-package! :norcalli/nvim-colorizer.lua {:config! :colorizer :event [:BufRead :BufNewFile]})

;; Notes: orgmode was previously supported, but its quite buggy and not up to part with emacs. I think neorg is the way to go. 
(use-package! :nvim-neorg/neorg {:config! :neorg :ft :norg :after :nvim-treesitter})

;; At the end of the file, the unpack! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(unpack!)
