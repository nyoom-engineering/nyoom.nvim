(require-macros :macros.event-macros)
(import-macros {: set!} :macros.option-macros)

;; Restore cursor on exit
(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * '(set! guicursor ["a:ver100-blinkon0"])))
