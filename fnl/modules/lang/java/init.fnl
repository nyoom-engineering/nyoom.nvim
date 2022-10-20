(import-macros {: use-package!} :macros)

; off-spec language server support for java
(use-package! :mfussenegger/nvim-jdtls {:nyoom-module lang.java
                                        :ft :java}) 

