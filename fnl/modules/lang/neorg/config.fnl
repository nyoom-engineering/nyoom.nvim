(import-macros {: nyoom-module-p!} :macros)
(local {: setup} (require :neorg))

(setup {:load {:core.defaults {}
               :core.norg.qol.toc {}
               :core.norg.concealer {}
               :core.gtd.base {:config {:workspace :main}}
               :core.norg.completion {:config {:engine :nvim-cmp}}
               :core.norg.dirman {:config {:workspaces {:main "~/org/neorg"}
                                           :autodetect true
                                           :autochdir true}}}})
