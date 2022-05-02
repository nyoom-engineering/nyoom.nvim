(import-macros {: set!} :conf.macros)

;;; Disable some built-in Neovim plugins and unneeded providers
(let [built-ins [:tar
                 :zip
                 :gzip
                 :zipPlugin
                 :tarPlugin
                 :getscript
                 :getscriptPlugin
                 :vimball
                 :vimballPlugin
                 :2html_plugin
                 :logipat
                 :rrhelper]
      providers [:perl :node :ruby :python :python3]]
  (each [_ v (ipairs built-ins)]
    (let [plugin (.. :loaded_ v)]
      (tset vim.g plugin 1)))
  (each [_ v (ipairs providers)]
    (let [provider (.. :loaded_ v :_provider)]
      (tset vim.g provider 0))))

;;; Global options
(set! hidden true
      updatetime 200
      timeoutlen 500
      shortmess :filnxtToOFatsc
      inccommand :split
      path "**")

;; Use clipboard outside Neovim
(set! clipboard :unnamedplus)

;; Enable mouse input
(set! mouse :a)

;; Faster macros
(set! lazyredraw true)

;; Disable swapfiles and enable undofiles
(set! swapfile false
      undofile true)

;;; UI-related options
(set! ruler false)

;; Numbering
(set! number false)

;; True-color
(set! termguicolors true)

;; Cols and chars
(set! signcolumn "auto:1-3"
      foldcolumn "auto:3")

(set! fillchars {:eob " "
                 :horiz "━"
                 :horizup "┻"
                 :horizdown "┳"
                 :vert "┃"
                 :vertleft  "┫"
                 :vertright "┣"
                 :verthoriz "╋"
                 :fold " "
                 :diff "─"
                 :msgsep "‾"
                 :foldsep "│"
                 :foldopen "▾"
                 :foldclose "▸"})

;; Do not show mode
(set! showmode false)

;; Set windows width
(set! winwidth 40)

;; Set a global statusline
(set! laststatus 3)

;;; Buffer options
;; Never wrap
(set! wrap false)

;; Smart search
(set! smartcase true)

;; Case-insensitive search
(set! ignorecase true)

;; Indentation rules
(set! copyindent true
      smartindent true
      preserveindent true)

;; Indentation level
(set! tabstop 4
      shiftwidth 4
      softtabstop 4)

;; Expand tabs
(set! expandtab true)

;; Enable concealing
(set! conceallevel 2)

;; Automatic split locations
(set! splitright true
      splitbelow true)

;; Universal Statusline
(set! laststatus 3)

;; Scroll off
(set! scrolloff 8)

;; Disable cursorline
(set! cursorline false)

;; global statusline
(set! laststatus 3)

;; enable termguicolors
(set! termguicolors)

;; gitsigns
(set! diffopt [:filler :internal :indent-heuristic :algorithm:histogram])
