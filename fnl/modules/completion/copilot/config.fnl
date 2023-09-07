(import-macros {: nyoom-module-ensure!} :macros)

(nyoom-module-ensure! cmp)
(nyoom-module-ensure! lsp)

(setup :copilot {:cmp {:enabled true}})
