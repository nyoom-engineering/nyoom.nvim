(local config (require :lspconfig))

(fn on-attach [client bufnr]
  (import-macros {: buf-map! : local-set!} :conf.macros)
  (local-set! omnifunc "v:lua.vim.lsp.omnifunc")
  (buf-map! [n] :<leader>gD "<cmd>lua vim.lsp.buf.declaration()<CR>" :silent)
  (buf-map! [n] :<leader>gf "<cmd>lua vim.lsp.buf.definition()<CR>" :silent)
  (buf-map! [n] :<leader>gi "<cmd>lua vim.lsp.buf.implementation()<CR>" :silent)
  (buf-map! [n] :<leader>gt :<cmd>Trouble<CR> :silent)
  (buf-map! [n] :<leader>gba "<cmd>lua vim.lsp.buf.add_workleader_folder()<CR>"
            :silent)
  (buf-map! [n] :<leader>gbr
            "<cmd>lua vim.lsp.buf.remove_workleader_folder()<CR>" :silent)
  (buf-map! [n] :<leader>gl
            "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workleader_folders()))<CR>"
            :silent)
  (buf-map! [n] :<leader>gd "<cmd>lua vim.lsp.buf.type_definition()<CR>"
            :silent)
  (buf-map! [n] :<leader>gn "<cmd>lua vim.lsp.buf.rename()<CR>" :silent)
  (buf-map! [n] :<leader>ga "<cmd>lua vim.lsp.buf.code_action()<CR>" :silent)
  (buf-map! [n] :<leader>gr "<cmd>lua vim.lsp.buf.references()<CR>" :silent)
  (buf-map! [n] :<leader>ge
            "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" :silent)
  (buf-map! [n] "[d" "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>" :silent)
  (buf-map! [n] "]d" "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>" :silent)
  (buf-map! [n] :<leader>gq "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>"
            :silent))

(let [{: config : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           :virtual_text {:severity {:min severity.INFO}}
           :update_in_insert false
           :severity_sort true
           :float {:show_header false :border :single}})
  (sign_define :DiagnosticSignError {:text "" :texthl :DiagnosticSignError})
  (sign_define :DiagnosticSignWarn {:text "" :texthl :DiagnosticSignWarn})
  (sign_define :DiagnosticSignInfo {:text "" :texthl :DiagnosticSignInfo})
  (sign_define :DiagnosticSignHint {:text "" :texthl :DiagnosticSignHint}))

(let [{: with : handlers} vim.lsp]
  (set vim.lsp.handlers.textDocument/signatureHelp
       (with handlers.signature_help {:border :single}))
  (set vim.lsp.handlers.textDocument/hover
       (with handlers.hover {:border :single})))

(local servers {1 clangd 2 sumneko_lua})
(local lsp_installer (require :nvim-lsp-installer))
(lsp_installer.on_server_ready (fn [server]
                                 (local opts
                                        {:on_attach on-attach
                                         :flags {:debounce_text_changes 150}})
                                 (server:setup opts)))

(each [_ lsp (ipairs servers)]
  (lsp_installer.on_server_ready lsp))
