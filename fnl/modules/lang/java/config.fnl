(import-macros {: nyoom-module-p! : nyoom-module-ensure!} :macros)

;; jdtls is quirky, configure it via nvim-jdtls
(nyoom-module-p! lsp
  (do
   (local {: autoload} (require :core.lib.autoload))

   ;; needs mason because installing this is a mess and has to be hardcoded for self-installed jdtls.
   (nyoom-module-ensure! mason)

   ;; helper functions
   (fn glob-split [pattern filter]
     (var globbed (vim.fn.glob pattern))
     (when (not= filter nil)
       (set globbed (globbed:gsub filter "")))
     (vim.split globbed "\n"))

   (fn get-os []
     (: (: (. (vim.loop.os_uname) :sysname) :lower) :gsub :darwin :mac))

   ;; get paths
   (local jdtls-path (vim.fn.expand "~/.local/share/nvim/mason/packages/jdtls"))
   (local workspace-dir (vim.fn.fnamemodify (vim.fn.getcwd) ":p:h:t"))
   (local operating-system (get-os))

   (local {: on-attach} (autoload :modules.tools.lsp.config))
   (local {: start_or_attach} (autoload :jdtls))
   (local {: find_root} (autoload :jdtls.setup))

   (start_or_attach {:autostart false
                     :filetypes [:java]
                     :on_attach on-attach
                     :settings  {:java {:implementationsCodeLens {:enabled true}
                                        :symbols {:includeSourceMethodDeclarations true}
                                        :signatureHelp {:enabled true}
                                        :saveActions {:organizeImports true}
                                        :referencesCodeLens {:enabled true}
                                        :codeGeneration {:useBlocks true
                                                         :generateComments true
                                                         :hashCodeEquals {:useInstanceof true
                                                                          :useJava7Objects true}}
                                        :inlayhints {:parameterNames {:enabled true}}}}
                     :root_dir (find_root [:.git :mvnw :gradlew])
                     :cmd [:java
                           :-Declipse.application=org.eclipse.jdt.ls.core.id1
                           :-Dosgi.bundles.defaultStartLevel=4
                           :-Declipse.product=org.eclipse.jdt.ls.core.product
                           :-Dlog.level=ALL
                           :-noverify
                           :-Xmx1G
                           :-jar
                           (vim.fn.glob (.. jdtls-path
                                            :/plugins/org.eclipse.equinox.launcher_*.jar))
                           :-configuration
                           (.. jdtls-path :/config_ operating-system)
                           :-data
                           (vim.fn.expand (.. "~/java/workspaces/" workspace-dir))
                           :--add-modules=ALL-SYSTEM
                           "--add-opens java.base/java.util=ALL-UNNAMED"
                           "--add-opens java.base/java.lang=ALL-UNNAMED"]})))
