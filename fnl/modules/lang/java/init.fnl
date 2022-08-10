(import-macros {: use-package! : load-module} :macros.package-macros)

(use-package! :mfussenegger/nvim-jdtls {:ft :java :config (load-module lang.java)})
