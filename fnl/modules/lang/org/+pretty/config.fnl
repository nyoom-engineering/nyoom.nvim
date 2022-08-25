(import-macros {: packadd!} :macros)
(local {: setup} (require :headlines))
(setup {:org {:headline_highlights [:HeadlineGreen
                                    :HeadlineBlue
                                    :HeadlineRed
                                    :HeadlinePurple
                                    :HeadlineYellow]}})

(packadd! org-bullets.nvim)
(local {: setup} (require :org-bullets))
(setup {:concealcursor true})
