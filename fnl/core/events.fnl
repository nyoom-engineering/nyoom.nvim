(import-macros {: set! : augroup! : autocmd!} :macros)

;; Restore cursor on exit
(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * '(set! guicursor ["a:ver100-blinkon0"])))

;; require custom parinfer plugin on InsertEnter
;; hence why parinfer-rust is added in /opt (we just use it to build the dylib)
(augroup! parinfer
          (autocmd! InsertEnter * '(require :pack.parinfer)))
