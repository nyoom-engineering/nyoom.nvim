(import-macros {: set! : nyoom-module-p!} :macros)
(local cmp (require :cmp))
(local luasnip (require :luasnip))

(set! completeopt [:menu :menuone :noselect])

;; set the cmp sources, but keep it conditioned on the modules
 (local src [])
 (nyoom-module-p! lsp (table.insert src {:name :nvim_lsp}))

 (nyoom-module-p! rust (table.insert src {:name :crates}))

 (nyoom-module-p! eval (table.insert src {:name :conjure}))

 ;; add general cmp sources
 (table.insert src {:name :luasnip})
 (table.insert src {:name :buffer})
 (table.insert src {:name :path})

;; default icons (lspkind)
(local icons {:Text ""
              :Method ""
              :Function ""
              :Constructor "⌘"
              :Field "ﰠ"
              :Variable ""
              :Class "ﴯ"
              :Interface ""
              :Module ""
              :Unit "塞"
              :Property "ﰠ"
              :Value ""
              :Enum ""
              :Keyword "廓"
              :Snippet ""
              :Color ""
              :File ""
              :Reference ""
              :Folder ""
              :EnumMember ""
              :Constant ""
              :Struct "פּ"
              :Event ""
              :Operator ""
              :TypeParameter ""})

(cmp.setup {:experimental {:ghost_text true}
            :window {:documentation {:border :solid} :completion {:border :solid}}
            :preselect cmp.PreselectMode.None
            :snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
            :mapping {"<C-b>" (cmp.mapping.scroll_docs -4)
                      "<C-f>" (cmp.mapping.scroll_docs 4)
                      "<C-space>" (cmp.mapping.complete)
                      "<C-e>" (cmp.mapping.close)
                      "<up>" cmp.config.disable
                      "<down>" cmp.config.disable
                      "<Tab>" (cmp.mapping
                                (fn [fallback]
                                  (if (cmp.visible) (cmp.select_next_item)
                                    (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
                                    (fallback)))
                                [:i :s])
                      "<S-Tab>" (cmp.mapping
                                  (fn [fallback]
                                    (if (cmp.visible) (cmp.select_prev_item)
                                      (luasnip.jumpable -1) (luasnip.jump -1)
                                      (fallback)))
                                  [:i :s])
                      "<space>" (cmp.mapping.confirm {:select false})}
            :sources src
            :formatting {:fields {1 :kind 2 :abbr 3 :menu}
                         :format (fn [_ vim-item]
                                   (set vim-item.menu vim-item.kind)
                                   (set vim-item.kind (. icons vim-item.kind))
                                   vim-item)}})

;; Enable command-line completions
(cmp.setup.cmdline "/" {:mapping (cmp.mapping.preset.cmdline)
                        :sources [{:name :buffer}]})

;; Enable search completions
(cmp.setup.cmdline ":" {:mapping (cmp.mapping.preset.cmdline)
                        :sources [{:name :path}
                                  {:name :cmdline}]})

;; snippets
((. (require "luasnip.loaders.from_vscode") :lazy_load))
