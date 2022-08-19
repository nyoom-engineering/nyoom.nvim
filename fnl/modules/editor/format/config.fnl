(import-macros {: nyoom-module-p!} :macros)
(local {: setup} (require :formatter))

(setup {:filetype {:lua [(. (require :formatter.filetypes.lua) :stylua)]
                   :rust [(. (require :formatter.filetypes.rust) :rustfmt)]
                   :markdown [(. (require :formatter.filetypes.markdown) :prettier)]
                   :sh [(. (require :formatter.filetypes.sh) :shfmt)]}})
