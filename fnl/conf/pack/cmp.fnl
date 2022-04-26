(import-macros {: set! : let! : cmd} :conf.macros)
(local {: setup
        : mapping
        : visible
        :config {: compare : disable}
        :SelectBehavior {:Insert insert-behavior :Select select-behavior}
        : event} (require :cmp))

(local under-compare (require :cmp-under-comparator))
(local {: insert} table)

;; colors!
(cmd "hi CmpItemAbbrMatch gui=bold guifg=#FAFAFA")
(cmd "hi CmpItemAbbrMatchFuzzy guifg=#FAFAFA")
(cmd "hi CmpItemAbbr guifg=#a8a8a8")

(cmd "hi CmpItemKindVariable guibg=NONE guifg=#be95ff")
(cmd "hi CmpItemKindInterface guibg=NONE guifg=#be95ff")
(cmd "hi CmpItemKindText guibg=NONE guifg=#be95ff")

(cmd "hi CmpItemKindFunction guibg=NONE guifg=#ff7eb6")
(cmd "hi CmpItemKindMethod guibg=NONE guifg=#ff7eb6")

(cmd "hi CmpItemKindKeyword guibg=NONE guifg=#33b1ff")
(cmd "hi CmpItemKindProperty guibg=NONE guifg=#33b1ff")
(cmd "hi CmpItemKindUnit guibg=NONE guifg=#33b1ff")

;; and of course some settings
(set! completeopt [:menu :menuone :noselect])

(setup {:preselect (. (. (. (require :cmp.types)
                            :cmp)
                         :PreselectMode)
                      :None)
        :style {:winhighlight "NormalFloat:NormalFloat,FloatBorder:FloatBorder"}
        :experimental {:native_menu false :ghost_text true}
        :window {:completion {:border {1 "╭"
                                       2 "─"
                                       3 "╮"
                                       4 "│"
                                       5 "╯"
                                       6 "─"
                                       7 "╰"
                                       8 "│"}
                                      :scrollbar "║"
                                      :autocomplete {1 (. (. (. (require :cmp.types)
                                                                :cmp)
                                                             :TriggerEvent)
                                                          :InsertEnter)
                                                     2 (. (. (. (require :cmp.types)
                                                                :cmp)
                                                             :TriggerEvent)
                                                          :TextChanged)}}
                         :documentation {:border {1 "╭"
                                                  2 "─"
                                                  3 "╮"
                                                  4 "│"
                                                  5 "╯"
                                                  6 "─"
                                                  7 "╰"
                                                  8 "│"}
                                         :winhighlight "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
                                         :scrollbar "║"}}
        :formatting {:format (fn [entry vim-item]
                               (set vim-item.menu
                                    (. {:nvim_lsp :lsp
                                        :nvim_lua :lua
                                        :buffer :buf
                                        :luasnip :snp
                                        :path :pth
                                        :treesitter :trs
                                        :conjure :cj}
                                       entry.source.name))
                               (set vim-item.kind
                                    (. {:Text ""
                                        :Method ""
                                        :Function ""
                                        :Constructor ""
                                        :Field "ﰠ"
                                        :Variable ""
                                        :Class "ﴯ"
                                        :Interface ""
                                        :Module ""
                                        :Property "ﰠ"
                                        :Unit "塞"
                                        :Value ""
                                        :Enum ""
                                        :Keyword ""
                                        :Snippet ""
                                        :Color ""
                                        :File ""
                                        :Reference ""
                                        :Folder ""
                                        :EnumMember ""
                                        :Constant ""
                                        :Struct "פּ"
                                        :Event ""
                                        :Operator ""
                                        :TypeParameter ""}
                                       vim-item.kind))
                               vim-item)}
        :snippet {:expand (fn [args]
                            ((. (require :luasnip) :lsp_expand) args.body))}
        :mapping {:<C-b> (mapping.scroll_docs -4)
                  :<C-f> (mapping.scroll_docs 4)
                  :<C-space> (mapping.complete)
                  :<C-e> (mapping.abort)
                  :<up> disable
                  :<down> disable
                  :<Tab> (mapping (fn [fallback]
                                    (if (visible)
                                        (mapping (mapping.select_next_item {:behavior insert-behavior}))
                                        ((. (require :luasnip)
                                            :expand_or_jumpable))
                                        (vim.fn.feedkeys (vim.api.nvim_replace_termcodes :<Plug>luasnip-expand-or-jump
                                                                                         true
                                                                                         true
                                                                                         true)
                                                         "")
                                        (fallback)
                                      [:i :s])))
                  :<S-Tab> (mapping (fn [fallback]
                                      (if (visible)
                                          (mapping (mapping.select_prev_item {:behavior insert-behavior}))
                                          ((. (require :luasnip)
                                              :jumpable) (- 1))
                                          (vim.fn.feedkeys (vim.api.nvim_replace_termcodes :<Plug>luasnip-jump-prev
                                                                                           true
                                                                                           true
                                                                                           true)
                                                           "")
                                          (fallback)))
                                    [:i :s])
                  :<space> (mapping.confirm {:select false})}
        :sources [{:name :nvim_lsp}
                  {:name :conjure}
                  {:name :nvim_lua}
                  {:name :buffer}
                  {:name :treesitter}
                  {:name :luasnip}
                  {:name :path}]
        :sorting {:comparators [compare.offset
                                compare.exact
                                compare.score
                                under-compare.under
                                compare.kind
                                compare.sort_text
                                compare.length
                                compare.order]}})
