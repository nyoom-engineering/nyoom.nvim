(import-macros {: use-package!} :macros)

; show hex codes as virtualtext
(use-package! :brenoprata10/nvim-highlight-colors {:call-setup nvim-highlight-colors 
                                                   :cmd :HighlightColorsToggle})
