(import-macros {: use-package!} :macros)

; Install language servers and such
(use-package! :williamboman/mason.nvim {:nyoom-module tools.mason
                                        :cmd [:Mason
                                              :MasonLog]})

