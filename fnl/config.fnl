(module core {require-macros [macros]})

;; general settings
(set- mouse :a)
(set- number false)
(set- modeline true)
(set- undofile true)
(set- swapfile false)
(set- lazyredraw true)
(set- ttyfast true)
(set- updatetime 100)
(set- list true)
(set- conceallevel 2)
(set- breakindent true)
(set- linebreak true)
(set- inccommand :nosplit)
(set- signcolumn :yes)

;; local values
(setl- tabstop 4)
(setl- shiftwidth 4)
(setl- scrolloff 3)

;; gui
(set- guifont "Liga SFMono Nerd Font:h14")
(seta- clipboard :unnamedplus)
(seta- fillchars "eob: ")

;; statusline
; adjust highlights
(cmd "hi StatusLineNC gui=underline guibg=#161616 guifg=#262626")
(cmd "hi StatusLine gui=underline guibg=#161616 guifg=#525252")
;; (cmd "hi VertSplit guibg=bg guifg=#262626")
(cmd "hi VertSplit guibg=bg guifg=bg")
; remove ruler
(set- noru true)
; minimal statusline
(setg- statusline "%=%t: %2l (%2p%%)")

;; global values
(setg- expandtab true)
(setr- nrformats :octal)

;; disable built-in plugins
(local built-ins {:netrw :netrwPlugin
                  :netrwSettings :netrwFileHandlers
                  :gzip :zip
                  :zipPlugin :tar
                  :tarPlugin :getscript
                  :getscriptPlugin :vimball
                  :vimballPlugin :2html_plugin
                  :logipat :rrhelper
                  :spellfile_plugin :matchit})

(each [_ p (ipairs built-ins)]
  (tset vim.g (.. :loaded_ p) 1))
