(import-macros {: use-package! : call-setup} :macros.package-macros)

(use-package! :TimUntersberger/neogit {:config (call-setup neogit) :cmd :Neogit})
