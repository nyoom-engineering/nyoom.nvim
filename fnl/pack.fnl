(import-macros {: packadd! : use-package! : pack : unpack! : call-setup : load-file : load-lang : defer!} :macros)

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

;; The package manager can manage itself
(use-package! :wbthomason/packer.nvim {:opt true})

;; Used by quite a few plugins
(use-package! :nvim-lua/plenary.nvim {:module :plenary})

;; profiling
(use-package! :stevearc/profile.nvim {:config (load-file profile)})

;; hotpot
(use-package! :rktjmp/hotpot.nvim {:branch :nightly})

;; aniseed
; caches lua bytecode
;; (use-package! :lewis6991/impatient.nvim)
; compiles fennel to lua
;; (use-package! :Olical/aniseed {:branch :develop})

;; lispy
; builds parinfer algorithm binary
(use-package! :eraserhd/parinfer-rust {:opt true :run "cargo build --release"})
; interactive lisp evaluation
(use-package! :Olical/conjure {:branch :develop
                               :ft conjure-ft
                               :config (tset vim.g "conjure#extract#tree_sitter#enabled" true)})

;; Mappings
; hydras, for neovim
(use-package! :anuvyklack/hydra.nvim {:keys :<space> :config (load-file hydras)})
; simple autopair plugin
(use-package! :windwp/nvim-autopairs {:event :InsertEnter :config (load-file autopairs)})
; intuitive motions
(use-package! :ggandor/leap.nvim {:config (fn []
                                            ((. (require :leap) :set_default_keymaps)))})

;; File navigation
; filetree
(use-package! :kyazdani42/nvim-tree.lua {:cmd :NvimTreeToggle :config (load-file nvimtree)})
; fuzzy finder
(use-package! :nvim-lua/telescope.nvim
              {:cmd :Telescope
               :config (load-file telescope)
               :requires [(pack :nvim-telescope/telescope-project.nvim      ;; project viewer
                                {:module :telescope._extensions.project})
                          (pack :nvim-telescope/telescope-ui-select.nvim    ;; telescope for ui.select
                                {:module :telescope._extensions.ui-select})
                          (pack :nvim-telescope/telescope-fzf-native.nvim   ;; more performant fuzzy finder 
                                {:module :telescope._extensions.fzf
                                 :run :make})]})
;; tree-sitter
; highlighting/parsing
(use-package! :nvim-treesitter/nvim-treesitter
              {:cmd treesitter-cmds
               :run ":TSUpdate"
               :module :nvim-treesitter
               :config (load-file treesitter)
               :requires [(pack :nvim-treesitter/playground {:cmd :TSPlayground})                        ;; view the tree + highlight
                          (pack :p00f/nvim-ts-rainbow {:after :nvim-treesitter})                         ;; rainbow parens!
                          (pack :nvim-treesitter/nvim-treesitter-textobjects {:after :nvim-treesitter})] ;; textobjectsk
               :setup (fn []
                        (vim.api.nvim_create_autocmd [:BufRead :BufWinEnter :BufNewFile]
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
(use-package! :williamboman/mason.nvim {:cmd mason-cmds :config (call-setup mason)})
; view lsp loading progress
(use-package! :j-hui/fidget.nvim {:after :nvim-lspconfig :config (call-setup fidget)})
; view diagnostics ala vscode
(use-package! :folke/trouble.nvim {:cmd :Trouble :module :trouble :config (call-setup trouble)})
; floating diagnostics as lines instead
(use-package! "https://git.sr.ht/~whynothugo/lsp_lines.nvim" {:after :nvim-lspconfig :config (call-setup lsp_lines)})
; easy to use configurations for language servers
(use-package! :neovim/nvim-lspconfig {:opt true
                                      :setup (defer! nvim-lspconfig)
                                      :config (load-file lsp)})

;; Language-specific functionality
; jdtls off-spec support
;; (use-package! :mfussenegger/nvim-jdtls {:ft :java :config (load-lang java)})
; view rust crate info with virtual text
(use-package! :saecki/crates.nvim {:event ["BufRead Cargo.toml"] :config (call-setup crates)})
; inlay-hints + lldb + niceties for rust-analyzer
(use-package! :simrat39/rust-tools.nvim {:ft :rust :config (load-lang rust)}) 

;; git
; Magit for neovim
(use-package! :TimUntersberger/neogit {:config (call-setup neogit) :cmd :Neogit})
; git-gutter but better
(use-package! :lewis6991/gitsigns.nvim {:ft :gitcommit
                                        :config (call-setup gitsigns)
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
              {:config (load-file cmp)
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
(use-package! :Pocco81/true-zen.nvim {:cmd :TZAtaraxis :config (call-setup truezen)})
; colorscheme
(use-package! :shaunsingh/oxocarbon.nvim {:run :./install.sh})
; show hex codes as virtualtext
(use-package! :brenoprata10/nvim-highlight-colors {:cmd :HighlightColorsToggle :config (call-setup nvim-highlight-colors)})
; lua-based matchparen alternative
(use-package! :monkoose/matchparen.nvim {:opt true
                                         :setup (defer! matchparen.nvim)
                                         :config (load-file matchparen)})
; replacement for vim.notify
(use-package! :rcarriga/nvim-notify {:opt true
                                     :setup (fn []
                                              (set vim.notify
                                                   (fn [msg level opts]
                                                     ((. (require :packer) :loader) :nvim-notify)
                                                     (set vim.notify (require :notify))
                                                     (vim.notify msg level opts))))})


;; Notes: orgmode was previously supported, but its quite buggy and not up to part with emacs. I think neorg is the way to go. Feel free to add back org-mode if you want to though!
(use-package! :nvim-neorg/neorg {:config (load-file neorg) :ft :norg :after :nvim-treesitter})

;; At the end of the file, the unpack! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(unpack!)
