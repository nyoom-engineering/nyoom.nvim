(import-macros {: augroup! : autocmd!} :macros.event-macros)
(import-macros {: set! : local-set!} :macros.option-macros)

(local {: line} vim.fn)
(fn cmd! [...] (vim.cmd ...))

;; Restore cursor on exit
(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * (set! guicursor ["a:ver100-blinkon0"])))

;; Open file on its last cursor position
(augroup! open-file-on-last-position
          (autocmd! BufReadPost * (if (and (> (line "'\"") 1)
                                           (<= (line "'\"") (line "$")))
                                    (cmd! "normal! g'\""))))

;; Resize splits when window is resized
(augroup! resize-splits-on-resize
          (autocmd! VimResized * "wincmd ="))

;; Terminal options
(augroup! terminal-options
          (autocmd! TermOpen * "startinsert")
          (autocmd! TermOpen * (do
                                 (local-set! nonumber)
                                 (local-set! norelativenumber)))
          (autocmd! TermOpen * (local-set! nospell))
          (autocmd! TermOpen * (local-set! signcolumn :no))
          (autocmd! TermOpen * (local-set! colorcolumn [])))

;; require custom parinfer plugin on InesertEnter, hence why parinfer-rust is added in /opt (we just use it to build the dylib)
(augroup! parinfer
          (autocmd! InsertEnter * (require :pack.parinfer)))
