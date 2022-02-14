(import-macros {: use-package! : pack : let!} :conf.macros)

(use-package! :hrsh7th/nvim-cmp
              {:after :cmp-under-comparator
               :requires [(pack :hrsh7th/cmp-nvim-lsp {:after :nvim-cmp})
                          (pack :PaterJason/cmp-conjure {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-path {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-copilot {:after :nvim-cmp})
                          (pack :github/copilot.vim {:event :InsertCharPre})
                          (pack :lukas-reineke/cmp-under-comparator
                                {:event :InsertCharPre})]
               :config (fn []
                         (local {: setup
                                 : mapping
                                 :config {: compare : disable}
                                 :SelectBehavior {:Insert insert-behavior :Select select-behavior}
                                 : event} (require :cmp))

                         (local types (require :cmp.types))
                         (local under-compare (require :cmp-under-comparator))
                         (local {: insert} table)

                         (let! copilot_no_tab_map true)
                         (let! copilot_assume_mapped true)
                         (let! copilot_tab_fallback "")

                         (setup {:preselect types.cmp.PreselectMode.None
                                 :formatting {:fields [:kind
                                                       :abbr
                                                       :menu]
                                              :format (fn [entry vim-item]
                                                        (set vim-item.menu
                                                             (. {:nvim_lsp :lsp
                                                                 :Path :pth
                                                                 :treesitter :trs
                                                                 :copilot :cop
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
                                 :mapping {:<C-b> (mapping.scroll_docs -4)
                                           :<C-f> (mapping.scroll_docs 4)
                                           :<C-space> (mapping.complete)
                                           :<C-e> (mapping.abort)
                                           :<up> disable
                                           :<down> disable
                                           :<Tab> (mapping (mapping.select_next_item {:behavior insert-behavior})
                                                           [:i :s])
                                           :<S-Tab> (mapping (mapping.select_prev_item {:behavior insert-behavior})
                                                             [:i :s])
                                           :<space> (mapping.confirm {:select false})}
                                 :sources [{:name :nvim_lsp}
                                           {:name :conjure}
                                           {:name :copilot}
                                           {:name :path}]
                                 :sorting {:comparators [compare.offset
                                                         compare.exact
                                                         compare.score
                                                         under-compare.under
                                                         compare.kind
                                                         compare.sort_text
                                                         compare.length
                                                         compare.order]}}))})
