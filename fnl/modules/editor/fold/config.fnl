(import-macros {: packadd! : set! : map! : nyoom-module-p!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: openAllFolds : closeAllFolds : setup} (autoload :ufo))

(packadd! promise-async)

(set! foldcolumn :1)
(set! foldlevel 99)
(set! foldlevelstart 99)
(set! foldenable true)

(map! [n] :zR '(openAllFolds))
(map! [n] :zM '(closeAllFolds))

(setup (nyoom-module-p! tree-sitter
            {:provider_selector (fn [bufnr filetype buftype]
                                  [:treesitter :indent])}))
