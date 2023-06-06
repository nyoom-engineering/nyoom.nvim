(import-macros {: set! : nyoom-module-p! : packadd!} :macros)
(local cmp (autoload :cmp))
(local luasnip (autoload :luasnip))

;; vim settings

(set! completeopt [:menu :menuone :noselect])

;; add general cmp sources

(local cmp-sources [])

(table.insert cmp-sources {:name :luasnip :group_index 1})
(table.insert cmp-sources {:name :buffer :group_index 2})
(table.insert cmp-sources {:name :path :group_index 2})
(table.insert cmp-sources {:name :path :group_index 2})

(nyoom-module-p! rust (table.insert cmp-sources {:name :crates :group_index 1}))
(nyoom-module-p! neorg (table.insert cmp-sources {:name :neorg :group_index 1}))
(nyoom-module-p! eval
                 (table.insert cmp-sources {:name :conjure :group_index 1}))

(nyoom-module-p! lsp (do
                       (table.insert cmp-sources
                                     {:name :nvim_lsp :group_index 1})
                       (table.insert cmp-sources
                                     {:name :nvim_lsp_signature_help
                                      :group_index 1})))

(nyoom-module-p! copilot
                 (do
                   (packadd! copilot-cmp)
                   (setup :copilot_cmp)
                   (table.insert cmp-sources {:name :copilot :group_index 2})))

;; copilot uses lines above/below current text which confuses cmp, fix:

(fn has-words-before []
  (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))]
    (and (not= col 0) (= (: (: (. (vim.api.nvim_buf_get_lines 0 (- line 1) line
                                                              true)
                                  1) :sub col
                               col) :match "%s") nil))))

(setup :cmp {:experimental {:ghost_text true}
             :window {:documentation {:border :solid}
                      :completion {:col_offset (- 3)
                                   :side_padding 0
                                   :winhighlight "Normal:NormalFloat,NormalFloat:Pmenu,Pmenu:NormalFloat"}}
             :view {:entries {:name :custom :selection_order :near_cursor}}
             :enabled (fn []
                        (local context (autoload :cmp.config.context))
                        (nyoom-module-p! tree-sitter
                                         (if (= (. (vim.api.nvim_get_mode)
                                                   :mode)
                                                :c)
                                             true
                                             (and (not (context.in_treesitter_capture :comment))
                                                  (not (context.in_syntax_group :Comment))))))
             :preselect cmp.PreselectMode.None
             :snippet {:expand (fn [args]
                                 (luasnip.lsp_expand args.body))}
             :mapping {:<C-b> (cmp.mapping.scroll_docs -4)
                       :<C-f> (cmp.mapping.scroll_docs 4)
                       :<C-Space> (cmp.mapping.complete)
                       :<C-p> (cmp.mapping.select_prev_item)
                       :<C-n> (cmp.mapping.select_next_item)
                       :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert
                                                   :select false})
                       :<C-e> (fn [fallback]
                                (if (cmp.visible)
                                    (do
                                      (cmp.mapping.close)
                                      (vim.cmd :stopinsert))
                                    (fallback)))
                       :<Tab> (cmp.mapping (fn [fallback]
                                             (if (cmp.visible)
                                                 (cmp.select_next_item)
                                                 (luasnip.expand_or_jumpable)
                                                 (luasnip.expand_or_jump)
                                                 (has-words-before)
                                                 (cmp.complete)
                                                 :else
                                                 (fallback)))
                                           [:i :s :c])
                       :<S-Tab> (cmp.mapping (fn [fallback]
                                               (if (cmp.visible)
                                                   (cmp.select_prev_item)
                                                   (luasnip.jumpable -1)
                                                   (luasnip.jump -1)
                                                   :else
                                                   (fallback)))
                                             [:i :s :c])}
             :sources cmp-sources
             :formatting {:fields {1 :kind 2 :abbr 3 :menu}
                          :format (fn [_ vim-item]
                                    (set vim-item.menu vim-item.kind)
                                    (set vim-item.kind (. shared.codicons vim-item.kind))
                                    vim-item)}})

;; Enable command-line completions

(cmp.setup.cmdline "/"
                   {:mapping (cmp.mapping.preset.cmdline)
                    :sources [{:name :buffer :group_index 1}]})

;; Enable search completions

(cmp.setup.cmdline ":"
                   {:mapping (cmp.mapping.preset.cmdline)
                    :sources [{:name :path} {:name :cmdline :group_index 1}]})

;; copilot menus

(nyoom-module-p! copilot (cmp.event:on :menu_opened
                                       (fn []
                                         (set vim.b.copilot_suggestion_hidden
                                              true)))
                 (cmp.event:on :menu_closed
                               (fn []
                                 (set vim.b.copilot_suggestion_hidden false))))

;; snippets

((. (autoload :luasnip.loaders.from_vscode) :lazy_load))
