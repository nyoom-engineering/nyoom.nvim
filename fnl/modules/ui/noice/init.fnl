(import-macros {: use-package! : pack} :macros)

; replacement for vim.notify
(use-package! :folke/noice.nvim
              {:nyoom-module ui.noice
               :after :nvim-lspconfig
               :event :CmdlineEnter
               :requires [(pack :MunifTanjim/nui.nvim {:opt true})]})

(use-package! :rcarriga/nvim-notify
              {:opt true
               :setup (fn []
                        (set vim.notify
                             (fn [msg level opts]
                               (local {: autoload} (require :core.lib.autoload))
                               ((. (autoload :packer) :loader) :nvim-notify)
                               (set vim.notify (require :notify))
                               (vim.notify msg level opts))))})
