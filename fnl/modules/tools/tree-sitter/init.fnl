(import-macros {: use-package! : pack} :macros)

(use-package! :nvim-treesitter/nvim-treesitter
              {:nyoom-module tools.tree-sitter
               :cmd [:TSInstall
                     :TSUpdate
                     :TSInstallSync
                     :TSUpdateSync
                     :TSBufEnable
                     :TSBufDisable
                     :TSEnable
                     :TSDisable
                     :TSModuleInfo]
               :requires [(pack :nvim-treesitter/playground
                                {:cmd :TSPlayground})
                          (pack :p00f/nvim-ts-rainbow {:opt true})
                          (pack :JoosepAlviste/nvim-ts-context-commentstring {:opt true})
                          (pack :nvim-treesitter/nvim-treesitter-refactor {:opt true})
                          (pack :nvim-treesitter/nvim-treesitter-textobjects
                                {:opt true})]
               :setup (fn []
                        (vim.api.nvim_create_autocmd [:BufRead]
                                                     {:group (vim.api.nvim_create_augroup :nvim-treesitter
                                                                                          {})
                                                      :callback (fn []
                                                                  (when (fn []
                                                                          (local file
                                                                                 (vim.fn.expand "%"))
                                                                          (and (and (not= file
                                                                                          :NvimTree_1)
                                                                                    (not= file
                                                                                          "[packer]"))
                                                                               (not= file
                                                                                     "")))
                                                                    (vim.api.nvim_del_augroup_by_name :nvim-treesitter)
                                                                    ((. (autoload :packer)
                                                                        :loader) :nvim-treesitter)))}))})
