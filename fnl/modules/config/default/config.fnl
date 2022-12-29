(import-macros {: set! : augroup! : autocmd! : clear!} :macros)

(fn bufexists? [...]
  (= (vim.fn.bufexists ...) 1))

(augroup! restore-cursor-on-exit (clear!)
          (autocmd! VimLeave * `(set! guicursor ["a:ver100-blinkon0"])))

(augroup! open-file-on-last-position (clear!)
          (autocmd! BufReadPost * `(vim.cmd "silent! normal! g`\"zv")))

(augroup! read-file-on-disk-change (clear!)
          (autocmd! [FocusGained BufEnter CursorHold CursorHoldI] *
                    `(if (and (not= :c (vim.fn.mode))
                              (not (bufexists? "[Command Line]")))
                         (vim.cmd.checktime)))
          (autocmd! FileChangedShellPost *
                    `(vim.notify "File changed on disk. Buffer reloaded."
                                 vim.log.levels.INFO)))
