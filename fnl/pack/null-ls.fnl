(local {: setup} (require :null-ls))

(setup {:sources [(. (. (. (require :null-ls) :builtins) :formatting) :stylua)
                  (. (. (. (require :null-ls) :builtins) :diagnostics) :clj_kondo)]})
