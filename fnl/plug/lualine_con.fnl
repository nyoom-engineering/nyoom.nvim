(module lualine_con {require-macros [macros]})

(opt- lualine setup {:options {:section_separators {1 "" 
                                                    2 ""}
                               :component_separators {1 "│"
                                                      2 "│"}}
                     :sections {:lualine_b {1 {1 :branch
                                                :icon ""}
                                            2 {1 :diff
                                               :colored true
                                               :diff_color {:added {:fg "#33b1ff"}
                                                            :modified {:fg "#ff7eb6"}
                                                            :removed {:fg "#be95ff"}}
                                               :symbols {:added " "
                                                         :modified " "
                                                         :removed " "}}}
                                :lualine_x {1 {1 :diagnostics
                                               :sources {1 :nvim_lsp}
                                               :sections {1 :error
                                                          2 :warn
                                                          3 :info
                                                          4 :hint}
                                               :diagnostics_color {:error {:fg "#ff7eb6"}
                                                                   :warn {:fg "#b395ff"}
                                                                   :info {:fg "#3ddbd9"}
                                                                   :hint {:fg "#42be65"}}
                                               :symbols {:error " "
                                                         :warn " "
                                                         :info " "
                                                         :hint " "}}}}
                     :inactive_sections {:lualine_a {}
                                         :lualine_b {}
                                         :lualine_c {1 :filename}
                                         :lualine_x {1 :location}
                                         :lualine_y {}
                                         :lualine_z {}}})
