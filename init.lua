-- use opt-in filetype.lua instead of vimscript default
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

function ensure(user, repo)
   local install_path = string.format("%s/packer/start/%s", vim.fn.stdpath("data") .. "/site/pack", repo, repo)
   if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
      vim.api.nvim_command(string.format("!git clone https://github.com/%s/%s %s", user, repo, install_path))
      vim.api.nvim_command(string.format("packadd %s", repo))
   end
end

-- Bootstrap essential plugins
ensure("wbthomason", "packer.nvim")
ensure("lewis6991", "impatient.nvim")
require("impatient")

-- Compile fennel
ensure("udayvir-singh", "tangerine.nvim")
require("tangerine").setup({
   compiler = {
      hooks = {
         "oninit",
         "onsave",
      },
   },
})
require("conf")


