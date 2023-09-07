(import-macros {: use-package!} :macros)

(use-package! :nvim-tree/nvim-web-devicons
              {:module :nvim-web-devicons
               :nyoom-module ui.nyoom.+icons
               :requires [(pack :DaikyXendo/nvim-material-icon {:opt true})]})
