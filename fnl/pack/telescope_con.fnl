(module telescope_con {require-macros [macros]})

(opt- telescope setup {:defaults {:mappings {:i {:<C-h> :which_key}}}
                       :pickers {}
                       :extensions {:fzy_native :smart_history}
                       :history {:path "~/.local/share/nvim/databases/telescope_history.sqlite3"
                                 :limit 100}})
