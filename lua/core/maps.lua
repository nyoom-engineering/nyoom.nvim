-- :fennel:1651607217
do
  local ok_3f_16_auto, which_key_17_auto = pcall(require, "which-key")
  if ok_3f_16_auto then
    which_key_17_auto.register({["<leader>f"] = "Files"}, {mode = "n", noremap = false})
  else
  end
end
do
  local ok_3f_16_auto, which_key_17_auto = pcall(require, "which-key")
  if ok_3f_16_auto then
    which_key_17_auto.register({["<leader>t"] = "Visuals"}, {mode = "n", noremap = false})
  else
  end
end
do
  local ok_3f_16_auto, which_key_17_auto = pcall(require, "which-key")
  if ok_3f_16_auto then
    which_key_17_auto.register({["<leader>b"] = "Buffers"}, {mode = "n", noremap = false})
  else
  end
end
do
  local ok_3f_16_auto, which_key_17_auto = pcall(require, "which-key")
  if ok_3f_16_auto then
    which_key_17_auto.register({["<leader>o"] = "NvimTree"}, {mode = "n", noremap = false})
  else
  end
end
do
  local ok_3f_16_auto, which_key_17_auto = pcall(require, "which-key")
  if ok_3f_16_auto then
    which_key_17_auto.register({["<leader>:"] = "M-x"}, {mode = "n", noremap = false})
  else
  end
end
do
  local ok_3f_16_auto, which_key_17_auto = pcall(require, "which-key")
  if ok_3f_16_auto then
    which_key_17_auto.register({["<leader><space>"] = "Project Fuzzy Search"}, {mode = "n", noremap = false})
  else
  end
end
vim.keymap.set({"n"}, "<C-z>", "<Nop>", {})
vim.keymap.set({"n"}, "Q", "<Nop>", {})
vim.keymap.set({"n"}, ";", ":", {})
vim.keymap.set({"v"}, ";", ":", {})
vim.keymap.set({"n"}, "<C-h>", "<C-w>h", {})
vim.keymap.set({"n"}, "<C-j>", "<C-w>j", {})
vim.keymap.set({"n"}, "<C-k>", "<C-w>k", {})
vim.keymap.set({"n"}, "<C-l>", "<C-w>l", {})
vim.keymap.set({"n"}, "<C-Up>", "<cmd>resize +2<cr>", {})
vim.keymap.set({"n"}, "<C-Down>", "<cmd>resize -2<cr>", {})
vim.keymap.set({"n"}, "<C-Left>", "<cmd>vertical resize +2<cr>", {})
vim.keymap.set({"n"}, "<C-Right>", "<cmd>vertical resize -2<cr>", {})
vim.keymap.set({"n"}, "<leader>tw", "<cmd>set wrap!<CR>", {})
vim.keymap.set({"n"}, "<Leader>th", ":TSHighlightCapturesUnderCursor<CR>", {})
vim.keymap.set({"n"}, "<Leader>tp", ":TSPlayground<CR>", {})
vim.keymap.set({"n"}, "<leader>bb", "<cmd>Telescope buffers<CR>", {})
vim.keymap.set({"n"}, "<leader>ff", "<cmd>Telescope current_buffer_fuzzy_find<CR>", {})
vim.keymap.set({"n"}, "<leader>fr", "<cmd>Telescope oldfiles<CR>", {})
vim.keymap.set({"n"}, "<leader>:", "<cmd>Telescope commands<CR>", {})
vim.keymap.set({"n"}, "<leader><space>", "<cmd>Telescope find_files<CR>", {})
vim.keymap.set({"n"}, "<leader>op", "<cmd>NvimTreeToggle<CR>", {})
return vim.keymap.set({"n"}, "<leader>tz", "<cmd>TZAtaraxis<CR>", {})