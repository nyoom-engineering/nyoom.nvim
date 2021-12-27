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
      config = function()
        vim.g.did_load_filetypes = 1
      end,
   }

   use {
      "lewis6991/impatient.nvim",
      after = 'filetype.nvim',
   }

   use {
      "tweekmonster/startuptime.vim",
      cmd = "StartupTime",
   }

   -- jk for escape
   use {
      "max397574/better-escape.nvim",
      event = 'InsertCharPre',
      config = function()
         require("better_escape").setup {
            mapping = { "jk", "jj" },
            clear_empty_lines = true,
            keys = "<Esc>",
         }
      end,
   }

   -- colorscheme
   use {
      "~/.config/nvim/lua/ext/nano",
      after = "packer.nvim",
      config = function()
         vim.g.nano_enable_transparency = false
         vim.g.nano_enable_italic_comment = false
         vim.g.nano_enable_italic = false
         require("nano").colorscheme()
      end,
   }

   -- reminds me of my keybindings
   use {
      "folke/which-key.nvim",
      keys = "<space>",
      config = function()
         require("which-key").setup()
      end,
   }

   -- tabline/bufferline
   use {
      "akinsho/bufferline.nvim",
      after = "nano",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
         require "plugins.bufferline"
      end,
   }

   -- preview the colors of hexcodes
   use {
      "norcalli/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      config = function()
         require("plugins.others").colorizer()
      end,
   }

   -- colorful and fast syntax parsing
   use {
      "nvim-treesitter/nvim-treesitter",
      run = ':TSUpdate',
      event = "BufRead",
      config = function()
         require "plugins.treesitter"
      end,
   }

   -- ... now visualize it
   use {
      "nvim-treesitter/playground",
      cmd = "TSPlayground",
   }

   -- colorful parenthesis
   use {
      "p00f/nvim-ts-rainbow",
      after = "nvim-treesitter",
   }

   -- view what I've messed up so far
   use {
      "lewis6991/gitsigns.nvim",
      config = function()
         require "plugins.gitsigns"
      end,
   }

   -- filebrowser
   use {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = function()
         require "plugins.nvimtree"
      end,
   }

   -- LSP
   use {
      "neovim/nvim-lspconfig",
      after = "nvim-lsp-installer",
      config = function()
         require "plugins.lspconfig"
      end,
   }

   -- I hate manually installing language servers
   use {
      "williamboman/nvim-lsp-installer",
      opt = true,
      setup = function()
         require("config").packer_lazy_load "nvim-lspconfig"
         -- reload the current file so lsp actually starts for it
         vim.defer_fn(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
         end, 0)
      end,
   }

   -- show signatures in the gutter
   use {
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("plugins.others").signature()
      end,
   }

   -- and a more conventional list at the bottom
   use {
      "folke/trouble.nvim",
      cmd = "Trouble",
      config = function()
         require("trouble").setup()
      end,
   }

   -- nice looking menu for actions
   use {
      "weilbith/nvim-code-action-menu",
      cmd = "CodeActionMenu",
   }

   -- I always forget how to code
   use {
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
   }

   -- completion engine
   use {
      "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
      config = function()
         require "plugins.cmp"
      end,
   }

   -- snippet engine
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
      "github/copilot.vim",
      after = "nvim-cmp",
   }

   use {
      "hrsh7th/cmp-copilot",
      after = "copilot.vim",
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

   -- fuzzy searching for everythign
   use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      requires = {
         {
            -- ... and make it fast
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-lua/plenary.nvim",
            run = "make",
         },
      },
      config = function()
         require "plugins.telescope"
      end,
   }

  -- and the notifications too!
   use {
      "rcarriga/nvim-notify",
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

   -- take away distractions
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

   -- and take away my colors
   use {
      "folke/twilight.nvim",
      cmd = {
         "Twilight",
         "TwilightEnable",
      },
      config = function()
         require("twilight").setup()
      end,
   }

   -- move around quickly
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

   -- Let me see what I messed up (in condensed form!)
   use {
      "sindrets/diffview.nvim",
      after = "neogit",
   }

   -- and commit my messups too!
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

   -- and finally, notes
   use {
      "nvim-orgmode/orgmode",
      ft = "org",
      after = { "nvim-treesitter" },
      config = function()
         require("orgmode").setup()
      end,
   }

   -- fancy maths :tm:
   use {
      "jbyuki/nabla.nvim",
      after = "orgmode",
      config = function()
         require("plugins.others").nabla()
      end,
   }

   -- bring emacs' greatest features to neovim, one by one
   use {
      "alec-gibson/nvim-tetris",
      cmd = "Tetris",
   }

   -- blazing fast memory safe rust :tm:
   use {
      'simrat39/rust-tools.nvim',
      requires = { 'mfussenegger/nvim-dap' },
      ft = { 'rust', 'toml' },
      config = function()
         require 'langs.rust'
      end,
   }

end)
