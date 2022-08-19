(import-macros {: nyoom-module-p! : set! : augroup! : autocmd!} :macros)
(local {: setup} (require :nvim-surround))

;; Setup surround
(setup)

;; Restore cursor on exit
(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * '(set! guicursor ["a:ver100-blinkon0"])))

;; improve updatetime for quicker refresh + gitsigns
(set! updatetime 250)
(set! timeoutlen 400)

;; Set shortmess
(set! shortmess+ :cI)

;; No eob by default
(set! fillchars {:eob " "})

(nyoom-module-p! ui.vi-tilde-fringe
  (set! fillchars {:eob "~"}))

;; Show whitespace characters
(nyoom-module-p! ui.nyoom
  (do
    (set! list)
    (set! listchars {:trail "·"
                     :tab "→ "
                     :nbsp "·"})))

;; Sign column
(set! signcolumn "yes:1")

;; Substitution
(set! gdefault)

;; By default no wrapping
(set! nowrap)

;; smart wrapping
(nyoom-module-p! editor.wrap
  (do
    (set! wrap)
    (set! linebreak)
    (set! breakindent)
    (set! breakindentopt ["shift:2"])
    (set! showbreak "↳ ")))

;; Use clipboard outside Neovim
(set! clipboard :unnamedplus)

;; Enable mouse input
(set! mouse :a)

;; Disable swapfiles and enable undofiles
(set! undofile)
(set! noswapfile)

;; Lazy redraw
(set! lazyredraw)

;; Smart search
(set! smartcase)

;; Indentation rules
(set! copyindent)
(set! smartindent)
(set! preserveindent)

;; Indentation level
(set! tabstop 4)
(set! shiftwidth 4)
(set! softtabstop 4)

;; Expand tabs
(set! expandtab)

;; Enable cursorline/column
(nyoom-module-p! ui.nyoom
  (set! cursorline))

;; Automatic split locations
(set! splitright)
(set! splitbelow)

;; Scroll off
(nyoom-module-p! ui.nyoom
  (set! scrolloff 4))

;; Grep
(set! grepprg "rg --vimgrep")
(set! grepformat "%f:%l:%c:%m")

;; colorscheme
(nyoom-module-p! ui.nyoom
  (set! background :dark))

(nyoom-module-p! ui.modeline
  (do
   (import-macros {: set! : local-set!} :macros)
   (local modes {:n :RW
                 :no :RO
                 :v "**"
                 :V "**"
                 "\022" "**"
                 :s :S
                 :S :SL
                 "\019" :SB
                 :i "**"
                 :ic "**"
                 :R :RA
                 :Rv :RV
                 :c :VIEX
                 :cv :VIEX
                 :ce :EX
                 :r :r
                 :rm :r
                 :r? :r
                 :! "!"
                 :t :t})
   (fn color []
     (let [mode (. (vim.api.nvim_get_mode) :mode)]
       (var mode-color "%#StatusLine#")
       (if (= mode :n) (set mode-color "%#StatusNormal#")
           (or (= mode :i) (= mode :ic)) (set mode-color "%#StatusInsert#")
           (or (or (= mode :v) (= mode :V)) (= mode "\022"))
           (set mode-color "%#StatusVisual#") (= mode :R)
           (set mode-color "%#StatusReplace#") (= mode :c)
           (set mode-color "%#StatusCommand#") (= mode :t)
           (set mode-color "%#StatusTerminal#"))
       mode-color))
   (fn get-git-status []
     (let [branch (or vim.b.gitsigns_status_dict
                      {:head ""})
           is-head-empty (not= branch.head "")]
       (or (and is-head-empty
                (string.format "(λ • #%s)"
                               (or branch.head "")))
           "")))
   (fn get-lsp-diagnostic []
     (when (not (rawget vim :lsp))
       (lua "return \"\""))
   
     (local count [0 0 0 0])
   
     (local result {:errors (. count vim.diagnostic.severity.ERROR)
                    :warnings (. count vim.diagnostic.severity.WARN)
                    :info (. count vim.diagnostic.severity.INFO)
                    :hints (. count vim.diagnostic.severity.HINT)})
   
     (string.format " %%#StatusLineDiagnosticWarn#%s %%#StatusLineDiagnosticError#%s "
                    (or (. result :warnings) 0) (or (. result :errors) 0)))
   (global Statusline {})
   (set Statusline.statusline (fn []
                                (table.concat [(color)
                                               (: (string.format " %s "
                                                                 (. modes
                                                                    (. (vim.api.nvim_get_mode)
                                                                       :mode)))
                                                  :upper)
                                               "%#StatusLine#"
                                               " %f "
                                               "%#StatusPosition#"
                                               (get-git-status)
                                               "%="
                                               (get-lsp-diagnostic)
                                               "%#StatusPosition#"
                                               " %l:%c "])))
   (set Statusline.winbar (fn []
                            (table.concat ["%#WinBar#"
                                           " %f "])))
   (set! laststatus 3)
   (set! cmdheight 0)
   (set! winbar "%!v:lua.Statusline.winbar()")
   (set! statusline "%!v:lua.Statusline.statusline()")))
