(import-macros {: use-package! : pack} :macros)

(use-package! :rcarriga/nvim-dap
              {:nyoom-module tools.debugger
               :opt true
               :defer nvim-dap
               :requires [(pack :rcarriga/nvim-dap-ui {:opt true})
                          (pack :mfussenegger/nvim-dap-python {:opt true})
                          (pack :jbyuki/one-small-step-for-vimkind {:opt true})]})
