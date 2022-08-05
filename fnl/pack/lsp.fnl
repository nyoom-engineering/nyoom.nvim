(local lsp (require :lspconfig))

;;; Diagnostics configuration
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

;;; Improve UI
(let [{: with : handlers} vim.lsp]
  (set vim.lsp.handlers.textDocument/signatureHelp
       (with handlers.signature_help {:border :solid}))
  (set vim.lsp.handlers.textDocument/hover
       (with handlers.hover {:border :solid})))

(fn on-attach [client bufnr]
  (import-macros {: buf-map!} :macros.keybind-macros)
  (import-macros {: autocmd! : augroup! : clear!} :macros.event-macros)

  ;; Keybindings
  (local {:hover open-doc-float!
          :declaration goto-declaration!
          :definition goto-definition!
          :type_definition goto-type-definition!
          :code_action open-code-action-float!
          :rename rename!} vim.lsp.buf)
  (local {:open_float open-line-diag-float!
          :goto_prev goto-diag-prev!
          :goto_next goto-diag-next!} vim.diagnostic)
  (local {:lsp_implementations open-impl-float!
          :lsp_references open-ref-float!
          :diagnostics open-diag-float!
          :lsp_document_symbols open-local-symbol-float!
          :lsp_workspace_symbols open-workspace-symbol-float!} (require :telescope.builtin))

  (buf-map! [n] "K" open-doc-float!)
  (buf-map! [nv] "<leader>ca" open-code-action-float!)
  (buf-map! [nv] "<leader>cr" rename!)
  (buf-map! [nv] "<leader>cf" vim.lsp.buf.formatting {:noremap true :silent true})
  (buf-map! [n] "<leader>d" open-line-diag-float!)
  (buf-map! [n] "[d" goto-diag-prev!)
  (buf-map! [n] "]d" goto-diag-next!)
  (buf-map! [n] "<leader>gD" goto-declaration!)
  (buf-map! [n] "<leader>gd" goto-definition!)
  (buf-map! [n] "<leader>gt" goto-type-definition!)
  (buf-map! [n] "<leader>li" open-impl-float!)
  (buf-map! [n] "<leader>lr" open-ref-float!)
  (buf-map! [n] "<leader>ld" '(open-diag-float! {:bufnr 0}))
  (buf-map! [n] "<leader>lD" open-diag-float!)
  (buf-map! [n] "<leader>ls" open-local-symbol-float!)
  (buf-map! [n] "<leader>lS" open-workspace-symbol-float!))

  ;; Format buffer before saving
  ;; (local {: contains?} (require :macros.lib.seq))
  ;; (when (client.supports_method "textDocument/formatting")
  ;;   (augroup! lsp-format-before-saving
  ;;     (clear! {:buffer bufnr})
  ;;     (autocmd! BufWritePre <buffer>
  ;;       '(vim.lsp.buf.format {:filter (fn [client] (not (contains? [:jsonls :tsserver] client.name)))
  ;;                             :bufnr bufnr})
  ;;       {:buffer bufnr}))))

;; What should the lsp be demanded of?
(local capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities.textDocument.completion.completionItem
     {:documentationFormat [:markdown :plaintext]
      :snippetSupport true
      :preselectSupport true
      :insertReplaceSupport true
      :labelDetailsSupport true
      :deprecatedSupport true
      :commitCharactersSupport true
      :tagSupport {:valueSet {1 1}}
      :resolveSupport {:properties [:documentation
                                    :detail
                                    :additionalTextEdits]}})

;;; Setup servers
(local defaults {:on_attach on-attach
                 : capabilities
                 :flags {:debounce_text_changes 150}})

;; for simple servers jsut add them to the list
(let [servers [:clojure_lsp
               :jsonls
               :lemminx
               :jdtls
               :pyright]]
  (each [_ server (ipairs servers)]
    ((. (. lsp server) :setup) defaults)))

;; for trickier servers you can change up the defaults
(lsp.sumneko_lua.setup {:on_attach on-attach
                        : capabilities
                        :settings {:Lua {:diagnostics {:globals {1 :vim}}
                                         :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                                               (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}
                                                     :maxPreload 100000
                                                     :preloadFileSize 10000}}}})
