;; atm this is specific to me
(local project-name (vim.fn.fnamemodify (vim.fn.getcwd) ":p:h:t"))
(local workspace-dir (.. :/Users/shauryasingh/Projects project-name))
(local config {:cmd [:java
                     :-Declipse.application=org.eclipse.jdt.ls.core.id1
                     :-Dosgi.bundles.defaultStartLevel=4
                     :-Declipse.product=org.eclipse.jdt.ls.core.product
                     :-Dlog.protocol=true
                     :-Dlog.level=ALL
                     :-Xms1g
                     :--add-modules=ALL-SYSTEM
                     :--add-opens
                     :java.base/java.util=ALL-UNNAMED
                     :--add-opens
                     :java.base/java.lang=ALL-UNNAMED
                     :-jar
                     :/Users/shauryasingh/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar
                     :-configuration
                     :/Users/shauryasingh/.local/share/nvim/lsp_servers/jdtls/config_mac
                     :-data
                     workspace-dir]})

((. (require :jdtls) :start_or_attach) config)
