(import-macros {: map!} :conf.macros)

;; telescope
(map! [n] :<leader>bb "<cmd>Telescope buffers<CR>")
(map! [n] :<leader>ff "<cmd>Telescope current_buffer_fuzzy_find<CR>")
(map! [n] :<leader>fr "<cmd>Telescope frecency<CR>")
(map! [n] :<leader>fp "<cmd>Telescope packer<CR>")
(map! [n] "<leader>:" "<cmd>Telescope commands<CR>")
(map! [n] :<leader>. "<cmd>Telescope file_browser<CR>")
(map! [n] :<leader><space> "<cmd>Telescope find_files<CR>")
