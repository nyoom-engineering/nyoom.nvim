(import-macros {: use-package! : nyoom-module!} :macros)
(nyoom-module! lang.cc)

(use-package! :p00f/clangd_extensions.nvim
              {:ft [:c :cpp] :call-setup clangd_extensions})
