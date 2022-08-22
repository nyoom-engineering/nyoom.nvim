(import-macros {: nyoom-module-p! : map! : let!} :macros)
(local {: setup} (require :leap)) 

;; Set leader to space by default
(let! mapleader " ")

(setup {:max_aot_targets nil
        :case_sensitive false
        :character_classes [" \t\r\n"]
        :special_keys {:repeat_search :<enter>
                       :next_match    :<enter>
                       :prev_match    :<tab>
                       :next_group    :<space>
                       :prev_group    :<tab>}})

;; Regular Leap 
(map! [nx] :s "<Plug>(leap-forward)" {:desc "Leap Forward"})
(map! [nx] :S "<Plug>(leap-backward)" {:desc "Leap Backward"})
(map! [o] :z "<Plug>(leap-forward)" {:desc "Leap Forward"})
(map! [o] :Z "<Plug>(leap-backward)" {:desc "Leap Backward"})
(map! [nxo] :gz "<Plug>(leap-cross-window)" {:desc "Leap Cross Window"})
(map! [o] :x "<Plug>(leap-forward-x)" {:desc "Leap Forward (x)"})
(map! [o] :X "<Plug>(leap-backward-x)" {:desc "Leap Backward (x)"})

;; easier command line mode + 
(map! [n] ";" ":" {:desc "vim-ex"})

;; telescope
(nyoom-module-p! telescope
  (do
    (map! [n] "<leader><space>" "<cmd>Telescope find_files<CR>" {:desc "Find Files"})
    (map! [n] "<leader>bb" "<cmd>Telescope buffers<CR>" {:desc "Buffers"})
    (map! [n] "<leader>:" "<cmd>Telescope commands<CR>" {:desc "M-x"})))
