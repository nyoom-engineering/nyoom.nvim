(import-macros {: use-package! : pack : rock!} :macros)

(use-package! :dgrbrady/nvim-docker {:nyoom-module tools.docker
                                     :keys :<leader>c
                                     :requires [(pack :MunifTanjim/nui.nvim {:opt true})]})

(rock! :404/reactivex)




