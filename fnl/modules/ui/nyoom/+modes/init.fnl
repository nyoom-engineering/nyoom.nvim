(import-macros {: use-package!} :macros)

(use-package! :mvllow/modes.nvim
              {:event :BufWinEnter :nyoom-module ui.nyoom.+modes})
