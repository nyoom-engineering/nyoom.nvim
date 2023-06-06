(import-macros {: nyoom-module-p! : nyoom-module-ensure!} :macros)
(local {: on-attach} (autoload :modules.tools.lsp.config))
(local null-ls (autoload :null-ls))
(local null-ls-sources [])

(nyoom-module-ensure! lsp)

(vim.diagnostic.config {:underline {:severity {:min vim.diagnostic.severity.INFO}}
                        :signs {:severity {:min vim.diagnostic.severity.HINT}}
                        :virtual_text false
                        :float {:show_header false
                                :source true}
                        :update_in_insert false
                        :severity_sort true})

(vim.fn.sign_define :DiagnosticSignError {:text shared.icons.error :texthl "DiagnosticSignError"})
(vim.fn.sign_define :DiagnosticSignWarn {:text shared.icons.warn :texthl "DiagnosticSignWarn"})
(vim.fn.sign_define :DiagnosticSignInfo {:text shared.icons.info :texthl "DiagnosticSignInfo"})
(vim.fn.sign_define :DiagnosticSignHint {:text shared.icons.hint :texthl "DiagnosticSignHint"})

(nyoom-module-p! config.+bindings
                 (do
                   (local {:open_float open-line-diag-float!
                           :goto_prev goto-diag-prev!
                           :goto_next goto-diag-next!}
                          vim.diagnostic)
                   (map! [n] :<leader>d open-line-diag-float!
                         {:desc "Open diagnostics at line"})
                   (map! [n] "[d" goto-diag-prev!
                         {:desc "Goto previous diagonstics"})
                   (map! [n] "]d" goto-diag-next!
                         {:desc "Goto next diagnostics"})))

(nyoom-module-p! format
                 (do
                   ;; (table.insert null-ls-sources null-ls.builtins.formatting.fnlfmt)
                   (nyoom-module-p! cc
                                    (table.insert null-ls-sources
                                                  null-ls.builtins.formatting.clang_format))
                   (nyoom-module-p! clojure
                                    (table.insert null-ls-sources
                                                  null-ls.builtins.formatting.zprint))
                   (nyoom-module-p! java
                                    (table.insert null-ls-sources
                                                  null-ls.builtins.formatting.google_java_format))
                   (nyoom-module-p! kotlin
                                    (table.insert null-ls-sources
                                                  null-ls.builtins.formatting.ktlint))
                   (nyoom-module-p! lua
                                    (table.insert null-ls-sources
                                                  null-ls.builtins.formatting.stylua))
                   (nyoom-module-p! markdown
                                    (table.insert null-ls-sources
                                                  null-ls.builtins.formatting.markdownlint))
                   (nyoom-module-p! nim
                                    (table.insert null-ls-sources
                                                  null-ls.builtins.formatting.nimpretty))
                   (nyoom-module-p! python
                                    (do
                                      (table.insert null-ls-sources
                                                    null-ls.builtins.formatting.black)
                                      (table.insert null-ls-sources
                                                    null-ls.builtins.formatting.isort)))
                   (nyoom-module-p! rust
                                    (table.insert null-ls-sources
                                                  null-ls.builtins.formatting.rustfmt))
                   (nyoom-module-p! sh
                                    (table.insert null-ls-sources
                                                  null-ls.builtins.formatting.shfmt))
                   (nyoom-module-p! zig
                                    (table.insert null-ls-sources
                                                  null-ls.builtins.formatting.zigfmt))))

(nyoom-module-p! diagnostics
                 (do
                   (nyoom-module-p! lua
                                    (table.insert null-ls-sources
                                                  null-ls.builtins.diagnostics.selene))))

(nyoom-module-p! vc-gutter
                 (table.insert null-ls-sources
                               null-ls.builtins.code_actions.gitsigns))

(null-ls.setup {:sources null-ls-sources
                ;; #{m}: message
                ;; #{s}: source name (defaults to null-ls if not specified)
                ;; #{c}: code (if available
                :diagnostics_format "[#{c}] #{m} (#{s})"
                :debug true
                :on_attach on-attach})
