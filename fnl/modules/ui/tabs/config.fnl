(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
(local {: diagnostic-icons} (autoload :core.shared))

(setup :bufferline
       {:options {:numbers :none
                  :diagnostics :nvim_lsp
                  :diagnostics_indicator (fn [total-count
                                              level
                                              diagnostics-dict]
                                           (var s "")
                                           (each [kind count (pairs diagnostics-dict)]
                                             (set s
                                                  (string.format "%s %s %d" s
                                                                 (. diagnostic-icons
                                                                    kind)
                                                                 count)))
                                           s)
                  :show_buffer_close_icons true
                  :show_close_icon false
                  :persist_buffer_sort true
                  :separator_style ["│" "│"]
                  :indicator {:icon "│" :style :icon}
                  :enforce_regular_tabs false
                  :always_show_bufferline false
                  :offsets [{:filetype :NvimTree
                             :text :Files
                             :text_align :center}
                            {:filetype :DiffviewFiles
                             :text "Source Control"
                             :text_align :center}]}})
