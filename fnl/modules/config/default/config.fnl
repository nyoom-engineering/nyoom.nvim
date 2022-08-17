(import-macros {: nyoom-module-p! : set! : augroup! : autocmd!} :macros)

;; Restore cursor on exit
(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * '(set! guicursor ["a:ver100-blinkon0"])))

;; improve updatetime for quicker refresh + gitsigns
(set! updatetime 250)
(set! timeoutlen 400)

;; Set shortmess
(set! shortmess+ :cI)

;; Show whitespace characters
(set! list)

;; Define characters to show
(set! listchars {:trail "·"
                 :tab "→ "
                 :nbsp "·"})

;; Fold column characters
(set! fillchars {:eob " "
                 :fold " "
                 :foldopen ""
                 :foldsep " "})

;; Sign column
(set! signcolumn "yes:1")

;; don't wrap text
(set! nowrap)

;; Substitution
(set! gdefault)

;; Do not break words at the middle
(set! linebreak)

;; Maintain indentation on break
(set! breakindent)

;; Add characters after wrap
(set! breakindentopt ["shift:2"])

;; Show character after wrap
(set! showbreak "↳ ")

;; Use clipboard outside Neovim
(set! clipboard :unnamedplus)

;; Enable mouse input
(set! mouse :a)

;; Disable swapfiles and enable undofiles
(set! undofile)
(set! noswapfile)

;; Lazy redraw
(set! lazyredraw)

;; Global statusline
(set! laststatus 3)

;; Only show commandline when you need to
(set! cmdheight 0)

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
(set! cursorline)

;; Automatic split locations
(set! splitright)
(set! splitbelow)

;; Scroll off
(set! scrolloff 8)

;; Grep
(set! grepprg "rg --vimgrep")
(set! grepformat "%f:%l:%c:%m")

;; colorscheme
(set! background :dark)

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
   (set! winbar "%!v:lua.Statusline.winbar()")
   (set! statusline "%!v:lua.Statusline.statusline()")))
