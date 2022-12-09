(import-macros {: packadd! : nyoom-module-p! : nyoom-module-ensure!} :macros)

(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))

;; conditional modules

(local neorg-modules
       {:core.defaults {}
        :core.norg.manoeuvre {}
        :core.gtd.base {:config {:workspace :main}}
        :core.norg.dirman {:config {:workspaces {:main "~/neorg"}}}})

;; add conditional modules

(nyoom-module-p! cmp (tset neorg-modules :core.norg.completion
                           {:config {:engine :nvim-cmp}}))

;; add flaged modules

(nyoom-module-p! neorg.+pretty
                 (tset neorg-modules :core.norg.concealer
                       {:config {:icon_preset :varied}}))

(nyoom-module-p! neorg.+present
                 (do
                   (nyoom-module-ensure! zen)
                   (tset neorg-modules :core.presenter
                         {:config {:zen_mode :truezen}})))

(nyoom-module-p! neorg.+export
                 (do
                   (tset neorg-modules :core.export {})
                   (tset neorg-modules :core.export.markdown
                         {:config {:extensions :all}})))

(setup :neorg {:load neorg-modules})
