(require-macros :macros.event-macros)

(local {: line} vim.fn)
(fn cmd! [...] (vim.cmd ...))

;; Resize splits when window is resized
(augroup! resize-splits-on-resize
          (autocmd! VimResized * "wincmd ="))
(import-macros {: set!} :macros.option-macros)

;; Restore cursor on exit
(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * '(set! guicursor ["a:ver100-blinkon0"])))

;; require custom parinfer plugin on InsertEnter
;; hence why parinfer-rust is added in /opt (we just use it to build the dylib)
(augroup! parinfer
          (autocmd! InsertEnter * '(require :pack.parinfer)))
