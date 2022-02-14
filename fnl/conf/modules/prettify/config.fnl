(import-macros {: set!} :conf.macros)

;; disable the ruler
(set! noru)

;; show whitespaces as characters 
(set! list)

;; always conceal
(set! conceallevel 2)

;; I don't get the point of fancy statusline plugins. 
;; I used to use them, until I realized that I could do the same in a more elegant and minimal way. 
;; Now I just have this one line statusline, which works well enough

;; filename + lineno
(set! statusline "%F%m%r%h%w: %2l")




