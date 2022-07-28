(local {: setup} (require :nvim-surround))

(setup {:keymaps {:insert "ys"
                  :insert_line "yss"
                  :visual "S"
                  :delete "ds"
                  :change "cs"}})
