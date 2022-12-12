(import-macros {: colorscheme : command! : set!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: nightly?} (autoload :core.lib))
(local {: warn!} (autoload :core.lib.io))
;; optimizations

(let [built-ins [:gzip
                 :zip
                 :zipPlugin
                 :tar
                 :tarPlugin
                 :getscript
                 :getscriptPlugin
                 :vimball
                 :vimballPlugin
                 :2html_plugin
                 :matchit
                 :matchparen
                 :logiPat
                 :rrhelper
                 :netrw
                 :netrwPlugin
                 :netrwSettings
                 :netrwFileHandlers]
      providers [:perl :node :ruby :python :python3]]
  (each [_ v (ipairs built-ins)]
    (let [plugin (.. :loaded_ v)]
      (tset vim.g plugin 1)))
  (each [_ v (ipairs providers)]
    (let [provider (.. :loaded_ v :_provider)]
      (tset vim.g provider 0))))

;; add language servers to path

(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :config) :/bin))
;; improve updatetime for quicker refresh + gitsigns

(set! updatetime 250)
(set! timeoutlen 400)
;; Set shortmess

(set! shortmess+ :sWcIS)
;; Sign column

(set! signcolumn "yes:1")
;; Global subtitution by default

(set! gdefault)
;; Theres no need for formatoptions, we have our own

(set! formatoptions [:q :j])
;; By default no wrapping

(set! nowrap)
;; Use clipboard outside Neovim

(set! clipboard :unnamedplus)
;; Enable mouse input

(set! mouse :a)
;; Disable swapfiles and enable undofiles

(set! undofile)
(set! nowritebackup)
(set! noswapfile)
;; Smart search

(set! ignorecase)
(set! smartcase)
;; Expand tabs to spaces

(set! expandtab)
(set! tabstop 4)
(set! shiftwidth 4)
(set! softtabstop 4)
;; Split from left to right and top to bottom

(set! splitright)
(set! splitbelow)
;; Use ripgrep for the builtin grep

(set! grepprg "rg --vimgrep")
(set! grepformat "%f:%l:%c:%m")
;; Support fuzzy finding

(set! path ["." "**"])

(if nightly?
    (do
      ;; Diff-mode
      (set! diffopt+ "linematch:60")
      ;; Stabilize lines
      (set! splitkeep :screen)))

;; Replace Packer usage

(command! PackerSync
          `(warn! "Please use the bin/nyoom script instead of PackerSync"))

(command! PackerInstall
          `(warn! "Please use the bin/nyoom script instead of PackerInstall"))

(command! PackerUpdate
          `(warn! "Please use the bin/nyoom script instead of PackerUpdate"))

(command! PackerCompile
          `(warn! "Please use the bin/nyoom script instead of PackerCompile"))

(command! PackerStatus "lua require 'packages' require('packer').status()")

(command! PackerLockfile "lua require 'packages' require('packer').lockfile()")
;; check for cli

(local cli (os.getenv :NYOOM_CLI))

;; If its a cli instance, load package management
;; If its a regular instance, load userconfig and plugins

(if cli
    (require :packages)
    (do
      (require :config)
      (require :packer_compiled)))
