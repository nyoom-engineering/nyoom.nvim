(import-macros {: packadd!} :macros)
(packadd! org-bullets.nvim)

(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))

(setup :headlines {:org {:headline_highlights false}})
(setup :org-bullets {:concealcursor true})
