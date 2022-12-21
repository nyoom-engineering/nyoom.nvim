(import-macros {: packadd! : set! : map! : nyoom-module-ensure!} :macros)

(nyoom-module-ensure! tree-sitter)
(packadd! promise-async)

(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
(local {: openAllFolds : closeAllFolds} (autoload :ufo))

(set! foldcolumn :1)
(set! foldlevel 99)
(set! foldlevelstart 99)
(set! foldenable true)

(map! [n] :zR `(openAllFolds) {:desc "Open all folds"})
(map! [n] :zM `(closeAllFolds {:desc "Close all folds"}))

(setup :ufo {:provider_selector (fn [bufnr filetype buftype]
                                  [:treesitter :indent])})
