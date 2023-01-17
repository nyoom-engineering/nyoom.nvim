(import-macros {: set! : augroup! : autocmd! : clear!} :macros)

(fn bufexists? [...]
  (= (vim.fn.bufexists ...) 1))

(augroup! open-file-on-last-position (clear!)
          (autocmd! BufReadPost *
                    `(fn []
                       (local mark (vim.api.nvim_buf_get_mark 0 "\""))
                       (local lcount (vim.api.nvim_buf_line_count 0))
                       (when (and (> (. mark 1) 0) (<= (. mark 1) lcount))
                         (pcall vim.api.nvim_win_set_cursor 0 mark)))))

(augroup! read-file-on-disk-change (clear!)
          (autocmd! [FocusGained BufEnter CursorHold CursorHoldI] *
                    `(if (and (not= :c (vim.api.nvim_get_mode))
                              (not (bufexists? "[Command Line]")))
                         (vim.cmd.checktime)))
          (autocmd! FileChangedShellPost *
                    `(vim.notify "File changed on disk. Buffer reloaded."
                                 vim.log.levels.INFO)))

(let [open_floating_preview vim.lsp.util.open_floating_preview]
  (fn vim.lsp.util.open_floating_preview [...]
    (local (bufnr winid) (open_floating_preview ...))
    (vim.api.nvim_win_set_option winid :breakindentopt "")
    (vim.api.nvim_win_set_option winid :showbreak "NONE")
    (values bufnr winid)))
