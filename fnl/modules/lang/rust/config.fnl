(local {: setup} (require :rust-tools))

(setup {:tools {:server {:settings {:rust-analyzer {:checkOnSave {:command :clippy}}}}
                :hover_actions {:border [[" " :FloatBorder]
                                         [" " :FloatBorder]
                                         [" " :FloatBorder]
                                         [" " :FloatBorder]
                                         [" " :FloatBorder]
                                         [" " :FloatBorder]
                                         [" " :FloatBorder]
                                         [" " :FloatBorder]]}
                :crate_graph {:backend :svg}}})
