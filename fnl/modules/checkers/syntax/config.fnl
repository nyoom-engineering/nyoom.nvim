(import-macros {: nyoom-module-p! : map! : autocmd!} :macros)
(local {: try_lint : linters_by_ft} (require :lint))

;; configure signs
(let [{: config : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           :virtual_text false ;; lsp_lines handles this
           :update_in_insert true
           :severity_sort true
           :float {:show_header false :border :rounded}})
  (sign_define :DiagnosticSignError {:text "" :texthl :DiagnosticSignError})
  (sign_define :DiagnosticSignWarn {:text "" :texthl :DiagnosticSignWarn})
  (sign_define :DiagnosticSignInfo {:text "" :texthl :DiagnosticSignInfo})
  (sign_define :DiagnosticSignHint {:text "" :texthl :DiagnosticSignHint}))

(nyoom-module-p! bindings
  (do
    (local {:open_float open-line-diag-float!
            :goto_prev goto-diag-prev!
            :goto_next goto-diag-next!} vim.diagnostic)
    (map! [n] "<leader>d" open-line-diag-float!)
    (map! [n] "[d" goto-diag-prev!)
    (map! [n] "]d" goto-diag-next!)))

;; Add linters. E.x.
(nyoom-module-p! lua
  (set linters_by_ft.lua [:selene]))

;; Lint on save
(autocmd! [:BufAdd :BufWritePost] * '(try_lint))
