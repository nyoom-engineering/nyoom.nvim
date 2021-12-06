vim.cmd "packadd packer.nvim"
local present, packer = pcall(require, "packer")

--clone packer if its missing
if not present then
   local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

   print "Cloning packer.."
   -- remove the dir before cloning
   vim.fn.delete(packer_path, "rf")
   vim.fn.system {
      "git",
      "clone",
      "https://github.com/wbthomason/packer.nvim",
      "--depth",
      "20",
      packer_path,
   }

   vim.cmd "packadd packer.nvim"
   present, packer = pcall(require, "packer")

   if present then
      print "Packer cloned successfully."
   else
      error("Couldn't clone packer !\nPacker path: " .. packer_path)
   end
end

-- packer settings
return packer.init {
   -- tell packer to put packer_compiled under the /lua folder so its cached by impatient
   compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
   display = {
      open_fn = function()
         return require("packer.util").float { border = "rounded" }
      end,
      prompt_border = "rounded",
   },
   git = {
      clone_timeout = 600, -- Timeout, in seconds, for git clones
   },
}
