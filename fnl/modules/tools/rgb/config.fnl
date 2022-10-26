(local {: autoload} (require :core.lib.autoload))
(local {: setup} (autoload :ccc))

(setup {:bar_char "■"
        :point_char "◇"
        :win_opts {:border :solid
                   :style :minimal
                   :col 1
                   :row 1
                   :relative :cursor}})
