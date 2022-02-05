(module treesitter {require-macros [macros]})

(opt- nvim-treesitter.configs setup
      {:ensure_installed {1 :fennel 2 :lua}
       :highlight {:enable true :use_languagetree true}
       :indent {:enable true}
       :incremental_selection {:enable true
                               :keymaps {:init_selection :gnn
                                         :node_decremental :grm
                                         :node_incremental :grn
                                         :scope_incremental :grc}}})

; show highlight
(nno- :<Leader>h ":TSHighlightCapturesUnderCursor<CR>")
