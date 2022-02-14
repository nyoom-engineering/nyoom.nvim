(import-macros {: use-package!} :conf.macros)

(use-package! :nvim-neorg/neorg
              {:ft :norg
               :after :nvim-treesitter
               :config (fn []
                         (local {: setup} (require :neorg))
                         (setup {:load {:core.defaults {}
                                        :core.norg.concealer {}
                                        :core.norg.qol.toc {}
                                        :core.norg.completion {:config {:engine :nvim-cmp}}
                                        :core.norg.dirman {:config {:workspaces {:main "~/org/neorg"}
                                                                    :autodetect true
                                                                    :autochdir true}}}}))})
