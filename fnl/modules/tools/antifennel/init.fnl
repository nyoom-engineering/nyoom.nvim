(import-macros {: use-package!} :macros)

;; This isn't an actual plugin, we're just using packer to download the antifennel binary
(use-package! "https://git.sr.ht/~technomancy/antifennel" {:nyoom-module tools.antifennel
                                                           :run "make"})
