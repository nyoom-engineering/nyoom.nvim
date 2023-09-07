(import-macros {: nyoom-module-p! : nyoom-module-ensure!} :macros)

;; debugging

(var bundles {})

(nyoom-module-p! debugger
                 (do
                   (local java-debug-path
                          (vim.fn.expand "~/.local/share/nvim/mason/packages/java-debug-adapter/"))
                   (local java-test-path
                          (vim.fn.expand "~/.local/share/nvim/mason/packages/java-test/"))
                   (set bundles
                        [(vim.fn.glob (.. java-debug-path
                                          :com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar)
                                      1)])
                   (vim.list_extend bundles
                                    (vim.split (vim.fn.glob (.. java-test-path
                                                                :server/*.jar)
                                                            1)
                                               "\n"))))

;; jdtls is quirky, configure it via nvim-jdtls

(nyoom-module-p! lsp
                 (do
                   ;; needs mason because installing this is a mess and has to be hardcoded for self-installed jdtls.
                   (nyoom-module-ensure! mason)
                   (local {: on-attach} (autoload :modules.tools.lsp.config))
                   (local {: start_or_attach
                           : extendedClientCapabilities
                           : setup_dap}
                          (autoload :jdtls))
                   (local {: find_root : add_commands} (autoload :jdtls.setup))
                   (local {: setup_dap_main_class_configs}
                          (autoload :jdtls.setup))
                   (local jdtls-path
                          (vim.fn.expand "~/.local/share/nvim/mason/packages/jdtls"))
                   (local workspace-dir
                          (vim.fn.fnamemodify (vim.fn.getcwd) ":p:h:t"))
                   (local capabilities
                          (vim.lsp.protocol.make_client_capabilities))
                   (local extended-client-capabilities
                          extendedClientCapabilities)
                   (set extended-client-capabilities.resolveAdditionalTextEditsSupport
                        true)
                   (set extended-client-capabilities.document_formatting false)

                   (fn get-os []
                     (: (: (. (vim.loop.os_uname) :sysname) :lower) :gsub
                        :darwin :mac))

                   (local operating-system (get-os))
                   (start_or_attach {:on_attach (fn [client bufnr]
                                                  (on-attach client bufnr)
                                                  (setup_dap {:hotcodereplace :auto})
                                                  (add_commands))
                                     :settings {:java {:eclipse {:downloadSources true}
                                                       :maven {:downloadSources true}
                                                       :signatureHelp {:enabled true}
                                                       :contentProvider {:preferred :fernflower}
                                                       :saveActions {:organizeImports true}
                                                       :implementationsCodeLens {:enabled true}
                                                       :referencesCodeLens {:enabled true}
                                                       :references {:includeDecompiledSources true}
                                                       :inlayHints {:parameterNames {:enabled :all}}
                                                       :format {:enabled true}
                                                       :symbols {:includeSourceMethodDeclarations true}
                                                       :inlayhints {:parameterNames {:enabled true}}
                                                       :completion {:maxResults 20
                                                                    :favoriteStaticMembers [:org.hamcrest.MatcherAssert.assertThat
                                                                                            :org.hamcrest.Matchers.*
                                                                                            :org.hamcrest.CoreMatchers.*
                                                                                            :org.junit.jupiter.api.Assertions.*
                                                                                            :java.util.Objects.requireNonNull
                                                                                            :java.util.Objects.requireNonNullElse
                                                                                            :org.mockito.Mockito.*]}}
                                                :codeGeneration {:generateComments true
                                                                 :toString {:template "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"}
                                                                 :useBlocks true}
                                                :flags {:debounce_text_changes 150
                                                        :allow_incremental_sync true}}
                                     :root_dir (find_root [:.git
                                                           :mvnw
                                                           :gradlew
                                                           :settings.gradle
                                                           :build.gradle])
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
                                           (.. jdtls-path :/config_
                                               operating-system)
                                           :-data
                                           (vim.fn.expand (.. "~/java/workspaces/"
                                                              workspace-dir))
                                           :--add-modules=ALL-SYSTEM
                                           "--add-opens java.base/java.util=ALL-UNNAMED"
                                           "--add-opens java.base/java.lang=ALL-UNNAMED"]
                                     : capabilities
                                     :init_options {:jvm_args (.. "-javaagent:"
                                                                  (vim.fn.expand "~/.local/share/nvim/mason/packages/jdtls/lombok.jar"))
                                                    : bundles
                                                    :extendedClientCapabilities extended-client-capabilities}
                                     :single_file_support true})))
