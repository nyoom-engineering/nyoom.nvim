(import-macros {: use-package!} :macros)

; show hex codes as virtualtext
(use-package! :uga-rosa/ccc.nvim {:nyoom-module tools.rgb
                                  :cmd [:CccPick
                                        :CccHighlighterEnable
                                        :CccHighlighterToggle]})
