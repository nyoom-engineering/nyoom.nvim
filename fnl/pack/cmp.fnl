(local {: lazy-require!} (require :utils.lazy-require))

(local {: insert} table)
(local {: setup
        : mapping
        : visible
        : complete
        :config {: compare : disable : window}
        :ItemField {:Kind kind :Abbr abbr :Menu menu}
        :SelectBehavior {:Insert insert-behavior :Select select-behavior}
        : event} (lazy-require! :cmp))

(local types (lazy-require! :cmp.types))
(local under-compare (lazy-require! :cmp-under-comparator))

(local {: lsp_expand : expand_or_jump : expand_or_jumpable : jump : jumpable} (lazy-require! :luasnip))

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

;;; Supertab functionality utility functions
(fn has-words-before []
  (let [col (- (vim.fn.col ".") 1)
        ln (vim.fn.getline ".")]
    (or (= col 0) (string.match (string.sub ln col col) "%s"))))

(fn replace-termcodes [code]
  (vim.api.nvim_replace_termcodes code true true true))

;;; Setup
(setup {:preselect types.cmp.PreselectMode.None
        :experimental {:ghost_text true}
        :window {:documentation {:border :rounded} :completion {:border :rounded}}
        :snippet {:expand (fn [args]
                            (lsp_expand args.body))}
        ;; :mapping {:<C-b> (mapping.scroll_docs -4)
        ;;           :<C-f> (mapping.scroll_docs 4)
        ;;           :<C-e> (mapping.abort)
        ;;           :<C-n> (mapping (mapping.select_next_item {:behavior insert-behavior}) [:i :s])
        ;;           :<C-p> (mapping (mapping.select_prev_item {:behavior insert-behavior}) [:i :s])
        ;;           :<Tab> (mapping (fn [fallback]
        ;;                             (if (visible)
        ;;                                 (mapping.select_next_item {:behavior insert-behavior})
        ;;                                 (expand_or_jumpable)
        ;;                                 (expand_or_jump)
        ;;                                 (has-words-before)
        ;;                                 (vim.fn.feedkeys (replace-termcodes :<Tab>)
        ;;                                                  :n)
        ;;                                 (fallback)))
        ;;                           [:i :s :c])
        ;;           :<S-Tab> (mapping (fn [fallback]
        ;;                               (if (visible)
        ;;                                   (mapping.select_prev_item {:behavior insert-behavior})
        ;;                                   (jumpable -1)
        ;;                                   (jump -1)
        ;;                                   (fallback)))
        ;;                             [:i :s :c])
        ;;           :<C-Space> (mapping.confirm {:select true})}
        :sources [{:name :nvim_lsp}
                  {:name :luasnip}
                  {:name :path}
                  {:name :buffer}
                  {:name :conjure}]
                  {:name :buffer :option {:keyword_pattern "\\k\\+"}}
                  {:name :conjure}
                  {:name :copilot}]
        :sorting {:comparators [compare.offset
                                compare.exact
                                compare.score
                                under-compare.under
                                compare.kind
                                compare.sort_text
                                compare.length
                                compare.order]}
        :formatting {:fields {1 :kind 2 :abbr 3 :menu}
                     :format (fn [_ vim-item]
                               (set vim-item.menu vim-item.kind)
                               (set vim-item.kind (. icons vim-item.kind))
                               vim-item)}})
                
;; cmdline setup
(setup.cmdline ":"
               {:view {:separator "|"}
                :mappping (mapping.preset.cmdline)
                :sources [{:name :path} {:name :cmdline}]})
