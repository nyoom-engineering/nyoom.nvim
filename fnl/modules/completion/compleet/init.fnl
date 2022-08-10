(import-macros {: use-package! : load-module} :macros.package-macros)
(use-package! :shaunsingh/nvim-compleet {:event :InsertEnter :run :./install.sh :config (load-module completion.compleet)})
