(module au ; autocommands
        {require-macros [macros]})

; highlight on yank
(aug- highlightOnYank
      (auc- TextYankPost * "silent! lua vim.highlight.on_yank()"))


