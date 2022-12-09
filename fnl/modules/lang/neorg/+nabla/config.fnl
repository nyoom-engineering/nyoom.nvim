(import-macros {: map!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: enable_virt : popup} (autoload :nabla))

(map! [n] :<leader>ov `(enable_virt))
(map! [n] :<leader>op `(popup {:border :solid}))
