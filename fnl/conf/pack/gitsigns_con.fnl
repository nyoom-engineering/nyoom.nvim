(local {: setup} (require :gitsigns))
(setup {:signs {:add {:hl :GitSignsAdd
                      :text "┃"
                      :numhl :GitSignsAddNr
                      :linehl :GitSignsAddLn}
                :change {:hl :GitSignsChange
                         :text "┃"
                         :numhl :GitSignsChangeNr
                         :linehl :GitSignsChangeLn}
                :delete {:hl :GitSignsDelete
                         :text "▁"
                         :numhl :GitSignsDeleteNr
                         :linehl :GitSignsDeleteLn}
                :topdelete {:hl :GitSignsDelete
                            :text "▔"
                            :numhl :GitSignsDeleteNr
                            :linehl :GitSignsDeleteLn}
                :changedelete {:hl :GitSignsChange
                               :text "▔"
                               :numhl :GitSignsChangeNr
                               :linehl :GitSignsChangeLn}}
        :signcolumn true
        :numhl false
        :linehl false
        :update_debounce 200})
