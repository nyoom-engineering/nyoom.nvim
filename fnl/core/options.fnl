(require-macros :macros.option-macros)

;; improve updatetime for quicker refresh + gitsigns
(set! updatetime 200)
(set! timeoutlen 500)

;; Show regex differences in a split
(set! inccommand :split)

;; Set shortmess
(set! shortmess :filnxtToOFatsIc)

;; fillchar setup
(set! fillchars {:eob " "
                 :horiz "─"
                 :horizup "┴"
                 :horizdown "┬"
                 :vert "│"
                 :vertleft "┤"
                 :vertright "├"
                 :verthoriz "┼"
                 :fold " "
                 :diff "─"
                 :msgsep "‾"
                 :foldsep "│"
                 :foldopen "▾"
                 :foldclose "▸"})

;; Use clipboard outside Neovim
(set! clipboard :unnamedplus)

;; Enable mouse input
(set! mouse :a)

;; Disable swapfiles and enable undofiles
(set! undofile)
(set! noswapfile)

;;; UI-related options
(set! noruler)

;; Numbering
(set! nonumber)

;; Cols and chars
(set! foldcolumn "auto:3")
(set! signcolumn "auto:1-3")

;; Smart search
(set! smartcase)

;; Case-insensitive search
(set! ignorecase)

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

;; Enable concealing
(set! conceallevel 2)

;; Enable cursorline
(set! cursorline)

;; Automatic split locations
(set! splitright)
(set! splitbelow)

;; Scroll off
(set! scrolloff 8)

;; cmp options
(set! completeopt [:menu :menuone :preview :noinsert])
