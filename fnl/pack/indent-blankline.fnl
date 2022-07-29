(local {: setup} (require :indent_blankline))

(tset vim.g "indentLine_enabled" 0)
(tset vim.g "indentLine_char" "▏")
(tset vim.g "indent_blankline_use_treesitter" true)
(setup {:show_current_context true})
