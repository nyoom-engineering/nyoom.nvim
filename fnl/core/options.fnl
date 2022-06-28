(require-macros :macros.option-macros)

;; improve updatetime for quicker refresh + gitsigns
(set! updatetime 200)
(set! timeoutlen 500)

;; guicursor tweaks 
(set! guicursor "n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20")

;; use treesitter for folding
(set! foldlevel 100)
(set! foldmethod :expr) 
(set! foldexpr "nvim_treesitter#foldexpr()")

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

;; and the same treatment for trailing characters
(set! list)
(set! listchars {:tab "> " :nbsp "␣" :trail "-"})

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

;; Smart search
(set! smartcase)

;; Case-insensitive search
(set! ignorecase)

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

;; Enable concealing
(set! conceallevel 2)

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

;; cmdhieght 0 is a nightly option
(fn nightly? []
   "Check if using Neovim nightly (0.8)"
   (let [nightly (vim.fn.has :nvim-0.8.0)]
     (= nightly 1)))

(if (= true (nightly?))
   (set! cmdheight 0))
