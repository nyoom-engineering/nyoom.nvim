(import-macros {: nyoom-module-p! : set! : augroup! : autocmd! : command!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: warn!} (autoload :core.lib.io))

;; Restore cursor on exit
(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * '(set! guicursor ["a:ver100-blinkon0"])))

;; Replace Packer usage
(command! PackerSync '(warn! "Please use the bin/nyoom script instead of PackerSync"))
(command! PackerInstall '(warn! "Please use the bin/nyoom script instead of PackerInstall"))
(command! PackerUpdate '(warn! "Please use the bin/nyoom script instead of PackerUpdate"))
(command! PackerCompile '(warn! "Please use the bin/nyoom script instead of PackerCompile"))
(command! PackerStatus "lua require 'packages' require('packer').status()")

;; improve updatetime for quicker refresh + gitsigns
(set! updatetime 250)
(set! timeoutlen 400)

;; Set shortmess
(set! shortmess+ :cI)

;; Show whitespace characters
(nyoom-module-p! nyoom
  (do
    (set! list)
    (set! listchars {:trail "·"
                     :tab "→ "
                     :nbsp "·"})))

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

;; Don't redraw the screen when executing macros
(set! lazyredraw)

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

;; A little more padding while scrolling
(nyoom-module-p! nyoom
  (set! scrolloff 4))

;; Use ripgrep for the builtin grep
(set! grepprg "rg --vimgrep")
(set! grepformat "%f:%l:%c:%m")

;; Support fuzzy finding
(set! path ["." "**"])

;; Diff-mode
(set! diffopt [:filler :internal :indent-heuristic :algorithm:histogram])

;; colorscheme
(nyoom-module-p! nyoom
 (do
   (set! guifont "Scientifica:h15")
   (set! background :dark)
   (set! termguicolors)))
