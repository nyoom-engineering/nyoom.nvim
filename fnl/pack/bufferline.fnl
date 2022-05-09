(import-macros {: lazy-require!} :macros.package-macros)
(local {: format} string)
(local {: setup} (lazy-require! :bufferline))

;;; Setup bufferline
(setup {:options {:numbers :none
                  :offsets {1 {:filetype :NvimTree :text "" :padding 1}}
                  :buffer_close_icon ""
                  :modified_icon ""
                  :indicator_icon " "
                  :close_icon ""
                  :view :multiwindow
                  :max_name_length 14
                  :max_prefix_length 13
                  :tab_size 20
                  :show_buffer_close_icons true
                  :always_show_bufferline false
                  :custom_filter (fn [buf-number]
                                   (local (present-type type)
                                          (pcall (fn []
                                                   (vim.api.nvim_buf_get_var buf-number
                                                                             :term_type))))
                                   (when present-type
                                     (if (= type :vert)
                                         (lua "return false")
                                         (= type :hori)
                                         (lua "return false"))
                                     (lua "return true"))
                                   true)}})  


