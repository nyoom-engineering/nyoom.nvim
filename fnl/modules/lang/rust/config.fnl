(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))

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

(setup :rust-tools {: tools})
