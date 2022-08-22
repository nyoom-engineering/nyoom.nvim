(require :indent_blankline)
(local {: setup} (require :indent_blankline))

(setup {:buftype_exclude [:terminal]
        :filetype_exclude [:help
                           :terminal
                           :alpha
                           :packer
                           :lspinfo
                           :TelescopePrompt
                           :TelescopeResults
                           :mason
                           ""]
        :indentLine_enabled 1
        :show_first_indent_level false
        :show_current_context_start true
        :show_current_context true
        :show_trailing_blankline_indent false})
