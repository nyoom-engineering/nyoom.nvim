(import-macros {: set! : colorscheme} :macros)

;; add Mason to path. This replaces the need to use `mason-lspconfig`
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))

;; improve updatetime for quicker refresh + gitsigns
(set! updatetime 500)
(set! timeoutlen 500)

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

;; Disable ruler
(set! noruler)

;; Lazy redraw
(set! lazyredraw)

;; Spell checking 
;; (set! spell)
;; (set! spelllang [:en])
;; (set! spelloptions [:camel])

;; Disable showing mode 
(set! noshowmode)

;; Global statusline
(set! laststatus 3)

;; Only show commandline when you need to
(set! cmdheight 0)

;; Numbering
(set! nonumber)

;; Smart search
(set! smartcase)

;; Indentation rules
(set! copyindent)
(set! smartindent)
(set! preserveindent)

;; Indentation level
(set! tabstop 2)
(set! shiftwidth 2)
(set! softtabstop 2)

;; Expand tabs
(set! expandtab)

;; Enable cursorline/column
(set! cursorline)

;; Automatic split locations
(set! splitright)
(set! splitbelow)

;; Scroll off
(set! scrolloff 8)

;; cmp options
(set! completeopt [:menu :menuone :preview :noinsert])

;; Diff-mode
(set! diffopt [:filler :internal :indent-heuristic :algorithm:histogram])

;; Grep
(set! grepprg "rg --vimgrep")
(set! grepformat "%f:%l:%c:%m")

;; colorscheme
(set! background :dark)
(set! guifont "Liga SFMono Nerd Font:h15")
(colorscheme oxocarbon)

