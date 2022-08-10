(import-macros {: use-package!} :macros.package-macros)

(use-package! :ggandor/leap.nvim {:setup (fn []
                                          ((. (require :utils.lazy-load)
                                              :load-on-file-open!) :leap.nvim))
                                  :config (fn []
                                            ((. (require :leap) :set_default_keymaps)))})


