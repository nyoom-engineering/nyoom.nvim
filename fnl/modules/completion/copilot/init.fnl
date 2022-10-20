(import-macros {: use-package! : pack} :macros)

;; standard completion for neovim
(use-package! :samodostal/copilot-client.lua {:nyoom-module completion.copilot
                                              :event [:InsertEnter :CmdLineEnter]
                                              :requires (pack :zbirenbaum/copilot.lua {:opt true})})
