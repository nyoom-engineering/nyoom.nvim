-- :fennel:1651677731
local _local_1_ = require("packer")
local init = _local_1_["init"]
local function open_fn()
  local _local_2_ = require("packer.util")
  local float = _local_2_["float"]
  return float({border = "solid"})
end
init({autoremove = true, git = {clone_timeout = 300}, profile = {enable = true, threshold = 0}, compile_path = (vim.fn.stdpath("config") .. "/lua/packer_compiled.lua"), display = {header_lines = 2, title = "\239\163\150 packer.nvim", open_fn = open_fn}})
local lisp_ft = {"fennel", "clojure", "lisp", "racket", "scheme"}
local function _3_()
  do end (require("packer")).use({"wbthomason/packer.nvim"})
  do end (require("packer")).use({"lewis6991/impatient.nvim"})
  do end (require("packer")).use({init = "which-key", "folke/which-key.nvim"})
  do end (require("packer")).use({"udayvir-singh/tangerine.nvim"})
  do end (require("packer")).use({ft = lisp_ft, "gpanders/nvim-parinfer"})
  do end (require("packer")).use({branch = "develop", ft = lisp_ft, "Olical/conjure"})
  do end (require("packer")).use({cmd = "NvimTreeToggle", config = "require('pack.nvimtree')", "kyazdani42/nvim-tree.lua"})
  do end (require("packer")).use({cmd = "Telescope", config = "require('pack.telescope')", requires = {{module = "plenary", "nvim-lua/plenary.nvim"}}, "nvim-lua/telescope.nvim"})
  do end (require("packer")).use({config = "require('pack.treesitter')", event = {"BufRead", "BufNewFile"}, requires = {{event = {"BufRead", "BufNewFile"}, "p00f/nvim-ts-rainbow"}, {cmd = "TSPlayground", "nvim-treesitter/playground"}, {event = {"BufRead", "BufNewFile"}, "nvim-treesitter/nvim-treesitter-textobjects"}}, run = ":TSUpdate", "nvim-treesitter/nvim-treesitter"})
  do end (require("packer")).use({config = "require('pack.lsp')", requires = {{after = "nvim-lspconfig", init = "fidget", "j-hui/fidget.nvim"}}, "neovim/nvim-lspconfig"})
  local function _4_()
    local _local_5_ = require("trouble")
    local setup = _local_5_["setup"]
    return setup({icons = false})
  end
  do end (require("packer")).use({cmd = "Trouble", config = _4_, "folke/trouble.nvim"})
  do end (require("packer")).use({cmd = "Neogit", init = "neogit", "TimUntersberger/neogit"})
  local function _6_()
    local function _7_()
      return (require("copilot")).setup()
    end
    return vim.schedule(_7_)
  end
  do end (require("packer")).use({config = _6_, event = "InsertEnter", "zbirenbaum/copilot.lua"})
  do end (require("packer")).use({config = "require('pack.cmp')", event = {"InsertEnter", "CmdlineEnter"}, requires = {{after = "nvim-cmp", "hrsh7th/cmp-path"}, {after = "nvim-cmp", "hrsh7th/cmp-buffer"}, {after = "nvim-cmp", "hrsh7th/cmp-cmdline"}, {after = "nvim-cmp", "hrsh7th/cmp-nvim-lsp"}, {module = "lspkind", "onsails/lspkind-nvim"}, {after = "conjure", "PaterJason/cmp-conjure"}, {after = "nvim-cmp", "saadparwaiz1/cmp_luasnip"}, {after = "copilot.lua", "zbirenbaum/copilot-cmp"}, {module = "cmp-under-comparator", "lukas-reineke/cmp-under-comparator"}, {config = "require('pack.luasnip')", event = "InsertEnter", requires = {{opt = false, "rafamadriz/friendly-snippets"}}, wants = "friendly-snippets", "L3MON4D3/LuaSnip"}}, wants = {"LuaSnip"}, "hrsh7th/nvim-cmp"})
  do end (require("packer")).use({config = "require('pack.base16')", "RRethy/nvim-base16"})
  do end (require("packer")).use({config = "require('pack.notify')", "rcarriga/nvim-notify"})
  do end (require("packer")).use({cmd = "TZAtaraxis", config = "require('pack.truezen')", "Pocco81/TrueZen.nvim"})
  do end (require("packer")).use({config = "require('pack.colorizer')", event = {"BufRead", "BufNewFile"}, "norcalli/nvim-colorizer.lua"})
  return (require("packer")).use({after = "nvim-treesitter", config = "require('pack.neorg')", ft = "norg", "nvim-neorg/neorg"})
end
return (require("packer")).startup(_3_)