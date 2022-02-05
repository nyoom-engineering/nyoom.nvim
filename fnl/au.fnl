(module au ; autocommands
        {require-macros [macros]})

; highlight on yank
(aug- highlightOnYank
      (auc- TextYankPost * "silent! lua vim.highlight.on_yank()"))

; terminal settings
(aug- terminalSettings (auc- TermOpen * "setlocal nonumber")
      (auc- TermOpen * "setlocal relativenumber!")
      (auc- TermOpen * "setlocal nospell")
      (auc- TermOpen * "setlocal bufhidden=hide"))

; apply suffixes to all files directly
(aug- suffixAdd
      (let [ext (vim.fn.expand "%:e")]
        (auc- FileType ext (.. "setlocal suffixesadd=." ext))))
