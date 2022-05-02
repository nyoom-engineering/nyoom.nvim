(import-macros {: pack : use-package! : unpack! : cmd} :conf.macros)

;; Setup packer
(local packer (require :packer))
(packer.init {:autoremove true
              :compile_path (.. (vim.fn.stdpath :config)
                                :/lua/packer_compiled.lua)
              :git {:clone_timeout 300}
              :display {:open_fn (lambda open_fn []
                                   (local {: float} (require :packer.util))
                                   (float {:border :solid}))}
              :profile {:enable true}})

;; There are some plugins we only want to load for lisps. Heres a list of lispy filetypes I use
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

;; Bootstrap nessecary plugins
(use-package! :wbthomason/packer.nvim)
(use-package! :lewis6991/impatient.nvim)
(use-package! :udayvir-singh/tangerine.nvim)
(use-package! :nvim-lua/plenary.nvim {:module :plenary})

;; language specific plugins 
(use-package! :Olical/conjure {:branch :develop :ft lisp-ft})
(use-package! :simrat39/rust-tools.nvim {:ft :rust 
                                         :init :rust-tools})

;; bindings
(use-package! :folke/which-key.nvim {:init :which-key})

;; Parens
(use-package! :gpanders/nvim-parinfer {:ft lisp-ft})

;; File navigation
(use-package! :kyazdani42/nvim-tree.lua {:config! :nvimtree})
(use-package! :nvim-lua/telescope.nvim {:config! :telescope})

;; tree-sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:run ":TSUpdate"
               :config! :treesitter
               :requires [(pack :p00f/nvim-ts-rainbow)
                          (pack :nvim-treesitter/playground
                                {:cmd :TSPlayground})]})

;; lsp
(use-package! :neovim/nvim-lspconfig
              {:config! :lsp
               :requires [(pack :j-hui/fidget.nvim {:after :nvim-lspconfig :init :fidget})
                          (pack :williamboman/nvim-lsp-installer {:module :nvim-lsp-installer})]})

(use-package! :folke/trouble.nvim
              {:cmd :Trouble
               :config (fn []
                         (local {: setup} (require :trouble))
                         (setup {:icons false}))})

;; git
(use-package! :TimUntersberger/neogit
              {:init :neogit
               :cmd :Neogit})

;; completion/copilot
(use-package! :zbirenbaum/copilot.lua
              {:event :InsertEnter
               :config (fn []
                         (vim.schedule (fn []
                                         ((. (require :copilot)
                                             :setup)))))})

(use-package! :hrsh7th/nvim-cmp
              {:config! :cmp
               :event [:InsertEnter]
               :requires [(pack :hrsh7th/cmp-path {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-buffer {:after :nvim-cmp})
                          (pack :ray-x/cmp-treesitter {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-nvim-lua {:after :nvim-cmp})
                          (pack :PaterJason/cmp-conjure {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-nvim-lsp {:module :cmp_nvim_lsp})
                          (pack :zbirenbaum/copilot-cmp {:after :copilot.lua})
                          (pack :lukas-reineke/cmp-under-comparator {:module :cmp-under-comparator})]})

;; aesthetics
(use-package! :RRethy/nvim-base16 {:config! :base16})
(use-package! :Pocco81/TrueZen.nvim {:cmd :TZAtaraxis :config! :truezen})
(use-package! :norcalli/nvim-colorizer.lua {:config! :colorizer :event :BufRead})
(use-package! :folke/twilight.nvim {:init :twilight})
(use-package! :rcarriga/nvim-notify
              {:config (fn []
                         (set vim.notify (require :notify))
                         (local {: setup} (require :notify))
                         (setup {:stages :fade_in_slide_out
                                 :fps 60
                                 :icons {:ERROR ""
                                         :WARN ""
                                         :INFO ""
                                         :DEBUG ""
                                         :TRACE "✎"}}))})

;; Notes: orgmode was previously supported, but its quite buggy and not up to part with emacs. I think neorg is the way to go. 
(use-package! :nvim-neorg/neorg {:config! :neorg 
                                 :ft :norg 
                                 :after :nvim-treesitter})

;; fun!
(use-package! :iagoleal/doctor.nvim {:cmd :TalkToTheDoctor})
(use-package! :alec-gibson/nvim-tetris {:cmd :Tetris})

;; At the end of the file, the unpack! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(unpack!)
