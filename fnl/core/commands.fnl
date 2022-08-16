(import-macros {: command! : local-set! : buf-map!} :macros)

;; Emacs-ish scratch buffer with Conjure + fennel
(fn create-scratch []
  (when (and (= (vim.fn.argc) 0) (= (vim.fn.line2byte "$") -1)
             (= (vim.fn.bufexists 0) 0))
    (local scratch-comments [";; This buffer is for Fennel evaluation."
                             ";; If you want to create a file, run ':write' with a file name."
                             ";; NOTE: press <e> (or <A-r> in insert mode) to evaluate buffer."
                             ""
                             ""])
    (vim.cmd.file "*scratch*")
    (require :pack.parinfer)
    (local-set! bufhidden :hide)
    (local-set! buftype :nofile)
    (local-set! buflisted true)
    (local-set! ft :fennel)
    (vim.api.nvim_buf_set_lines 0 0 -1 true scratch-comments)
    (vim.api.nvim_win_set_cursor 0 [5 0])
    ;; Set keybindings
    (buf-map! [n] :<e> :<cmd>ConjureEvalBuf<cr>)
    (buf-map! [i] :<A-r> :<cmd>ConjureEvalBuf<cr>)))

(command! Scratch '(create-scratch))

;; load plugins
(command! PackerSync "lua require 'pack' require('packer').sync()")
(command! PackerStatus "lua require 'pack' require('packer').status()")
(command! PackerInstall "lua require 'pack' require('packer').install()")
(command! PackerUpdate "lua require 'pack' require('packer').update()")
(command! PackerCompile "lua require 'pack' require('packer').compile()")

;; antifennel. TODO use macro
(vim.api.nvim_exec "command! -bar -range=% Antifennel lua require('utils.antifennel').run(<line1>, <line2>" true)
