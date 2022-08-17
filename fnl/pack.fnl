(import-macros {: packadd! : use-package! : pack : unpack!} :macros)

;; Load packer
(packadd! packer.nvim)

;; Setup packer
(let [packer (require :packer)]
   (packer.init {:git {:clone_timeout 300}
                 :compile_path (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")
                 :display {:header_lines 2
                           :title " packer.nvim"
                           :open_fn (λ open_fn []
                                      (local {: float} (require :packer.util))
                                      (float {:border :solid}))}}))

;; Load Conjure on only the filetypes it supports
(local conjure-ft [:fennel :clojure :lisp :racket :scheme :rust :janet :lua :guile])

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

;; Core
(use-package! :wbthomason/packer.nvim {:opt true})
(use-package! :nvim-lua/plenary.nvim {:module :plenary})

;; profiling
;; (use-package! :stevearc/profile.nvim {:load-file profile})

;; hotpot
(use-package! :rktjmp/hotpot.nvim {:branch :nightly})

;; aniseed
; caches lua bytecode
;; (use-package! :lewis6991/impatient.nvim)
; compiles fennel to lua
;; (use-package! :Olical/aniseed {:branch :develop})

;; lispy
; builds parinfer algorithm binary
(use-package! :eraserhd/parinfer-rust {:opt true 
                                       :run "cargo build --release"})
; interactive lisp evaluation
(use-package! :Olical/conjure {:branch :develop
                               :ft conjure-ft
                               :config (tset vim.g "conjure#extract#tree_sitter#enabled" true)})

;; Mappings
; hydras, for neovim
(use-package! :anuvyklack/hydra.nvim {:load-file hydras
                                      :keys :<space>}) 

; simple autopair plugin
(use-package! :windwp/nvim-autopairs {:load-file autopairs
                                      :event :InsertEnter})
; intuitive motions
(use-package! :ggandor/leap.nvim {:load-file leap}) ;; File navigation
; filetree
(use-package! :kyazdani42/nvim-tree.lua {:load-file nvimtree
                                         :cmd :NvimTreeToggle})
; fuzzy finder
(use-package! :nvim-lua/telescope.nvim
              {:load-file telescope
               :cmd :Telescope
               :requires [(pack :nvim-telescope/telescope-project.nvim      ;; project viewer
                                {:module :telescope._extensions.project})
                          (pack :nvim-telescope/telescope-ui-select.nvim    ;; telescope for ui.select
                                {:module :telescope._extensions.ui-select})
                          (pack :nvim-telescope/telescope-ghq.nvim
                                {:module :telescope._extensions.ghq})
                          (pack :nvim-telescope/telescope-fzf-native.nvim   ;; more performant fuzzy finder 
                                {:module :telescope._extensions.fzf
                                 :run :make})]})
;; tree-sitter
; highlighting/parsing
(use-package! :nvim-treesitter/nvim-treesitter
              {:load-file treesitter
               :cmd treesitter-cmds
               :run ":TSUpdate"
               :requires [(pack :nvim-treesitter/playground {:cmd :TSPlayground})                        ;; view the tree + highlight
                          (pack :p00f/nvim-ts-rainbow {:after :nvim-treesitter})                         ;; rainbow parens!
                          (pack :nvim-treesitter/nvim-treesitter-textobjects {:after :nvim-treesitter})  ;; textobjects
                          (pack :lewis6991/spellsitter.nvim {:call-setup spellsitter                     ;; spellchecking
                                                             :after :nvim-treesitter})]
               :setup (fn []
                        (vim.api.nvim_create_autocmd [:BufRead]
                                 {:group (vim.api.nvim_create_augroup :nvim-treesitter {})
                                  :callback (fn []
                                              (when (fn []
                                                      (local file (vim.fn.expand "%"))
                                                      (and (and (not= file :NvimTree_1)
                                                                (not= file "[packer]"))
                                                           (not= file "")))
                                                (vim.api.nvim_del_augroup_by_name :nvim-treesitter)
                                                ((. (require :packer) :loader) :nvim-treesitter)))}))})

;; lsp
; Install language servers and such
(use-package! :williamboman/mason.nvim {:call-setup mason
                                        :cmd mason-cmds})
; view lsp loading progress
(use-package! :j-hui/fidget.nvim {:call-setup fidget
                                  :after :nvim-lspconfig})
; view diagnostics ala vscode
(use-package! :folke/trouble.nvim {:call-setup trouble
                                   :cmd :Trouble})
; floating diagnostics as lines instead
(use-package! "https://git.sr.ht/~whynothugo/lsp_lines.nvim" {:call-setup lsp_lines
                                                              :after :nvim-lspconfig})
; easy to use configurations for language servers
(use-package! :neovim/nvim-lspconfig {:opt true
                                      :defer nvim-lspconfig
                                      :load-file lsp})

;; Language-specific functionality
; jdtls off-spec support
;; (use-package! :mfussenegger/nvim-jdtls {:ft :java :load-lang java)})
; view rust crate info with virtual text
(use-package! :saecki/crates.nvim {:call-setup crates
                                   :event ["BufRead Cargo.toml"]})

; inlay-hints + lldb + niceties for rust-analyzer
(use-package! :simrat39/rust-tools.nvim {:load-lang rust
                                         :ft :rust}) 

;; git
; Magit for neovim
(use-package! :TimUntersberger/neogit {:call-setup neogit 
                                       :cmd :Neogit})
; git-gutter but better
(use-package! :lewis6991/gitsigns.nvim {:call-setup gitsigns
                                        :ft :gitcommit
                                        :setup (fn []
                                                  (vim.api.nvim_create_autocmd [:BufRead]
                                                           {:callback (fn []
                                                                        (fn onexit [code _]
                                                                          (when (= code 0)
                                                                            (vim.schedule (fn []
                                                                                            ((. (require :packer) :loader) :gitsigns.nvim)))))

                                                                        (local lines
                                                                               (vim.api.nvim_buf_get_lines 0 0 (- 1) false))
                                                                        (when (not= lines [""])
                                                                          (vim.loop.spawn :git
                                                                                          {:args [:ls-files
                                                                                                  :--error-unmatch
                                                                                                  (vim.fn.expand "%:p:h")]}
                                                                                          onexit)))}))})

;; completion
(use-package! :hrsh7th/nvim-cmp
              {:load-file cmp
               :after :friendly-snippets
               :requires [(pack :hrsh7th/cmp-path {:after :cmp-buffer})      ;; path completion
                          (pack :hrsh7th/cmp-buffer {:after :cmp-nvim-lsp})  ;; buffer completion
                          (pack :hrsh7th/cmp-nvim-lsp {:after :cmp_luasnip}) ;; lsp completion
                          (pack :hrsh7th/cmp-cmdline {:after :cmp-nvim-lsp}) ;; cmdline completion
                          (pack :PaterJason/cmp-conjure {:after :conjure})   ;; conjure completion
                          (pack :saadparwaiz1/cmp_luasnip {:after :LuaSnip}) ;; snippet completion
                          (pack :rafamadriz/friendly-snippets {:module [:cmp :cmp_nvim_lsp] :event [:InsertEnter :CmdLineEnter]})
                          (pack :L3MON4D3/LuaSnip {:event [:InsertEnter :CmdLineEnter]
                                                   :wants :friendly-snippets
                                                   :config (fn []
                                                             (local {: lazy_load} (require :luasnip/loaders/from_vscode))
                                                             (lazy_load))})]})

;; aesthetics
; icons for telescope/nvimtree/trouble
(use-package! :kyazdani42/nvim-web-devicons {:module :nvim-web-devicons})
; distraction free writing
(use-package! :Pocco81/true-zen.nvim {:call-setup truezen
                                      :cmd :TZAtaraxis})
; colorscheme
(use-package! :shaunsingh/oxocarbon.nvim {:run :./install.sh})
; show hex codes as virtualtext
(use-package! :brenoprata10/nvim-highlight-colors {:call-setup nvim-highlight-colors 
                                                   :cmd :HighlightColorsToggle})
; lua-based matchparen alternative
(use-package! :monkoose/matchparen.nvim {:opt true
                                         :defer matchparen.nvim
                                         :load-file matchparen})
; replacement for vim.notify
(use-package! :rcarriga/nvim-notify {:opt true
                                     :setup (fn []
                                              (set vim.notify
                                                   (fn [msg level opts]
                                                     ((. (require :packer) :loader) :nvim-notify)
                                                     (set vim.notify (require :notify))
                                                     (vim.notify msg level opts))))})


;; Notes: orgmode was previously supported, but its quite buggy and not up to 
;; part with emacs. I think neorg is the way to go. Feel free to add back 
;; org-mode if you want to though!
(use-package! :nvim-neorg/neorg {:load-file neorg 
                                 :ft :norg 
                                 :after :nvim-treesitter})

;; custom plugin
(use-package! :numToStr/Comment.nvim {:call-setup Comment})
;; (use-package! :luukvbaal/nnn.nvim {:load-file nnn})
(use-package! :akinsho/toggleterm.nvim {:load-file toggleterm})
(use-package! :kylechui/nvim-surround {:load-file nvim-surround})
(use-package! "https://gitlab.com/yorickpeterse/nvim-window.git")
(use-package! :folke/tokyonight.nvim {:load-file tokyonight})

(use-package! :rcarriga/nvim-dap-ui
            {:requires [(pack :mfussenegger/nvim-dap {:load-file dap})]
             :call-setup dapui})
;; (use-package! :sindrets/diffview.nvim
;;               {:setup diffview
;;                :requires [(pack :nvim-lua/plenary.nvim)]})
(use-package! :kevinhwang91/nvim-ufo
             {:load-file ufo
              :requires [(pack :kevinhwang91/promise-async)]})
(use-package! :glepnir/lspsaga.nvim
             {:branch :main 
              :load-file lspsaga})
(use-package! :jose-elias-alvarez/null-ls.nvim {:load-file null-ls})
(use-package! :lukas-reineke/indent-blankline.nvim {:load-file indent-blankline})
(use-package! :theHamsta/nvim-dap-virtual-text {:call-setup nvim-dap-virtual-text})
(use-package! :Pocco81/dap-buddy.nvim)
(use-package! :hlucco/nvim-eswpoch)
 
; custom plugin end

;; At the end of the file, the unpack! macro is called to initialize packer and 
;; pass each package to packer 
(unpack!)
