(module lspconfig_con {require-macros [macros]})

(def nvim-lsp (require :lspconfig))
(defn on-attach [client bufnr] (set! omnifunc "v:lua.vim.lsp.omnifunc")
      (map! [n] :gD "<cmd>lua vim.lsp.buf.declaration()<CR>" :silent)
      (map! [n] :gd "<cmd>lua vim.lsp.buf.definition()<CR>" :silent)
      (map! [n] :K "<cmd>lua vim.lsp.buf.hover()<CR>" :silent)
      (map! [n] :gi "<cmd>lua vim.lsp.buf.implementation()<CR>" :silent)
      (map! [n] :<C-k> "<cmd>lua vim.lsp.buf.signature_help()<CR>" :silent)
      (map! [n] :<leader>wa "<cmd>lua vim.lsp.buf.add_workleader_folder()<CR>"
            :silent) (map! [n] :<leader>wr
                                "<cmd>lua vim.lsp.buf.remove_workleader_folder()<CR>"
                                :silent)
      (map! [n] :<leader>wl
            "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workleader_folders()))<CR>"
            :silent) (map! [n] :<leader>D
                                "<cmd>lua vim.lsp.buf.type_definition()<CR>"
                                :silent)
      (map! [n] :<leader>rn "<cmd>lua vim.lsp.buf.rename()<CR>" :silent)
      (map! [n] :<leader>ca "<cmd>lua vim.lsp.buf.code_action()<CR>" :silent)
      (map! [n] :gr "<cmd>lua vim.lsp.buf.references()<CR>" :silent)
      (map! [n] :<leader>E
            "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" :silent)
      (map! [n] "[d" "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>" :silent)
      (map! [n] "]d" "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>" :silent)
      (map! [n] :<leader>Q "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>" :silent)
      (map! [n] :<leader>F "<cmd>lua vim.lsp.buf.formatting()<CR>" :silent))

(def servers {1 clangd 2 sumneko_lua})
(def lsp_installer (require :nvim-lsp-installer))
(lsp_installer.on_server_ready (fn [server]
                                 (def opts
                                      {:on_attach on-attach
                                       :flags {:debounce_text_changes 150}})
                                 (server:setup opts)))
(each [_ lsp (ipairs servers)]
  (lsp_installer.on_server_ready lsp))
