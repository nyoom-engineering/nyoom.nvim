(import-macros {: use-package!} :macros)

(use-package! :mvllow/modes.nvim {:opt true
                                  :defer modes.nvim
                                  :nyoom-module ui.nyoom.+modes})
