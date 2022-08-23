(import-macros {: use-package!} :macros)

(use-package! :p00f/clangd_extensions.nvim {:ft [:c :cpp]
                                            :call-setup clangd_extensions})
