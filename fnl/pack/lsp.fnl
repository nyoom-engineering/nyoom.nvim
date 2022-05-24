(local lsp (require :lspconfig))
(local {: set-lsp-keys!} (require :core.keymaps))

;;; Diagnostics configuration
(let [{: config : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           :virtual_text false
           :update_in_insert true
           :severity_sort true
           :float {:show_header false :border :rounded}})
  (sign_define :DiagnosticSignError {:text "" :texthl :DiagnosticSignError})
  (sign_define :DiagnosticSignWarn {:text "" :texthl :DiagnosticSignWarn})
  (sign_define :DiagnosticSignInfo {:text "" :texthl :DiagnosticSignInfo})
  (sign_define :DiagnosticSignHint {:text "" :texthl :DiagnosticSignHint}))

;;; Improve UI
(let [{: with : handlers} vim.lsp]
  (set vim.lsp.handlers.textDocument/signatureHelp
       (with handlers.signature_help {:border :solid}))
  (set vim.lsp.handlers.textDocument/hover
       (with handlers.hover {:border :solid})))

;;; Set keymaps + lsp_signature on attaching the server
(fn on-attach [client bufnr]
  (set-lsp-keys! bufnr)
  (let [signature (require :lsp_signature)]
    (signature.on_attach {:bind true
                          :fix_pos true
                          :floating_window_above_cur_line true
                          :doc_lines 0
                          :hint_enable false
                          :hint_prefix "● "
                          :hint_scheme :DiagnosticSignInfo}
                         bufnr)))

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

;; example: typescript server 
;; (when (= (vim.fn.executable :tsserver) 1)
;;   (lsp.tsserver.setup defaults))

;; clojure
;; (when (= (vim.fn.executable :clojure-lsp) 1)
;;   (lsp.clojure_lsp.setup defaults))

;; nix
;; (when (= (vim.fn.executable :rnix-lsp) 1)
;;   (lsp.rnix.setup defaults))

;; rust
;; (when (= (vim.fn.executable :rust-analyzer) 1)
;;   (lsp.rust_analyzer.setup defaults))

;; for trickier servers you can change up the defaults
(when (= (vim.fn.executable :lua-language-server) 1)
  (lsp.sumneko_lua.setup {:on_attach on-attach
                          : capabilities
                          :settings {:Lua {:diagnostics {:globals {1 :vim}}
                                           :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                                                 (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}
                                                       :maxPreload 100000
                                                       :preloadFileSize 10000}}}}))
