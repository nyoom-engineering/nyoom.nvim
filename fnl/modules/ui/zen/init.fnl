(import-macros {: use-package!} :macros)

; distraction free writing
(use-package! :Pocco81/true-zen.nvim
              {:call-setup true-zen
               :cmd [:TZAtaraxis :TZNarrow :TZFocus :TZMinimalist :TZAtaraxis]})
