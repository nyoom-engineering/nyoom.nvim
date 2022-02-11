(import-macros {: set!
                : let!} :conf.macros)

; Disable ruby/perl
(let! loaded_ruby_provider 0)
(let! loaded_perl_provider 0)

; Use filetype.lua
(let! do_filetype_lua 1)
(let! did_load_filetypes 0)

;; show whitespaces as characters 
(set! list)

;; emable mouse
(set! mouse :a)

;; disable line numbers
(set! nonumber)

;; enable undo (and disable the swap/backup)
(set! undofile)
(set! noswapfile)
(set! nowritebackup)

;; smart searching
(set! smartcase)

;; tab = 2 spaces
(set! tabstop 2)
(set! expandtab)
(set! shiftwidth 0)

;; faster macros 
(set! lazyredraw)

;; add some padding while scrolling
(set! scrolloff 3)

;; the default updatetime in vim is around 4 seconds. This messes with gitsigns and the like, lets reduce it
(set! updatetime 500)

;; remove the informative but slightly ugly eob tilde fringe
(set! fillchars "eob: ")

;; as many signs in the signcolumn as you like, width is auto-adjusted. 
(set! signcolumn "auto:1-9")

;; universal clipboard support
(set! clipboard :unnamedplus)

;; I don't get the point of fancy statusline plugins. 
;; I used to use them, until I realized that I could do the same in a more elegant and minimal way. 
;; Now I just have this one line statusline, which works well enough

;; disable the ruler
(set! noru)

;; filename + lineno
(set! statusline "%F%m%r%h%w: %2l")

;; font for GUI's. You probably want to change this
(set! guifont "Liga SFMono Nerd Font:h15")

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
