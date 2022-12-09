(import-macros {: nyoom-module-p! : set! : augroup! : autocmd!} :macros)

;; Restore cursor on exit

(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * `(set! guicursor ["a:ver100-blinkon0"])))

(nyoom-module-p! nyoom (do
                         (set! list)
                         (set! fillchars
                               {:eob " "
                                :vert " "
                                :diff "╱"
                                :foldclose ""
                                :foldopen ""
                                :fold " "
                                :msgsep "─"})
                         (set! listchars
                               {:tab " ──"
                                :trail "·"
                                :nbsp "␣"
                                :precedes "«"
                                :extends "»"})))

(nyoom-module-p! nyoom (set! scrolloff 4))
(nyoom-module-p! nyoom (set! guifont "Liga SFMono Nerd Font:h15"))
