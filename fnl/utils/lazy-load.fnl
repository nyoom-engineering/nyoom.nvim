(fn lazy-load! [tb]
  (vim.api.nvim_create_autocmd tb.events
                               {:pattern "*"
                                :group (vim.api.nvim_create_augroup tb.augroup_name {})
                                :callback (fn []
                                            (when (tb.condition)
                                              (vim.api.nvim_del_augroup_by_name tb.augroup_name)
                                              (vim.defer_fn (fn []
                                                              (vim.cmd (.. "PackerLoad "
                                                                           tb.plugins)))
                                                            0)
                                              (vim.cmd (.. "PackerLoad "
                                                           tb.plugins))))}))

(fn load-bufferline []
  (lazy-load! {:events [:BufNewFile
                        :BufRead
                        :TabEnter]
               :augroup_name :BufferLineLazy
               :plugins :bufferline.nvim
               :condition (fn []
                            (>= (length (vim.fn.getbufinfo {:buflisted 1}))
                                2))}))

(fn load-colorizer []
  (lazy-load! {:events [:BufRead 
                        :BufNewFile]
               :augroup_name :ColorizerLazy
               :plugins :nvim-colorizer.lua
               :condition (fn []
                            (local items
                                   {1 "#" 2 :rgb 3 :hsl 4 :rgba 5 :hsla})
                            (each [_ val (ipairs items)]
                              (when (not= (vim.fn.search val) 0)
                                (lua "return true"))))}))

(fn load-on-file-open! [plugin-name]
  (lazy-load! {:events [:BufRead 
                        :BufWinEnter 
                        :BufNewFile]
               :augroup_name (.. :BeLazyOnFileOpen plugin-name)
               :plugins plugin-name
               :condition (fn []
                            (local file (vim.fn.expand "%"))
                            (and (and (not= file :NvimTree_1)
                                      (not= file "[packer]"))
                                 (not= file "")))}))

(fn load-gitsigns []
  (vim.api.nvim_create_autocmd [:BufRead]
                               {:callback (fn []
                                            (fn onexit [code _]
                                              (when (= code 0)
                                                (vim.schedule (fn []
                                                                ((. (require :packer)
                                                                    :loader) :gitsigns.nvim)))))
                                            (local lines
                                                   (vim.api.nvim_buf_get_lines 0
                                                                               0
                                                                               (- 1)
                                                                               false))
                                            (when (not= lines {1 ""})
                                              (vim.loop.spawn :git
                                                              {:args {1 :ls-files
                                                                      2 :--error-unmatch
                                                                      3 (vim.fn.expand "%:p:h")}}
                                                              onexit)))}))

{: load-gitsigns
 : load-colorizer
 : load-bufferline
 : load-on-file-open!}
