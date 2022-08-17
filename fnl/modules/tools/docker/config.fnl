(import-macros {: packadd! : nyoom-module-p! : map!} :macros)
(local {: list_containers} (require :nvim-docker))

(map! [n] :<leader>c '(list_containers) {:desc "List Docker Containers"})
