(import-macros {: use-package!} :macros)

; Magit for neovim
(use-package! :TimUntersberger/neogit {:call-setup neogit 
                                       :cmd :Neogit})
