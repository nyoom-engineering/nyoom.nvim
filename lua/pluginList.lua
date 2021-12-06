local present, packer = pcall(require, "packerInit")

if present then
   packer = require "packer"
else
   return false
end

local use = packer.use
return packer.startup(function()
   -- Have packer manage itself
   use {
      "wbthomason/packer.nvim",
      event = "VimEnter",
   }

   -- Startup optimizations
   use {
      "nathom/filetype.nvim",
   }

   use {
      "lewis6991/impatient.nvim",
   }

   use {
      "tweekmonster/startuptime.vim",
      cmd = "StartupTime",
   }

   use {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      config = function()
         require("better_escape").setup {
            mapping = { "jk", "jj" },
            clear_empty_lines = true,
            keys = "<Esc>",
         }
      end,
   }

   use {
      "Clutch-Squad-10669/nord.nvim",
      --branch = "nvim_api_rewrite",
      config = function()
         require("nord").set()
      end,
   }

   use {
      "folke/which-key.nvim",
      keys = "<space>",
      config = function()
         require("which-key").setup()
      end,
   }

   use {
      "kyazdani42/nvim-web-devicons",
      after = "nord.nvim",
   }

   use {
      "beauwilliams/statusline.lua",
      config = function()
         require "plugins.statusline"
      end,
   }

   use {
      "akinsho/bufferline.nvim",
      config = function()
         require "plugins.bufferline"
      end,
   }

   use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
         require("plugins.others").blankline()
      end,
   }

   use {
      "norcalli/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      config = function()
         require("plugins.others").colorizer()
      end,
   }

   use {
      "nvim-treesitter/nvim-treesitter",
      config = function()
         require "plugins.treesitter"
      end,
   }

   use {
      "nvim-treesitter/playground",
      cmd = "TSPlayground",
   }

   use {
      "p00f/nvim-ts-rainbow",
      after = "nvim-treesitter",
   }

   use {
      "lewis6991/gitsigns.nvim",
   }

   use {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = function()
         require "plugins.nvimtree"
      end,
   }

   -- LSP (and copilot
   use {
      "github/copilot.vim",
      event = "InsertEnter",
   }

   use {
      "dccsillag/magma-nvim",
      cmd = { "MagmaInit" },
      run = ":UpdateRemotePlugins",
   }

   use {
      "neovim/nvim-lspconfig",
      config = function()
         require "plugins.lspconfig"
      end,
   }

   use {
      "williamboman/nvim-lsp-installer",
   }

   use {
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("plugins.others").signature()
      end,
   }

   use {
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
   }

   use {
      "numToStr/Comment.nvim",
      after = "friendly-snippets",
      config = function()
         require("plugins.others").comment()
      end,
   }

   use {
      "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
      config = function()
         require "plugins.cmp"
      end,
   }

   use {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         require("plugins.others").luasnip()
      end,
   }

   use {
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
   }

   use {
      "hrsh7th/cmp-nvim-lua",
      after = "nvim-cmp",
   }

   use {
      "hrsh7th/cmp-nvim-lsp",
      after = "nvim-cmp",
   }

   use {
      "lukas-reineke/cmp-rg",
      after = "nvim-cmp",
   }

   use {
      "ray-x/cmp-treesitter",
      after = "nvim-cmp",
   }

   use {
      "hrsh7th/cmp-path",
      after = "nvim-cmp",
   }

   use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      requires = {
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-lua/plenary.nvim",
            run = "make",
         },
      },
      config = function()
         require "plugins.telescope"
      end,
   }

   use {
      "VonHeikemen/fine-cmdline.nvim",
      requires = {
         "MunifTanjim/nui.nvim",
      },
      config = function()
         require("plugins.others").fineCmdline()
      end,
   }

   use {
      "VonHeikemen/searchbox.nvim",
      requires = {
         "MunifTanjim/nui.nvim",
      },
      config = function()
         require("plugins.others").searchbox()
      end,
   }

   use {
      "rcarriga/nvim-notify",
      after = "nord.nvim",
      config = function()
         vim.notify = require "notify"
         require("notify").setup {
            stages = "slide",
            timeout = 2500,
            minimum_width = 50,
            icons = {
               ERROR = "",
               WARN = "",
               INFO = "",
               DEBUG = "",
               TRACE = "✎",
            },
         }
      end,
   }

   use {
      "Pocco81/TrueZen.nvim",
      cmd = {
         "TZAtaraxis",
         "TZMinimalist",
         "TZFocus",
      },
      config = function()
         require "plugins.zenmode"
      end,
   }

   use {
      "folke/twilight.nvim",
      cmd = {
         "Twilight",
         "TwilightEnable",
      },
      config = function()
         require("twilight").setup {}
      end,
   }

   use {
      "phaazon/hop.nvim",
      cmd = {
         "HopWord",
         "HopLine",
         "HopChar1",
         "HopChar2",
         "HopPattern",
      },
      as = "hop",
      config = function()
         require("hop").setup()
      end,
   }

   use {
      "sindrets/diffview.nvim",
      after = "neogit",
   }

   use {
      "TimUntersberger/neogit",
      cmd = {
         "Neogit",
         "Neogit commit",
      },
      config = function()
         require "plugins.neogit"
      end,
   }

   use {
      "nvim-neorg/neorg",
      branch = "unstable",
      setup = vim.cmd "autocmd BufRead,BufNewFile *.norg setlocal filetype=norg",
      after = { "nvim-treesitter" }, -- you may also specify telescope
      ft = "norg",
      config = function()
         require "plugins.neorg"
      end,
   }

   use {
      "nvim-orgmode/orgmode",
      ft = "org",
      setup = vim.cmd("autocmd BufRead,BufNewFile *.org setlocal filetype=org"),
      after = { "nvim-treesitter" },
      config = function()
         require("orgmode").setup {}
      end,
   }

   use {
      "nvim-neorg/neorg-telescope",
      ft = "norg",
   }
end)
