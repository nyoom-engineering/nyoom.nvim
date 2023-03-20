(import-macros {: local-set! : augroup! : autocmd! : clear!} :macros)

(fn bufexists? [...]
  (= (vim.fn.bufexists ...) 1))

(augroup! open-file-on-last-position
  (clear!)
  (autocmd! BufReadPost * #(vim.cmd "silent! normal! g`\"zv")))

(augroup! resize-splits-on-resize
  (clear!)
  (autocmd! VimResized * #(vim.cmd.wincmd "=")))

(augroup! read-file-on-disk-change
  (clear!)
  (autocmd! [FocusGained BufEnter CursorHold CursorHoldI] *
    #(if (and (not= :c (vim.fn.mode))
              (not (bufexists? "[Command Line]")))
       (vim.cmd.checktime)))
  (autocmd! FileChangedShellPost *
    #(vim.notify "File changed on disk. Buffer reloaded." vim.log.levels.INFO)))

(augroup! properly-open-files-with-gf
  (clear!)
  (autocmd! FileType [fennel lua]
    #(do
       (local-set! path^ (.. (vim.fn.stdpath "config") "/lua"))
       (local-set! path^ (.. (vim.fn.stdpath "config") "/fnl"))
       (local-set! suffixesadd^ "/init.fnl")
       (local-set! suffixesadd^ ".fnl")
       (local-set! suffixesadd^ "/init.lua")
       (local-set! suffixesadd^ ".lua")
       (local-set! includeexpr "tr(v:fname,'.','/')"))))
