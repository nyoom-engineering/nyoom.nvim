(import-macros {: use-package! : load-module} :macros.package-macros)

(use-package! :kyazdani42/nvim-web-devicons {:module :nvim-web-devicons})
(use-package! :kyazdani42/nvim-tree.lua {:cmd :NvimTreeToggle :config (load-module ui.nvimtree)})
