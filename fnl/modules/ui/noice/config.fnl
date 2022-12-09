(import-macros {: packadd!} :macros)

(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))

(packadd! nui.nvim)
(setup :noice {:health {:checker false}
               :cmdline {:format {:cmdline {:pattern "^:"
                                            :icon " "
                                            :lang :vim}
                                  :search_down {:kind :search
                                                :pattern "^/"
                                                :icon " "
                                                :lang :regex}
                                  :search_up {:kind :search
                                              :pattern "^%?"
                                              :icon " "
                                              :lang :regex}
                                  :filter {:pattern "^:%s*!"
                                           :icon "$"
                                           :lang :bash}
                                  :lua {:pattern "^:%s*lua%s+"
                                        :icon ""
                                        :lang :lua}
                                  :help {:pattern "^:%s*h%s+" :icon ""}
                                  :input {}}
                         :opts {:win_options {:winhighlight {:Normal :NormalFloat
                                                             :FloatBorder :FloatBorder}}}}
               :lsp {:progress {:enabled true}
                     :override {:vim.lsp.util.convert_input_to_markdown_lines true
                                :vim.lsp.util.stylize_markdown true
                                :cmp.entry.get_documentation true}}
               :views {:cmdline_popup {:position {:row 0 :col "50%"}
                                       :size {:width "98%"}}}
               :presets {:long_message_to_split true :lsp_doc_border true}
               :popupmenu {:backend :cmp}
               :format {}})
