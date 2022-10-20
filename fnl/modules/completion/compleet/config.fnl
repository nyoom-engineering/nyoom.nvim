(local {: autoload} (require :core.lib.autoload))
(local {: setup} (autoload :nvim_completion))

(setup {:sources {:lsp {:enable true}}})

