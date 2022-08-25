(import-macros {: use-package!} :macros)

(use-package! :lukas-reineke/headlines.nvim {:nyoom-module lang.org.+pretty
                                             :ft :org
                                             :requires (pack :akinsho/org-bullets.nvim {:opt true})})
