(import-macros {: use-package! : load-module : call-setup} :macros.package-macros)

(use-package! :anuvyklack/hydra.nvim {:keys :<space> :config (load-module editor.hydras)})
(use-package! :lewis6991/gitsigns.nvim {:opt true
                                        :config (call-setup gitsigns)
                                        :setup (fn []
                                                 (vim.api.nvim_create_autocmd [:BufAdd :VimEnter]
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
