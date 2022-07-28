(import-macros {: set!} :macros.option-macros)
(import-macros {: colorscheme} :macros.highlight-macros)

;; add Mason to path
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))

;; improve updatetime for quicker refresh + gitsigns
(set! updatetime 200)
(set! timeoutlen 500)

;; Set shortmess
(set! shortmess :filnxtToOFatsIc)

;; fillchar setup
(set! fillchars {:eob " "
                 :horiz " "
                 :horizup " "
                 :horizdown " "
                 :vert " "
                 :vertleft " "
                 :vertright " "
                 :verthoriz " "
                 :fold " "
                 :diff "─"
                 :msgsep "‾"
                 :foldsep " "
                 :foldopen "▾"
                 :foldclose "▸"})

;; and the same treatment for trailing characters
(set! list)
(set! listchars {:tab "> " :nbsp "␣" :trail "-"})

;; don't wrap text
(set! nowrap)

;; Use clipboard outside Neovim
(set! clipboard :unnamedplus)

;; Enable mouse input
(set! mouse :a)

;; Disable swapfiles and enable undofiles
(set! undofile)
(set! noswapfile)

;; Disable ruler
(set! noruler)

;; Disable showing mode 
(set! noshowmode)

;; Global statusline
(set! laststatus 3)

;; low cmdheight
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
(set! tabstop 4)
(set! shiftwidth 4)
(set! softtabstop 4)

;; Expand tabs
(set! expandtab)

;; Enable cursorline/column
(set! cursorline)
(set! nocursorcolumn)

;; Automatic split locations
(set! splitright)
(set! splitbelow)

;; Scroll off
(set! scrolloff 8)

;; cmp options
(set! completeopt [:menu :menuone :preview :noinsert])

;; colorscheme
(set! termguicolors)
(set! background :dark)
(set! guifont "Liga SFMono Nerd Font:h15")
(colorscheme carbon)

