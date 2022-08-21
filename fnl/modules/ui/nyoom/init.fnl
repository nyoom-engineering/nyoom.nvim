(import-macros {: use-package!} :macros)

(use-package! :shaunsingh/oxocarbon.nvim {:run :./install.sh})
(use-package! :kyazdani42/nvim-web-devicons {:module :nvim-web-devicons})
(use-package! :mvllow/modes.nvim {:defer modes.nvim
                                  :nyoom-module ui.nyoom})
