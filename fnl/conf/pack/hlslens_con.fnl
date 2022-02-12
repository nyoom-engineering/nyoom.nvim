(import-macros {: map!} :conf.macros)

(map! [nvo :silent] :n
      "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require'hlslens'.start()<cr>")
(map! [nvo :silent] :N
      "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require'hlslens'.start()<cr>")
(map! [nvo] "*" "*<cmd>lua require'hlslens'.start()<cr>")
(map! [nvo] "#" "#<cmd>lua require'hlslens'.start()<cr>")
(map! [nvo] :g* "g*<cmd>lua require'hlslens'.start()<cr>")
(map! [nvo] "g#" "g#<cmd>lua require'hlslens'.start()<cr>" "Clear highlight")
