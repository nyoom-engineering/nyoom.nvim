(setup :gitsigns
       {:signs {:add {:hl :diffAdded
                      :text "│"
                      :numhl :GitSignsAddNr
                      :linehl :GitSignsAddLn}
                :change {:hl :diffChanged
                         :text "│"
                         :numhl :GitSignsChangeNr
                         :linehl :GitSignsChangeLn}
                :delete {:hl :diffRemoved
                         :text ""
                         :numhl :GitSignsDeleteNr
                         :linehl :GitSignsDeleteLn}
                :changedelete {:hl :diffChanged
                               :text "‾"
                               :numhl :GitSignsChangeNr
                               :linehl :GitSignsChangeLn}
                :topdelete {:hl :diffRemoved
                            :text "~"
                            :numhl :GitSignsDeleteNr
                            :linehl :GitSignsDeleteLn}}})
