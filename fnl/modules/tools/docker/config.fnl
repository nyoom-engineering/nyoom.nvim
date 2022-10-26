(import-macros {: map!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: list_containers} (autoload :nvim-docker))

(map! [n] :<leader>c '(list_containers) {:desc "List Docker Containers"})
