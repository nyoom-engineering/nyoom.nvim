(local {: setup} (require :neorg))
(setup {:load {:core.defaults {}
               :core.gtd.base {}
               :core.norg.concealer {}
               :core.norg.qol.toc {}
               :core.norg.completion {:config {:engine :nvim-cmp}}
               :core.norg.dirman {:config {:workspaces {:main "~/org/neorg"}
                                           :autodetect true
                                           :autochdir true}}}})
