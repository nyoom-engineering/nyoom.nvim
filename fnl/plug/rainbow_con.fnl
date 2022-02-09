(module rainbow_con {require-macros [macros]})

(opt- nvim-treesitter.configs setup
      {:rainbow {:enable true
                 :extended_mode true
                 :max_file_lines 1000
                 :colors {1 "#878d96"
                          2 "#a8a8a8"
                          3 "#8d8d8d"
                          4 "#a2a9b0"
                          5 "#8f8b8b"
                          6 "#ada8a8"}}})
