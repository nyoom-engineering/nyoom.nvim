(import-macros {: map!} :macros)
(local {: setup : pick_window} (require :window-picker))

(setup {:include_current_win true})

(fn set-picked-window []
  (let [picked-window-id (pick_window)]
    (vim.api.nvim_set_current_win picked-window-id)))

(map! [n] "<leader>w" '(set-picked-window))


