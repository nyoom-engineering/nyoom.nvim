(local {: setup} (require :ufo))
(tset vim.wo :foldcolumn "1")
(tset vim.wo :foldlevel 99)
(tset vim.wo :foldenable true)

(local capabilities (vim.lsp.protocol.make_client_capabilities
                     {:dynamicRegistration false
                      :lineFoldingOnly true}))

(setup)
