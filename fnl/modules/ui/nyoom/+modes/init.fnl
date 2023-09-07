(import-macros {: use-package!} :macros)

(use-package! :mvllow/modes.nvim
              {:event :InsertEnter :nyoom-module ui.nyoom.+modes})
