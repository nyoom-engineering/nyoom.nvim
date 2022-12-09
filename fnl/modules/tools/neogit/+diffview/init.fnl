(import-macros {: use-package!} :macros)

(use-package! :sindrets/diffview.nvim
              {:nyoom-module tools.neogit.+diffview
               :cmd [:DiffviewFileHistory
                     :DiffviewOpen
                     :DiffviewClose
                     :DiffviewToggleFiles
                     :DiffviewFocusFiles
                     :DiffviewRefresh]})
