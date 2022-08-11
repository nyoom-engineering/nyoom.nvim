(import-macros {: use-package!} :macros.package-macros)

(use-package! :ggandor/leap.nvim {:config (fn []
                                            ((. (require :leap) :set_default_keymaps)))})
