local present, bufferline = pcall(require, "bufferline")
if not present then
   return
end

local p = require "nano.palette"

bufferline.setup {
   options = {
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
      buffer_close_icon = "",
      modified_icon = "",
      close_icon = "λ",
      show_close_icon = true,
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = "multiwindow",
      show_buffer_close_icons = true,
      separator_style = { "", "" },
      always_show_bufferline = false,
      diagnostics = false, -- "or nvim_lsp"
      custom_filter = function(buf_number)
         -- Func to filter out our managed/persistent split terms
         local present_type, type = pcall(function()
            return vim.api.nvim_buf_get_var(buf_number, "term_type")
         end)

         if present_type then
            if type == "vert" then
               return false
            elseif type == "hori" then
               return false
            else
               return true
            end
         else
            return true
         end
      end,
   },

   highlights = {
      background = {
         guifg = p.fg,
         guibg = p.black,
      },

      -- buffers
      buffer_selected = {
         guifg = p.fg,
         guibg = p.slightwhite,
         gui = "bold",
      },
      buffer_visible = {
         guifg = p.grey,
         guibg = p.black,
      },

      -- for diagnostics = "nvim_lsp"
      error = {
         guifg = p.grey,
         guibg = p.black,
      },
      error_diagnostic = {
         guifg = p.grey,
         guibg = p.black,
      },

      -- close buttons
      close_button = {
         guifg = p.grey,
         guibg = p.black,
      },
      close_button_visible = {
         guifg = p.grey,
         guibg = p.black,
      },
      close_button_selected = {
         guifg = p.bg_red,
         guibg = p.slightwhite,
      },
      fill = {
         guifg = p.fg,
         guibg = p.black,
      },
      indicator_selected = {
         guifg = p.slightwhite,
         guibg = p.slightwhite,
      },

      -- modified
      modified = {
         guifg = p.bg_red,
         guibg = p.black,
      },
      modified_visible = {
         guifg = p.bg_red,
         guibg = p.black,
      },
      modified_selected = {
         guifg = p.bg_green,
         guibg = p.slightwhite,
      },

      -- separators
      separator = {
         guifg = p.slightwhite,
         guibg = p.slightwhite,
      },
      separator_visible = {
         guifg = p.slightwhite,
         guibg = p.slightwhite,
      },
      separator_selected = {
         guifg = p.slightwhite,
         guibg = p.slightwhite,
      },
      -- tabs
      tab = {
         guifg = p.grey,
         guibg = p.black,
      },
      tab_selected = {
         guifg = p.black,
         guibg = p.purple,
      },
      tab_close = {
         guifg = p.bg_red,
         guibg = p.slightwhite,
      },
   },
}
