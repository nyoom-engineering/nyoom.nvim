(import-macros {: packadd! : map!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (autoload :neorg))

(setup {:load {:core.defaults {}
               :core.norg.qol.toc {}
               :core.norg.concealer {}
               :core.gtd.base {:config {:workspace :main}}
               :core.norg.completion {:config {:engine :nvim-cmp}}
               :core.norg.dirman {:config {:workspaces {:main "~/org/neorg"}
                                           :autodetect true
                                           :autochdir true}}}})

(packadd! nabla.nvim)
(local {: enable_virt : popup} (autoload :nabla))

(map! [n] :<leader>ov '(enable_virt))
(map! [n] :<leader>op '(popup {:border :solid}))
