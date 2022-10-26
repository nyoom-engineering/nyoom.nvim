(local {: autoload} (require :core.lib.autoload))
(local {: setup} (autoload :formatter))

(setup {:filetype {:c [(. (autoload :formatter.filetypes.c) :clangformat)]
                   :cpp [(. (autoload :formatter.filetypes.cpp) :clangformat)]
                   :lua [(. (autoload :formatter.filetypes.lua) :stylua)]
                   :rust [(. (autoload :formatter.filetypes.rust) :rustfmt)]
                   :markdown [(. (autoload :formatter.filetypes.markdown) :prettier)]
                   :sh [(. (autoload :formatter.filetypes.sh) :shfmt)]
                   :python [(. (autoload :formatter.filetypes.python) :yapf)]
                   :zig [(. (autoload :formatter.filetypes.zig) :zigfmt)]}})
