(import-macros {: packadd!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (autoload :headlines))
(setup {:org {:headline_highlights false}})

(packadd! org-bullets.nvim)
(local {: setup} (autoload :org-bullets))
(setup {:concealcursor true})
