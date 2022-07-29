(local autocmd vim.api.nvim_create_autocmd)

(fn lazy-load! [tb]
  (autocmd tb.events
           {:group (vim.api.nvim_create_augroup tb.augroup_name {})
            :callback (fn []
                        (when (tb.condition)
                          (vim.api.nvim_del_augroup_by_name tb.augroup_name)
                          (if (not= tb.plugin :nvim-treesitter)
                              (vim.defer_fn (fn []
                                              ((. (require :packer)
                                                  :loader) tb.plugin)
                                              (when (= tb.plugin
                                                       :nvim-lspconfig)
                                                (vim.cmd "silent! e %")))
                                            0)
                              ((. (require :packer) :loader) tb.plugin))))}))

(fn load-on-file-open! [plugin-name]
  (lazy-load! {:events [:BufRead :BufWinEnter :BufNewFile]
               :augroup_name (.. :BeLazyOnFileOpen plugin-name)
               :plugin plugin-name
               :condition (fn []
                            (local file (vim.fn.expand "%"))
                            (and (and (not= file :NvimTree_1)
                                      (not= file "[packer]"))
                                 (not= file "")))}))

(fn load-gitsigns []
  (autocmd [:BufRead]
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
                                          onexit)))}))

{: lazy-load!
 : load-gitsigns
 : load-on-file-open!}
