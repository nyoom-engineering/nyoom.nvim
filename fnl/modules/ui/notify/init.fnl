(import-macros {: use-package!} :macros)

; replacement for vim.notify
(use-package! :rcarriga/nvim-notify {:opt true
                                     :setup (fn []
                                              (set vim.notify
                                                (fn [msg level opts]
                                                  (local {: autoload} (require :core.lib.autoload))
                                                  ((. (autoload :packer) :loader) :nvim-notify)
                                                  (set vim.notify (require :notify))
                                                  (vim.notify msg level opts))))})



