(import-macros {: use-package!} :macros)

(use-package! "mhartington/formatter.nvim" {:nyoom-module editor.format
                                            :cmd [:Format :FormatWrite]})
