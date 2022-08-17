(import-macros {: use-package!} :macros)

; intuitive motions
(use-package! :ggandor/leap.nvim {:opt true
                                  :defer leap.nvim
                                  :config (fn []
                                            (. (require :leap) :set_default_keymaps))})
