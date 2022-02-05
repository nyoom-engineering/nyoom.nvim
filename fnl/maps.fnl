(module maps {require-macros [macros]})

(nm- :<Space> :<Nop>)
(let- :g :mapleader " ")
(let- :g :maplocalleader="m")

;; easier command line mode
(nno- ";" ":")
(vno- ";" ":")

;; resize
(nno- :<C-h> :<C-W><)
(nno- :<C-j> :<C-W>+)
(nno- :<C-k> :<C-W>-)
(nno- :<C-l> :<C-W>>)

;; move window
(nno- :<A-h> :<C-w>h)
(nno- :<A-j> :<C-w>j)
(nno- :<A-k> :<C-w>k)
(nno- :<A-l> :<C-w>l)

;; quit terminal
(tno- :<C-Space> "<C-\\><C-N>")

;; wrap/unwrap
(nno- :<leader>tw "<cmd>set wrap!<CR>")

;; hop
; map("n", "<leader>ww", "<cmd>HopWord<CR>")
; map("n", "<leader>l", "<cmd>HopLine<CR>")

;; telescope
(nno- "<leader>:" "<cmd>Telescope commands<CR>")
(nno- :<leader>bb "<cmd>Telescope buffers<CR>")
(nno- :<leader>fr "<cmd>Telescope oldfiles<CR>")
(nno- :<leader>. "<cmd>Telescope find_files<CR>")
(nno- :<leader>f "<cmd>Telescope current_buffer_fuzzy_find<CR>")

;; truezen
; map("n", "<leader>tz", "<cmd>TZAtaraxis<CR>")
