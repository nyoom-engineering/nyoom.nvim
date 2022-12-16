(import-macros {: command! : set! : let!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: executable? : nightly?} (autoload :core.lib))
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
      providers [:perl :node :ruby]]
  (each [_ v (ipairs built-ins)]
    (let [plugin (.. :loaded_ v)]
      (let! plugin 1)))
  (each [_ v (ipairs providers)]
    (let [provider (.. :loaded_ v :_provider)]
      (let! provider 0))))

;; load python provider

(let! python3_host_prog (if (executable? :python) (vim.fn.exepath :python)
                            (executable? :python3) (vim.fn.exepath :python3)
                            nil))

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

(if (nightly?)
    (do
      ;; Diff-mode
      (set! diffopt+ "linematch:60")
      ;; Stabilize lines
      (set! splitkeep :screen)))

;; check for cli

(local cli (os.getenv :NYOOM_CLI))
;; If its a cli instance, load package management
;; If its a regular instance, load userconfig and plugins

(if cli
    (require :packages)
    (do
      (require :config)
      (require :packer_compiled)))

;; Replace Packer usage

(fn replace-packer [command]
  (fn nyoom-gui [command]
    (local {: scan_dir} (autoload :plenary.scandir))
    (local {: reload_module} (autoload :plenary.reload))
    (require :packages)
    ((. (require :packer) command))
    (local files (scan_dir (vim.fn.stdpath :config)))
    (each [_ filename (ipairs files)]
      (when (= (filename:match "^.+(%..+)$") :.fnl)
        (vim.cmd (.. "source " filename))))
    (each [module _ (pairs package.loaded)]
      (reload_module module))
    (dofile vim.env.MYVIMRC)
    (vim.notify "Nyoom Reloaded!"))

  (fn first-to-upper [str]
    (str:gsub "^%l" string.upper))

  (local packer-command (.. :Packer (first-to-upper command)))
  (local nyoom-command (.. :Nyoom (first-to-upper command)))
  (vim.api.nvim_create_user_command packer-command
                                    (fn []
                                      (warn! (.. "Please use the `nyoom` cli or "
                                                 nyoom-command)))
                                    {})
  (vim.api.nvim_create_user_command nyoom-command
                                    (fn []
                                      (nyoom-gui command))
                                    {}))

(let [packer-commands [:install :update :compile :sync]]
  (each [_ v (ipairs packer-commands)]
    (replace-packer v)))
