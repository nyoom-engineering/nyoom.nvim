(import-macros {: packadd! : map! : nyoom-module-p!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup : load_extension} (autoload :telescope))

(setup {:defaults {:selection_caret "  "
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
                   :dynamic_preview_title true}})

;; Load extensions
(packadd! telescope-ui-select.nvim)
(load_extension :ui-select)
(packadd! telescope-file-browser.nvim)
(load_extension :file_browser)

;; only install native if the flag is there
(nyoom-module-p! telescope.+native
  (do
    (packadd! telescope-fzf-native.nvim)
    (load_extension :fzf)))

;; load media-files and zoxide only if their executables exist
(when (= (vim.fn.executable :ueberzug) 1)
  (do
    (packadd! telescope-media-files.nvim)
    (load_extension :media_files)))

(when (= (vim.fn.executable :zoxide) 1)
  (do
    (packadd! telescope-zoxide)
    (load_extension :zoxide)))

(nyoom-module-p! lsp
  (do
    (local {:lsp_implementations open-impl-float!
            :lsp_references open-ref-float!
            :diagnostics open-diag-float!
            :lsp_document_symbols open-local-symbol-float!
            :lsp_workspace_symbols open-workspace-symbol-float!} (autoload :telescope.builtin))
    (map! [n] "<leader>li" open-impl-float!)
    (map! [n] "<leader>lr" open-ref-float!)
    (map! [n] "<leader>ls" open-local-symbol-float!)
    (map! [n] "<leader>lS" open-workspace-symbol-float!)))

(nyoom-module-p! syntax
  (do
    (local {:diagnostics open-diag-float!} (autoload :telescope.builtin))
    (map! [n] "<leader>ld" '(open-diag-float! {:bufnr 0}))
    (map! [n] "<leader>lD" open-diag-float!)))
