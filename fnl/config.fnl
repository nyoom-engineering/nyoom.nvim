(module core {require-macros [macros]})

;; override highlights
(vim.cmd "hi StatusLineNC gui=underline guibg=#161616 guifg=#262626")
(vim.cmd "hi StatusLine gui=underline guibg=#161616 guifg=#525252")
(vim.cmd "hi VertSplit guibg=bg guifg=bg")

;; genearl settings
(set! nowritebackup)
(set! noswapfile)
(set! expandtab)
(set! scrolloff 3)
(set! softtabstop -1)
(set! shiftwidth 0)
(set! tabstop 2)
(set! linebreak)
(set! spell)
(set! spelllang [:en])
(set! spelloptions [:camel])
(set! undofile)
(set! updatetime 500)
(set! mouse :a)
(set! nonumber)
(set! statusline "%=%t: %2l (%2p%%)")
(set! noru)
(set! list)
(set! signcolumn "auto:1-9")
(set! fillchars "eob: ")
(set! smartcase)
(set! lazyredraw)
(set! ttyfast)
(set! timeoutlen 500)
(set! guifont "Liga SFMono Nerd Font:h14")
(set! clipboard :unnamedplus)

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
