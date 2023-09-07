(import-macros {: let! : set!} :macros)
(local {: executable?} (autoload :core.lib))

;; load constants

(autoload :core.shared)

;; add userconfig to runtimepath

(set! rtp+ (.. (vim.loop.os_homedir) :/.config/nyoom))

;; add python provider and mason binaries

(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :config) :/bin))

(let! python3_host_prog (if (executable? "python") (vim.fn.exepath "python")
                          (executable? "python3") (vim.fn.exepath "python3")
                          nil))

;; check for cli

(local cli (os.getenv :NYOOM_CLI))

;; If its a cli instance, load package management
;; If its a regular instance, load defaults, userconfig and plugins

(if cli
    (require :packages)
    (do
      ;; set opinionated defaults. TODO this should be in a module?
      (import-macros {: command! : let! : set!} :macros)
      ;; speedups
      (set! updatetime 250)
      (set! timeoutlen 400)
      ;; visual options
      (set! conceallevel 2)
      (set! infercase)
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
      ;; external config files
      (set! exrc)
      ;; search and replace
      (set! ignorecase)
      (set! smartcase)
      (set! gdefault)
      ;; better grep
      (set! grepprg "rg --vimgrep")
      (set! grepformat "%f:%l:%c:%m")
      (set! path ["." "**"])
      ;; previously nightly options
      (set! diffopt+ "linematch:60")
      (set! splitkeep :screen)
      ;; nightly only options
      (local {: nightly?} (autoload :core.lib))
      (if (nightly?)
          (do))
      ;; gui options
      (set! list)
      (set! fillchars {:eob " "
                       :vert " "
                       :horiz " "
                       :diff "╱"
                       :foldclose ""
                       :foldopen ""
                       :fold " "
                       :msgsep "─"})
      (set! listchars {:tab " ──"
                       :trail "·"
                       :nbsp "␣"
                       :precedes "«"
                       :extends "»"})
      (set! scrolloff 4)
      (set! guifont "Liga SFMono Nerd Font:h14")
      (let! neovide_padding_top 45)
      (let! neovide_padding_left 38)
      (let! neovide_padding_right 38)
      (let! neovide_padding_bottom 20)
      ;; load userconfig
      (require :config)
      (require :packer_compiled)
      ;; (require :pacttesting)
      ;; disable packer commands

      (fn disable-packer [command]
        (fn first-to-upper [str]
          (str:gsub "^%l" string.upper))

        (local packer-command (.. :Packer (first-to-upper command)))
        (vim.api.nvim_create_user_command packer-command
                                          (fn []
                                            (err! (.. "Please use the `nyoom` cli")))
                                          {}))

      (let [packer-commands [:install :update :compile :sync :status :lockfile]]
        (each [_ v (ipairs packer-commands)]
          (disable-packer v)))))
