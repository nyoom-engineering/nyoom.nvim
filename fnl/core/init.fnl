(import-macros {: let!} :macros)
;; optimizations

(let [built-ins [:2html_plugin
                 :getscript
                 :getscriptPlugin
                 :gzip
                 :logipat
                 :netrw
                 :netrwPlugin
                 :netrwSettings
                 :netrwFileHandlers
                 :matchit
                 :tar
                 :tarPlugin
                 :rrhelper
                 :spellfile_plugin
                 :vimball
                 :vimballPlugin
                 :zip
                 :zipPlugin
                 :tutor
                 :rplugin
                 :syntax
                 :synmenu
                 :optwin
                 :compiler
                 :bugreport
                 :ftplugin]
      providers [:node :perl :ruby]]
  (each [_ v (ipairs built-ins)]
    (let [plugin (.. :loaded_ v)]
      (let! plugin 1)))
  (each [_ v (ipairs providers)]
    (let [provider (.. :loaded_ v :_provider)]
      (let! provider 0))))

;; check for cli

(local cli (os.getenv :NYOOM_CLI))
;; If its a cli instance, load package management
;; If its a regular instance, load defaults, userconfig and plugins

(if cli
    (require :packages)
    (do
      (import-macros {: command! : set!} :macros)
      (local {: executable? : nightly?} (require :core.lib))
      (local {: error!} (require :core.lib.io))
      ;; speedups
      (set! updatetime 250)
      (set! timeoutlen 400)
      ;; visual options
      (set! shortmess+ :sWcI)
      (set! signcolumn "yes:1")
      (set! formatoptions [:q :j])
      (set! nowrap)
      ;; just good defaults
      (set! splitright)
      (set! splitbelow)
      ;; tab options
      (set! tabstop 4)
      (set! shiftwidth 4)
      (set! softtabstop 4)
      (set! expandtab)
      ;; clipboard and mouse
      (set! clipboard :unnamedplus)
      (set! mouse :a)
      ;; backups are annoying
      (set! undofile)
      (set! nowritebackup)
      (set! noswapfile)
      ;; search and replace
      (set! ignorecase)
      (set! smartcase)
      (set! gdefault)
      ;; better grep
      (set! grepprg "rg --vimgrep")
      (set! grepformat "%f:%l:%c:%m")
      (set! path ["." "**"])
      ;; nightly only options
      (if (nightly?)
          (do
            (set! diffopt+ "linematch:60")
            (set! splitkeep :screen)))
      ;; load user's config
      (require :config)
      (require :packer_compiled)
      ;; replace packer commands

      (fn replace-packer [command]
        (fn nyoom-gui [command]
          (local autoload (require :core.lib.autoload))
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
                                            (error! (.. "Please use the `nyoom` cli or "
                                                        nyoom-command)))
                                          {})
        (vim.api.nvim_create_user_command nyoom-command
                                          (fn []
                                            (nyoom-gui command))
                                          {}))

      (let [packer-commands [:install :update :compile :sync]]
        (each [_ v (ipairs packer-commands)]
          (replace-packer v)))
      ;; load mason env
      (set vim.env.PATH
           (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))
      (set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :config) :/bin))
      ;; load python providers
      (let! python3_host_prog
            (if (executable? :python) (vim.fn.exepath :python)
                (executable? :python3) (vim.fn.exepath :python3)
                nil))))
