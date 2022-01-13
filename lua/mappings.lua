-- helper function for clean mappings
local function map(mode, lhs, rhs, opts)
   local options = { noremap = true, silent = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " " --leader
map("n", ";", ":") --semicolon to enter command mode
map("n", "<leader>ww", "<cmd>HopWord<CR>") --easymotion/hop
map("n", "<leader>l", "<cmd>HopLine<CR>")
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>") --fuzzy
map("n", "<leader>.", "<cmd>Telescope find_files<CR>")
map("n", "<leader>f", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
map("n", "<leader>:", "<cmd>Telescope commands<CR>")
map("n", "<leader>bb", "<cmd>Telescope buffers<CR>")
map("n", "<leader>tz", "<cmd>TZAtaraxis<CR>") --ataraxis
map("n", "<leader>op", "<cmd>NvimTreeToggle<CR>") --nvimtree
map("n", "<leader>tw", "<cmd>set wrap!<CR>") --nvimtree
map("n", "<c-k>", "<cmd>wincmd k<CR>") --ctrlhjkl to navigate splits
map("n", "<c-j>", "<cmd>wincmd j<CR>")
map("n", "<c-h>", "<cmd>wincmd h<CR>")
map("n", "<c-l>", "<cmd>wincmd l<CR>")
