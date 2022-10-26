(import-macros {: use-package!} :macros)

(use-package! :noib3/nvim-completion {:nyoom-module completion.compleet
                                      :event [:InsertEnter]
                                      :run :./install.sh})
