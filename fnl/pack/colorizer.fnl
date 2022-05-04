(local {: setup} (require :colorizer))

(setup ["*"] {:RGB true
              :RRGGBB true
              :names true
              :RRGGBBAA true
              :rgb_fn true
              :hsl_fn true
              :mode :foreground})
