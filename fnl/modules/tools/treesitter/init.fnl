(import-macros {: use-package! : pack : load-module} :macros.package-macros)
(local treesitter-cmds [:TSInstall
                        :TSBufEnable
                        :TSBufDisable
                        :TSEnable
                        :TSDisable
                        :TSModuleInfo])

(use-package! :nvim-treesitter/nvim-treesitter
              {:run ":TSUpdate"
               :cmd treesitter_cmds
               :module :nvim-treesitter
               :config (load-module tools.treesitter)
               :setup (fn []
                       ((. (require :utils.lazy-load)
                           :load-on-file-open!) :nvim-treesitter))
               :requires [(pack :nvim-treesitter/playground {:cmd :TSPlayground})
                          (pack :p00f/nvim-ts-rainbow {:after :nvim-treesitter})
                          (pack :nvim-treesitter/nvim-treesitter-textobjects {:after :nvim-treesitter})]})




