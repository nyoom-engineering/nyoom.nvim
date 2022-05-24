(local {: setup} (require :colorizer))

(setup ["*"] {:RGB true
              :names true
              :RRGGBB true
              :rgb_fn true
              :RRGGBBAA true
              :hsl_fn true
              :mode :foreground})
