(import-macros {: map!} :conf.macros)

;; we only want these mappings added if the user has set fennel_compiler to hotpot. Conjure + aniseed come with their own mappings
(if (= fennel_compiler :hotpot)
    (do
      (map! [v] :<localleader>e
            "<cmd>lua print(require('hotpot.api.eval')['eval-selection']())<CR>")
      (map! [v] :<localleader>c
            "<cmd>lua print(require('hotpot.api.compile')['compile-selection']())<CR>")
      (map! [n] :<localleader>c
            "<cmd>lua print(require('hotpot.api.compile')['compile-buffer'](0))<CR>")))
