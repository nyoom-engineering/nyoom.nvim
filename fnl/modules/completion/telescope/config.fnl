(import-macros {: packadd! : map! : nyoom-module-p!} :macros)
(local {: setup : load_extension} (require :telescope))

(setup {:defaults {:prompt_prefix "   "
                   :selection_caret "  "
                   :entry_prefix "  "
                   :sorting_strategy :ascending
                   :layout_strategy :flex
                   :layout_config {:horizontal {:prompt_position :top
                                                :preview_width 0.55}
                                   :vertical {:mirror false}
                                   :width 0.87
                                   :height 0.8
                                   :preview_cutoff 120}
                   :set_env {:COLORTERM :truecolor}
                   :dynamic_preview_title true}
        :extensions {:project {:base_dirs ["~/.config/nvim"]}}})

;; Load extensions
(packadd! telescope-ui-select.nvim)
(packadd! telescope-fzf-native.nvim)
(packadd! telescope-ghq.nvim)

(packadd! telescope-project.nvim)
(load_extension :project)
(load_extension :ghq)
(load_extension :ui-select)

(nyoom-module-p! telescope.+native
  (do
    (packadd! telescope-fzf-native.nvim)
    (load_extension :fzf)))

(nyoom-module-p! lsp
  (do
    (local {:lsp_implementations open-impl-float!
            :lsp_references open-ref-float!
            :diagnostics open-diag-float!
            :lsp_document_symbols open-local-symbol-float!
            :lsp_workspace_symbols open-workspace-symbol-float!} (require :telescope.builtin))
    (map! [n] "<leader>li" open-impl-float!)
    (map! [n] "<leader>lr" open-ref-float!)
    (map! [n] "<leader>ls" open-local-symbol-float!)
    (map! [n] "<leader>lS" open-workspace-symbol-float!)))

(nyoom-module-p! syntax
  (do
    (local {:diagnostics open-diag-float!} (require :telescope.builtin))
    (map! [n] "<leader>ld" '(open-diag-float! {:bufnr 0}))
    (map! [n] "<leader>lD" open-diag-float!)))
