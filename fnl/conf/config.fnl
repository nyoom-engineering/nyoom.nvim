(import-macros {: set!} :conf.macros)

;; genearl settings
(set! noru)
(set! list)
(set! ttyfast)
(set! mouse :a)
(set! nonumber)
(set! undofile)
(set! smartcase)
(set! tabstop 2)
(set! linebreak)
(set! expandtab)
(set! lazyredraw)
(set! noswapfile)
(set! scrolloff 3)
(set! shiftwidth 0)
(set! nowritebackup)
(set! timeoutlen 500)
(set! softtabstop -1)
(set! updatetime 500)
(set! fillchars "eob: ")
(set! signcolumn "auto:1-9")
(set! clipboard :unnamedplus)
(set! statusline "%=%t: %2l (%2p%%)")
(set! guifont "Liga SFMono Nerd Font:h14")

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
