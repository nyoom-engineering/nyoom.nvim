(import-macros {: use-package!} :macros)

(use-package! :nvim-neorg/neorg {:nyoom-module lang.neorg 
                                 :ft :norg 
                                 :after :nvim-treesitter
                                 :requires [(pack :jbyuki/nabla.nvim {:opt true})]})
