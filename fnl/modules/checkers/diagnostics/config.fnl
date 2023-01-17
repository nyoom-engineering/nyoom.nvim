(import-macros {: nyoom-module-p! : nyoom-module-ensure!} :macros)
(local {: on-attach} (autoload :modules.tools.lsp.config))
(local {: diagnostic-icons} (autoload :core.shared))
(local null-ls (autoload :null-ls))
(local null-ls-sources [])

(nyoom-module-ensure! lsp)

(let [{: config : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           :virtual_text false
           :update_in_insert true
           :severity_sort true
           :float {:show_header false :border :rounded}})
  (sign_define :DiagnosticSignError
               {:text (. diagnostic-icons 1) :texthl :DiagnosticSignError})
  (sign_define :DiagnosticSignWarn
               {:text (. diagnostic-icons 2) :texthl :DiagnosticSignWarn})
  (sign_define :DiagnosticSignInfo
               {:text (. diagnostic-icons 3) :texthl :DiagnosticSignInfo})
  (sign_define :DiagnosticSignHint
               {:text (. diagnostic-icons 4) :texthl :DiagnosticSignHint}))

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
