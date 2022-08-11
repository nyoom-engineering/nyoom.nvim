(import-macros {: use-package! : call-setup : load-module : load-on-file-open!} :macros.package-macros)

;; lazy-load mason on certain commands 
(local mason-cmds [:Mason
                   :MasonInstall
                   :MasonInstallAll
                   :MasonUninstall
                   :MasonUninstallAll
                   :MasonLog])

;; add mason to vim's search path
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))

(use-package! :williamboman/mason.nvim {:cmd mason-cmds :config (call-setup mason)})
(use-package! :j-hui/fidget.nvim {:after :nvim-lspconfig :config (call-setup fidget)})
(use-package! :folke/trouble.nvim {:cmd :Trouble :module :trouble :config (call-setup trouble)})
(use-package! "https://git.sr.ht/~whynothugo/lsp_lines.nvim" {:after :nvim-lspconfig :config (call-setup lsp_lines)})
(use-package! :neovim/nvim-lspconfig {:opt true
                                      :setup (load-on-file-open! nvim-lspconfig)
                                      :config (load-module tools.lsp)})


