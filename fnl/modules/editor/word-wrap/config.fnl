(import-macros {: set! : local-set! : augroup! : clear! : autocmd!} :macros)

(set! linebreak)
(set! breakindent)

(augroup! word-wrap (clear!) (autocmd! BufWinEnter *.md `(local-set! wrap))
          (autocmd! BufWinEnter *.txt `(local-set! wrap))
          (autocmd! BufWinEnter *.norg `(local-set! wrap))
          (autocmd! BufWinEnter *.org `(local-set! wrap))
          (autocmd! BufWinEnter *.tex `(local-set! wrap)))
