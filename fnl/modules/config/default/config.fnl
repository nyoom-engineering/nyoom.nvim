(import-macros {: set! : augroup! : autocmd! : clear!} :macros)

(fn bufexists? [...]
  (= (vim.fn.bufexists ...) 1))

(augroup! restore-cursor-on-exit (clear!)
          (autocmd! VimLeave * `(set! guicursor ["a:ver100-blinkon0"])))

(augroup! open-file-on-last-position (clear!)
          (autocmd! BufReadPost *
                    `(fn []
                       (local mark (vim.api.nvim_buf_get_mark 0 "\""))
                       (local lcount (vim.api.nvim_buf_line_count 0))
                       (when (and (> (. mark 1) 0) (<= (. mark 1) lcount))
                         (pcall vim.api.nvim_win_set_cursor 0 mark)))))

(augroup! read-file-on-disk-change (clear!)
          (autocmd! [FocusGained BufEnter CursorHold CursorHoldI] *
                    `(if (and (not= :c (vim.fn.mode))
                              (not (bufexists? "[Command Line]")))
                         (vim.cmd.checktime)))
          (autocmd! FileChangedShellPost *
                    `(vim.notify "File changed on disk. Buffer reloaded."
                                 vim.log.levels.INFO)))
