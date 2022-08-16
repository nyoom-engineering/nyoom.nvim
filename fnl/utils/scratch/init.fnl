(import-macros {: local-set!} :macros)

;; Emacs-ish scratch buffer with Conjure + fennel + hotpot
(fn scratch []
  (when (and (= (vim.fn.argc) 0) (= (vim.fn.line2byte "$") -1)
             (= (vim.fn.bufexists 0) 0))
    (local scratch-comments [";; This buffer is for Fennel evaluation."
                             ";; If you want to create a file, run ':write' with a file name."
                             ";; NOTE: press <space>meb to evaluate buffer (conjure)."
                             ";;       press <space>mer to evaluate root form (conjure)."
                             ";;       press <space>hr to open reflect (hotpot)."
                             ";; Run :ConjureSchool for more"
                             ""
                             ""
                             "(require-macros :macros)"])
    (vim.cmd.file "*scratch*")
    (local-set! bufhidden :hide)
    (local-set! buftype :nofile)
    (local-set! buflisted true)
    ;; force load fennel
    (require :pack.parinfer)
    (local-set! ft :fennel)
    ;; setup buffer
    (vim.api.nvim_buf_set_lines 0 0 -1 true scratch-comments)
    (vim.api.nvim_win_set_cursor 0 [5 0])))

{: scratch}
