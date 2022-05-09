(require-macros :macros.option-macros)

;; Disable some built-in Neovim plugins and unneeded providers
(let [built-ins [:gzip
                 :zip
                 :zipPlugin
                 :tar
                 :tarPlugin
                 :getscript
                 :getscriptPlugin
                 :vimball
                 :vimballPlugin
                 :2html_plugin
                 :matchit
                 :matchparen
                 :logiPat
                 :rrhelper
                 :netrw
                 :netrwPlugin
                 :netrwSettings
                 :netrwFileHandlers]
      providers [:perl :node :ruby :python :python3]]
  (each [_ v (ipairs built-ins)]
    (let [plugin (.. :loaded_ v)]
      (tset vim.g plugin 1)))
  (each [_ v (ipairs providers)]
    (let [provider (.. :loaded_ v :_provider)]
      (tset vim.g provider 0))))

;; defer shada loading
(set! shadafile "NONE")
(vim.schedule (fn []
                (set! shadafile
                     (.. (vim.fn.expand :$HOME)
                         :/.local/share/nvim/shada/main.shada))
                (vim.cmd " silent! rsh ")))  

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

;;; Global options
(set! hidden true updatetime 200 timeoutlen 500 shortmess :filnxtToOFatsc inccommand :split path "**") 

;; cmp options
(set! completeopt [:menu :menuone :preview :noinsert])

;; Use clipboard outside Neovim
(set! clipboard :unnamedplus)

;; Better guifont
(set! guifont "Liga SFMono Nerd Font:h15")

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

;; Enable cursorline
(set! cursorline true)

;; Automatic split locations
(set! splitright true splitbelow true)

;; Scroll off
(set! scrolloff 8)

