(local {: lazy-require!} (require :utils.lazy-require))

(local {: config} (lazy-require! :luasnip))
(local {: load} (lazy-require! :luasnip/loaders/from_vscode))

(config.set_config {:history true :updateevents "TextChanged,TextChangedI"})

;; Load snippets
(load)
