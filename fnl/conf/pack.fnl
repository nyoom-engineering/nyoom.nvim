(import-macros {: pack : use-package! : unpack! : cmd} :conf.macros)

;; Setup packer
(local packer (require :packer))
(packer.init {:autoremove true                                                   ;; no need to keep old plugins round
              :compile_path (.. (vim.fn.stdpath :config)                         ;; storing packer_compiled under lua/ caches it
                                :/lua/packer_compiled.lua)
              :git {:clone_timeout 300}                                          ;; longer timeout for larger plugins 
              :display {:open_fn (lambda open_fn []                              ;; pretty borders
                                   (local {: float} (require :packer.util))
                                   (float {:border :solid}))}
              :profile {:enable true}})                                          ;; builtin lua startup profiler

;; There are some plugins we only want to load for lisps. Heres a list of lispy filetypes I use
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

;; Bootstrap nessecary plugins
(use-package! :wbthomason/packer.nvim)                                           ;; manage my packages please
(use-package! :lewis6991/impatient.nvim)                                         ;; cache lua and make things fast
(use-package! :nvim-lua/plenary.nvim {:module :plenary})                         ;; and make async much easier

;; lispy configs
(use-package! :Olical/conjure
              {:branch :develop
               :ft lisp-ft
               :requires [(pack :gpanders/nvim-parinfer {:ft lisp-ft})
                          (match fennel_compiler
                            :aniseed (pack :Olical/aniseed {:branch :develop})
                            :hotpot (pack :rktjmp/hotpot.nvim {:branch :master})
                            :tangerine (pack :udayvir-singh/tangerine.nvim))]})

;; language specific plugins
(use-package! :gpanders/nvim-parinfer {:ft lisp-ft})                             ;; ((((lisp) is) scary) fun)
(use-package! :Olical/conjure {:branch :develop :ft lisp-ft})                    ;; evaluate code emacs style
(use-package! :simrat39/rust-tools.nvim {:ft :rust :init :rust-tools})           ;; rust my beloved

;; File navigation
(use-package! :kyazdani42/nvim-tree.lua {:config! :nvimtree})                    ;; for all your filetree needs
(use-package! :nvim-lua/telescope.nvim {:cmd :Telescope :config! :telescope})    ;; and fuzzy it up a bit 

;; tree-sitter
(use-package! :nvim-treesitter/nvim-treesitter                                   ;; syntax and highlighting sitting in a tree
              {:run ":TSUpdate"
               :config! :treesitter
               :requires [(pack :p00f/nvim-ts-rainbow)                           ;; lonely parens need some color
                          (pack :nvim-treesitter/playground                      ;; ... so they can play around a bit
                                {:cmd :TSPlayground})]})

;; lsp
(use-package! :neovim/nvim-lspconfig                                             ;; fidgety lsp
              {:config! :lsp
               :requires [(pack :j-hui/fidget.nvim {:after :nvim-lspconfig :init :fidget})
                          (pack :williamboman/nvim-lsp-installer {:module :nvim-lsp-installer})]})

(use-package! :folke/trouble.nvim                                                ;; but those errors bring trouble!
              {:cmd :Trouble
               :config (fn []
                         (local {: setup} (require :trouble))
                         (setup {:icons false}))})

;; git
(use-package! :TimUntersberger/neogit {:init :neogit :cmd :Neogit})              ;; I love magit

;; completion/copilot
(use-package! :zbirenbaum/copilot.lua                                            ;; write code for me thank you
              {:event :InsertEnter
               :config (fn []
                         (vim.schedule (fn []
                                         ((. (require :copilot)
                                             :setup)))))})

(use-package! :hrsh7th/nvim-cmp                                                  ;; completions are fun
              {:config! :cmp
               :event [:InsertEnter]
               :requires [(pack :hrsh7th/cmp-path {:after :nvim-cmp})            ;; so many files
                          (pack :hrsh7th/cmp-buffer {:after :nvim-cmp})          ;; so much content 
                          (pack :ray-x/cmp-treesitter {:after :nvim-cmp})        ;; so many trees
                          (pack :hrsh7th/cmp-nvim-lua {:after :nvim-cmp})        ;; so much lua
                          (pack :PaterJason/cmp-conjure {:after :nvim-cmp})      ;; so much lisp
                          (pack :hrsh7th/cmp-nvim-lsp {:module :cmp_nvim_lsp})   ;; so much lsp
                          (pack :zbirenbaum/copilot-cmp {:after :copilot.lua})   ;; so mcuh copilot
                          (pack :lukas-reineke/cmp-under-comparator {:module :cmp-under-comparator})]}) 

;; aesthetics
(use-package! :RRethy/nvim-base16 {:config! :base16})                            ;; pretty colors
(use-package! :Pocco81/TrueZen.nvim {:cmd :TZAtaraxis :config! :truezen})        ;; nice and minimal
(use-package! :norcalli/nvim-colorizer.lua {:config! :colorizer :event :BufRead});; color up my buffers
(use-package! :rcarriga/nvim-notify                                              ;; pretty notifications
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
(use-package! :nvim-neorg/neorg {:config! :neorg :ft :norg :after :nvim-treesitter})

;; fun!
(use-package! :iagoleal/doctor.nvim {:cmd :TalkToTheDoctor})                     ;; please see a real doctor
(use-package! :alec-gibson/nvim-tetris {:cmd :Tetris})                           ;; or just tetris away your sorrows

;; At the end of the file, the unpack! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(unpack!)
