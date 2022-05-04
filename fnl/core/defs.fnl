(require-macros :macros.option-macros)

;; set leader key
(let! :g.mapleader " ")

;;; Global options
(set! hidden true updatetime 200 timeoutlen 500 shortmess :filnxtToOFatsc inccommand :split path "**") 

;; cmp options
(set! completeopt [:menu :menuone :preview :noinsert])

;; Use clipboard outside Neovim
(set! clipboard :unnamedplus)

;; Enable mouse input
(set! mouse :a)

;; Faster macros
(set! lazyredraw true)

;; Disable swapfiles and enable undofiles
(set! swapfile false undofile true)

;;; UI-related options
(set! ruler false)

;; Numbering
(set! number false)

;; True-color
(set! termguicolors true)

;; Cols and chars
(set! signcolumn "auto:1-3" foldcolumn "auto:3")

(set! fillchars {:eob " "
                 :horiz "━"
                 :horizup "┻"
                 :horizdown "┳"
                 :vert "┃"
                 :vertleft "┫"
                 :vertright "┣"
                 :verthoriz "╋"
                 :fold " "
                 :diff "─"
                 :msgsep "‾"
                 :foldsep "│"
                 :foldopen "▾"
                 :foldclose "▸"})

;; Smart search
(set! smartcase true)

;; Case-insensitive search
(set! ignorecase true)

;; Indentation rules
(set! copyindent true smartindent true preserveindent true)

;; Indentation level
(set! tabstop 4 shiftwidth 4 softtabstop 4)

;; Expand tabs
(set! expandtab true)

;; Enable concealing
(set! conceallevel 2)

;; Automatic split locations
(set! splitright true splitbelow true)

;; Scroll off
(set! scrolloff 8)

;; Disable cursorline
(set! cursorline false)
