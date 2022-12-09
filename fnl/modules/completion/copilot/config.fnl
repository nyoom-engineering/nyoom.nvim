(import-macros {: nyoom-module-ensure!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))

(nyoom-module-ensure! cmp)
(nyoom-module-ensure! lsp)

(setup :copilot {:cmp {:enabled true}})
