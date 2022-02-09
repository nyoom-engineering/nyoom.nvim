(module neorg_con {require-macros [macros]})

(def neorg_leader :<Leader>n)
(opt- neorg setup
      {:load {:core.defaults {}
              :core.norg.concealer {}
              :core.norg.qol.toc {}
              :core.norg.dirman {:config {:workspaces {:main "~/org/neorg"}
                                          :autodetect true
                                          :autochdir true}}}})
