(local {: config} (require :luasnip))
(local {: load} (require :luasnip/loaders/from_vscode))

(config.set_config {:history true :updateevents "TextChanged,TextChangedI"})

;; Load snippets
(load)
