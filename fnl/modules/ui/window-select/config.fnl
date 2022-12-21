(import-macros {: map!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
(local {: pick_window} (autoload :window-picker))

(setup :window-picker {:include_current_win true})

(fn set-picked-window []
  (let [picked-window-id (pick_window)]
    (vim.api.nvim_set_current_win picked-window-id)))

;; (map! [n] :<leader>w `(set-picked-window))
