(local lsp (require :lspconfig))

;;; Diagnostics configuration
(let [{: config : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           :virtual_text false
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
  (local {: set-lsp-keys!} (require :core.keymaps))
  ;; set keymaps via which-key
  (set-lsp-keys! bufnr)
   ;; lsp_signature on attaching the server
  (let [signature (require :lsp_signature)]
    (signature.on_attach {:bind true
                          :fix_pos true
                          :floating_window_above_cur_line true
                          :doc_lines 0
                          :hint_enable false
                          :hint_prefix "● "
                          :hint_scheme :DiagnosticSignInfo}
                         bufnr))
  ;; Format buffer before saving
  (import-macros {: autocmd! : augroup! : clear!} :macros.event-macros)
  (local {: contains?} (require :macros.lib.seq))
  (when (client.supports_method "textDocument/formatting")
    (augroup! lsp-format-before-saving
      (clear! {:buffer bufnr})
      (autocmd! BufWritePre <buffer>
        '(vim.lsp.buf.format {:filter (fn [client] (not (contains? [:jsonls :tsserver] client.name)))
                              :bufnr bufnr})
        {:buffer bufnr})))
  ;; Display hints on hover
  (local {:inlay_hints inlay-hints!} (require :lsp_extensions))
  (augroup! lsp-display-hints
    (autocmd! [CursorHold CursorHoldI] *.rs
      '(inlay-hints! {}))))

;; What should the lsp be demanded of? Normally this would
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
