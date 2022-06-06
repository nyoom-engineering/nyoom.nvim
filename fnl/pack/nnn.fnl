(local {: setup} (require :nnn))
(local builtin (. (require :nnn) :builtin))

(setup {:mappings [[:<C-t> builtin.open_in_tab]
                   [:<C-s> builtin.open_in_split]
                   [:<C-v> builtin.open_in_vsplit]
                   [:<C-p> builtin.open_in_preview]
                   [:<C-y> builtin.copy_to_clipboard]
                   [:<C-w> builtin.cd_to_path]
                   [:<C-e> builtin.populate_cmdline]]})
                    
