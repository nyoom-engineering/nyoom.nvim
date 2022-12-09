(import-macros {: use-package!} :macros)

; git-gutter but better
(use-package! :lewis6991/gitsigns.nvim
              {:nyoom-module ui.vc-gutter
               :module [:gitsigns]
               :ft :gitcommit
               :setup (fn []
                        (vim.api.nvim_create_autocmd [:BufRead]
                                                     {:callback (fn []
                                                                  (vim.fn.system (.. "git rev-parse 2>/dev/null "
                                                                                     (vim.fn.expand "%:p:h")))
                                                                  (when (= vim.v.shell_error
                                                                           0)
                                                                    (vim.schedule (fn []
                                                                                    ((. (require :packer)
                                                                                        :loader) :gitsigns.nvim)))))}))})
