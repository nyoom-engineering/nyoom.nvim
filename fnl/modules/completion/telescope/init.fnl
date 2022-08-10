(import-macros {: use-package! : load-module} :macros.package-macros)

(use-package! :nvim-lua/telescope.nvim
              {:cmd :Telescope
               :config (load-module completion.telescope)
               :requires [(pack :nvim-telescope/telescope-project.nvim
                                {:module :telescope._extensions.project})
                          (pack :nvim-telescope/telescope-ui-select.nvim
                                {:module :telescope._extensions.ui-select})
                          (pack :nvim-telescope/telescope-fzf-native.nvim
                                {:module :telescope._extensions.fzf
                                 :run :make})]})
