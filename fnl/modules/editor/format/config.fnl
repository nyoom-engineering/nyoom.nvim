(local {: setup} (require :formatter))

(setup {:filetype {:c [(. (require :formatter.filetypes.c) :clangformat)]
                   :cpp [(. (require :formatter.filetypes.cpp) :clangformat)]
                   :lua [(. (require :formatter.filetypes.lua) :stylua)]
                   :rust [(. (require :formatter.filetypes.rust) :rustfmt)]
                   :markdown [(. (require :formatter.filetypes.markdown) :prettier)]
                   :sh [(. (require :formatter.filetypes.sh) :shfmt)]
                   :python [(. (require :formatter.filetypes.python) :yapf)]
                   :zig [(. (require :formatter.filetypes.zig) :zigfmt)]}})
