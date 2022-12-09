(import-macros {: packadd!} :macros)
(local {: autoload} (require :core.lib.autoload))

(packadd! nvim-material-icon)
(local web-devicons (autoload :nvim-web-devicons))
(local material-icons (autoload :nvim-material-icon))

(web-devicons.setup {:override (material-icons.get_icons)})
