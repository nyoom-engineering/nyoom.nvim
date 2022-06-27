(local {: lazy-require!} (require :utils.lazy-require))
(local {: setup} (lazy-require! :fine-cmdline))
(local {: set-cmdline-keys!} (require :core.keymaps))

;;; Setup bufferline
(setup {:popup {:position {:row "2%" :col "50%"}
                :size {:width "98%"}
                :border {:style :rounded
                         :text {:top " _ command-line "
                                :top_align :left}}}})
  
;; Setup keybinds
(set-cmdline-keys!)



