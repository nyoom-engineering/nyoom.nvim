(import-macros {: use-package!} :macros)

; git-gutter but better
(use-package! :lewis6991/gitsigns.nvim {:call-setup gitsigns
                                        :ft :gitcommit
                                        :setup (fn []
                                                  (vim.api.nvim_create_autocmd [:BufRead]
                                                           {:callback (fn []
                                                                        (fn onexit [code _]
                                                                          (when (= code 0)
                                                                            (vim.schedule (fn []
                                                                                            ((. (require :packer) :loader) :gitsigns.nvim)))))

                                                                        (local lines
                                                                               (vim.api.nvim_buf_get_lines 0 0 (- 1) false))
                                                                        (when (not= lines [""])
                                                                          (vim.loop.spawn :git
                                                                                          {:args [:ls-files
                                                                                                  :--error-unmatch
                                                                                                  (vim.fn.expand "%:p:h")]}
                                                                                          onexit)))}))})


