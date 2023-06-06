(import-macros {: nyoom-module-p!} :macros)

(nyoom-module-p! lsp
  (do
    (local tools {:server {:settings {:rust-analyzer {:checkOnSave {:command :clippy}}}}
                  :hover_actions {:border [[" " :FloatBorder]
                                           [" " :FloatBorder]
                                           [" " :FloatBorder]
                                           [" " :FloatBorder]
                                           [" " :FloatBorder]
                                           [" " :FloatBorder]
                                           [" " :FloatBorder]
                                           [" " :FloatBorder]]}
                  :crate_graph {:backend :svg}})
    (setup :rust-tools {: tools})))
