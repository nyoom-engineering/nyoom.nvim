(import-macros {: use-package! : pack} :macros)

; fuzzy finder
(use-package! :nvim-lua/telescope.nvim
              {:nyoom-module completion.telescope
               :cmd :Telescope
               :requires [(pack :nvim-telescope/telescope-project.nvim {:opt true})
                          (pack :nvim-telescope/telescope-ui-select.nvim {:opt true})
                          (pack :nvim-telescope/telescope-fzf-native.nvim {:opt true
                                                                           :run :make})]})
