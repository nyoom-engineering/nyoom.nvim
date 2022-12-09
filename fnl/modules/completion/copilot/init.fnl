(import-macros {: use-package!} :macros)

;; standard completion for neovim
(use-package! :zbirenbaum/copilot.lua
              {:nyoom-module completion.copilot :event :InsertEnter})
