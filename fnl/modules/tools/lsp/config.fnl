(import-macros {: nyoom-module-p!} :macros)
(local lsp (require :lspconfig))

;;; Improve UI
(set vim.lsp.handlers.textDocument/signatureHelp
      (vim.lsp.with vim.lsp.handlers.signature_help {:border :solid}))
(set vim.lsp.handlers.textDocument/hover
     (vim.lsp.with vim.lsp.handlers.hover {:border :solid}))

(fn on-attach [client bufnr]
  (import-macros {: buf-map! : autocmd! : augroup! : clear! : contains?} :macros)

  ;; Keybindings
  (local {:hover open-doc-float!
          :declaration goto-declaration!
          :definition goto-definition!
          :type_definition goto-type-definition!
          :code_action open-code-action-float!
          :rename rename!} vim.lsp.buf)

  (buf-map! [n] "K" open-doc-float!)
  (buf-map! [nv] "<leader>a" open-code-action-float!)
  (buf-map! [nv] "<leader>rn" rename!)
  (buf-map! [n] "<leader>gD" goto-declaration!)
  (buf-map! [n] "<leader>gd" goto-definition!)
  (buf-map! [n] "<leader>gt" goto-type-definition!)

  ;; Enable lsp formatting if available 
  (nyoom-module-p! format.+onsave
    (when (client.supports_method "textDocument/formatting")
      (augroup! lsp-format-before-saving
        (clear! {:buffer bufnr})
        (autocmd! BufWritePre <buffer>
          '(vim.lsp.buf.format {:filter (fn [client] (not (contains? [:jsonls :tsserver] client.name)))
                                :bufnr bufnr})
          {:buffer bufnr})))))

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

;; conditional lsp servesr
(local lsp-servers [])

(nyoom-module-p! java
  (table.insert lsp-servers :jdtls))

(nyoom-module-p! sh
  (table.insert lsp-servers :bashls))

(nyoom-module-p! julia
  (table.insert lsp-servers :julials))

(nyoom-module-p! markdown
  (table.insert lsp-servers :marksman))

(nyoom-module-p! nix
  (table.insert lsp-servers :rnix))

;; Load lsp
(let [servers lsp-servers]
  (each [_ server (ipairs servers)]
    ((. (. lsp server) :setup) defaults)))

;; for trickier servers you can change up the defaults
(nyoom-module-p! lua
  (lsp.sumneko_lua.setup {:on_attach on-attach
                          : capabilities
                          :settings {:Lua {:diagnostics {:globals {1 :vim}}
                                           :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                                                 (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}
                                                       :maxPreload 100000
                                                       :preloadFileSize 10000}}}}))

{: on-attach}
