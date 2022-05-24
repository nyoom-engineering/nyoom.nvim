(local {: format} string)
(local {: setup} (require :bufferline))

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
                  :always_show_bufferline false
                  :show_buffer_close_icons true}})



