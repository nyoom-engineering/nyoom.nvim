(module rainbow_con {require-macros [macros]})

(opt- nvim-treesitter.configs setup
      {:rainbow {:enable true
                 :extended_mode true
                 :max_file_lines 1000
                 :colors {1 "#3ddbd9"
                          2 "#33b1ff"
                          3 "#ff7eb6"
                          4 "#be95ff"
                          5 "#0043ce"
                          6 "#3ddbd9"}}})
