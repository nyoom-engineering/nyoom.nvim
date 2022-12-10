(local {: autoload} (require :core.lib.autoload))
(local {: setup} (autoload :core.lib.setup))

(setup :modes {:colors {:insert "#be95ff"
                        :delete "#ff7eb6"
                        :visual "#82cfff"
                        :copy "#42be65"}})
