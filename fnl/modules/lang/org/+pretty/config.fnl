(import-macros {: packadd!} :macros)
(packadd! org-bullets.nvim)

(setup :headlines {:org {:headline_highlights false}})
(setup :org-bullets {:concealcursor true})
