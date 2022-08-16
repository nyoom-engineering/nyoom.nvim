(import-macros {: use-package!} :macros)

(use-package! :rcarriga/nvim-dap-ui {:opt true
                                     :defer nvim-dap-ui
                                     :call-setup nvim-dap-ui
                                     :requires [(pack :mfussenegger/nvim-dap {:opt true
                                                                              :defer nvim-dap})]})
