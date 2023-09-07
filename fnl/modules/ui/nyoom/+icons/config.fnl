(import-macros {: packadd!} :macros)

(packadd! nvim-material-icon)
(local material-icons (autoload :nvim-material-icon))

(setup :nvim-web-devicons {:override (material-icons.get_icons)})
