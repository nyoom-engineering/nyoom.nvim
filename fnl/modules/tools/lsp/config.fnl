(import-macros {: nyoom-module-p!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: deep-merge} (autoload :core.lib.tables))
(local lsp (autoload :lspconfig))
(local lsp-servers {})
;;; Improve UI

(set vim.lsp.handlers.textDocument/signatureHelp
     (vim.lsp.with vim.lsp.handlers.signature_help {:border :solid}))

(set vim.lsp.handlers.textDocument/hover
     (vim.lsp.with vim.lsp.handlers.hover {:border :solid}))

(fn on-attach [client bufnr]
  (import-macros {: buf-map! : autocmd! : augroup! : clear!} :macros)
  (local {: contains?} (autoload :core.lib))
  ;; Keybindings
  (local {:hover open-doc-float!
          :declaration goto-declaration!
          :definition goto-definition!
          :type_definition goto-type-definition!
          :code_action open-code-action-float!
          :references goto-references!
          :rename rename!} vim.lsp.buf)
  (buf-map! [n] :K open-doc-float!)
  (buf-map! [nv] :<leader>a open-code-action-float!)
  (buf-map! [nv] :<leader>rn rename!)
  (buf-map! [n] :<leader>gD goto-declaration!)
  (buf-map! [n] :gD goto-declaration!)
  (buf-map! [n] :<leader>gd goto-definition!)
  (buf-map! [n] :gd goto-definition!)
  (buf-map! [n] :<leader>gt goto-type-definition!)
  (buf-map! [n] :gt goto-type-definition!)
  (buf-map! [n] :<leader>gr goto-references!)
  (buf-map! [n] :gr goto-references!)
  ;; Enable lsp formatting if available 
  (nyoom-module-p! format.+onsave
                   (when (client.supports_method :textDocument/formatting)
                     (augroup! lsp-format-before-saving
                               (clear! {:buffer bufnr})
                               (autocmd! BufWritePre <buffer>
                                         `(vim.lsp.buf.format {:filter (fn [client]
                                                                         (not (contains? [:jsonls
                                                                                          :tsserver]
                                                                                         client.name)))
                                                               : bufnr})
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

;; fennel-language-server
;; (tset lsp-servers :fennel-language-server {})
;; (tset (require :lspconfig.configs) :fennel-language-server
;;       {:default_config {:cmd [:fennel-language-server]
;;                         :filetypes [:fennel]
;;                         :single_file_support true
;;                         :root_dir (lsp.util.root_pattern :fnl)
;;                         :settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)}
;;                                             :diagnostics {:globals [:vim]}}}}})

;; conditional servers

(nyoom-module-p! clojure (tset lsp-servers :clojure-lsp {}))

(nyoom-module-p! java (tset lsp-servers :jdtls {}))

(nyoom-module-p! sh (tset lsp-servers :bashls {}))

(nyoom-module-p! julia (tset lsp-servers :julials {}))

(nyoom-module-p! kotlin (tset lsp-servers :kotlin_age_server {}))

(nyoom-module-p! latex (tset lsp-servers :texlab {}))

(nyoom-module-p! lua
                 (tset lsp-servers :sumneko_lua
                       {:settings {:Lua {:diagnostics {:globals [:vim]}
                                         :workspace {:library (vim.api.nvim_list_runtime_paths)
                                                     :maxPreload 100000}}}}))

(nyoom-module-p! markdown (tset lsp-servers :marksman {}))

(nyoom-module-p! nim (tset lsp-servers :nimls {}))

(nyoom-module-p! nix (tset lsp-servers :rnix {}))

(nyoom-module-p! python
                 (tset lsp-servers :pyright
                       {:root_dir (lsp.util.root_pattern [:.flake8])
                        :settings {:python {:analysis {:autoImportCompletions true
                                                       :useLibraryCodeForTypes true
                                                       :disableOrganizeImports false}}}}))

(nyoom-module-p! zig (tset lsp-servers :zls {}))
;; Load lsp

(let [servers lsp-servers]
  (each [server server_config (pairs servers)]
    ((. (. lsp server) :setup) (deep-merge defaults server_config))))

{: on-attach}
