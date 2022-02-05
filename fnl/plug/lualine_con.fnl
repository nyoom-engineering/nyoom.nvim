(module lualine_con {require-macros [macros]})

(opt- lualine setup {:tabline {}
                     :options {:icons_enabled 1
                               :component_separators {:right "" :left ""}
                               :section_separators {:right "" :left ""}
                               :disabled_filetypes {}
                               :always_divide_middle true}
                     :sections {:lualine_a {1 :mode}
                                :lualine_b {1 :branch 2 :diff}
                                :lualine_c {1 :filename}
                                :lualine_x {1 :location}
                                :lualine_y {}
                                :lualine_z {}}
                     :inactive_sections {:lualine_a {}
                                         :lualine_b {}
                                         :lualine_c {1 :filename}
                                         :lualine_x {1 :location}
                                         :lualine_y {}
                                         :lualine_z {}}})
