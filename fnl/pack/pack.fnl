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

;; Mapping and Documentation
(use-package! :folke/which-key.nvim {:config (call-setup :which-key)})

;; lispy configs
(use-package! :rktjmp/hotpot.nvim)
(use-package! :Olical/conjure {:branch :develop :ft lisp-ft})
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
               :config (load-file :treesitter)
               :requires [(pack :p00f/nvim-ts-rainbow)
                          (pack :nvim-treesitter/nvim-treesitter-textobjects)
                          (pack :nvim-treesitter/playground {:cmd :TSPlayground})]})

;; lsp
(use-package! :neovim/nvim-lspconfig {:config (load-file :lsp)}) 
(use-package! :folke/trouble.nvim {:cmd :Trouble :config (call-setup :trouble)})
(use-package! :ray-x/lsp_signature.nvim {:module :lsp_signature})
(use-package! :j-hui/fidget.nvim {:after :nvim-lspconfig :config (call-setup :fidget)})

;; git
(use-package! :TimUntersberger/neogit {:config (call-setup :neogit) :cmd :Neogit})

;; completion/copilot
(use-package! :zbirenbaum/copilot.lua
              {:event :InsertEnter})

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
                          (pack :zbirenbaum/copilot-cmp {:after :copilot.lua})
                          (pack :lukas-reineke/cmp-under-comparator {:module :cmp-under-comparator})
                          (pack :L3MON4D3/LuaSnip {:event :InsertEnter
                                                   :wants :friendly-snippets
                                                   :config (load-file :luasnip)
                                                   :requires [(pack :rafamadriz/friendly-snippets
                                                                    {:opt false})]})]})

;; aesthetics
(use-package! :rcarriga/nvim-notify {:config (load-file :notify)})
(use-package! :monkoose/matchparen.nvim {:config (load-file :matchparen)})
(use-package! :kyazdani42/nvim-web-devicons {:module :nvim-web-devicons})
(use-package! :Pocco81/TrueZen.nvim {:cmd :TZAtaraxis :config (load-file :truezen)})
(use-package! :akinsho/bufferline.nvim {:event :BufEnter :config (load-file :bufferline)})
(use-package! :norcalli/nvim-colorizer.lua {:config (load-file :colorizer) :event [:BufRead :BufNewFile]})

;; Notes: orgmode was previously supported, but its quite buggy and not up to part with emacs. I think neorg is the way to go. 
(use-package! :nvim-neorg/neorg {:config (load-file :neorg) :ft :norg :after :nvim-treesitter})

;; At the end of the file, the unpack! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(unpack!)










