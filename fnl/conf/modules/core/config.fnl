(import-macros {: set!} :conf.macros)

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

;; as many signs in the signcolumn as you like
(set! signcolumn "auto:1-9")

;; universal clipboard support
(set! clipboard :unnamedplus)

;; disable unessecary providers
(let [built-ins [:netrw
                 :netrwPlugin
                 :netrwSettings
                 :netrwFileHandlers
                 :gzip
                 :zip
                 :zipPlugin
                 :tar
                 :tarPlugin
                 :getscript
                 :getscriptPlugin
                 :vimball
                 :vimballPlugin
                 :2html_plugin
                 :logipat
                 :rrhelper
                 :spellfile_plugin
                 :matchit]
      providers [:perl :python :python3 :node :ruby]]
  (each [_ v (ipairs built-ins)]
    (let [b (.. :loaded_ v)]
      (tset vim.g b 1)))
  (each [_ v (ipairs providers)]
    (let [p (.. :loaded_ v :_provider)]
      (tset vim.g p 0))))

