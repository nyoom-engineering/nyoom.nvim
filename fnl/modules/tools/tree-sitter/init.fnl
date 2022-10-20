(import-macros {: use-package! : pack} :macros)

; highlighting/parsing
(use-package! :nvim-treesitter/nvim-treesitter
              {:nyoom-module tools.tree-sitter
               :cmd [:TSInstall
                     :TSBufEnable
                     :TSBufDisable
                     :TSEnable
                     :TSDisable
                     :TSModuleInfo]
               :run ":TSUpdate"
               :requires [(pack :nvim-treesitter/playground {:cmd :TSPlayground})            ;; view the tree + highlight
                          (pack :p00f/nvim-ts-rainbow {:opt true})                           ;; rainbow parens!
                          (pack :nvim-treesitter/nvim-treesitter-textobjects {:opt true})]   ;; textobjects
               :setup (fn []
                        (local {: autoload} (require :core.lib.autoload))
                        (vim.api.nvim_create_autocmd [:BufRead]
                                 {:group (vim.api.nvim_create_augroup :nvim-treesitter {})
                                  :callback (fn []
                                              (when (fn []
                                                      (local file (vim.fn.expand "%"))
                                                      (and (and (not= file :NvimTree_1)
                                                                (not= file "[packer]"))
                                                           (not= file "")))
                                                (vim.api.nvim_del_augroup_by_name :nvim-treesitter)
                                                ((. (autoload :packer) :loader) :nvim-treesitter)))}))})


