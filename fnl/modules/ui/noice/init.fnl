(import-macros {: use-package! : pack} :macros)

; replacement for vim.notify

(use-package! :folke/noice.nvim
              {:nyoom-module ui.noice
               :after :nvim-lspconfig
               :event :CmdlineEnter
               :requires [(pack :rcarriga/nvim-notify {:opt true})]})
