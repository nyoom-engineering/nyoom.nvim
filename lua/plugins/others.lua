local M = {}

M.colorizer = function()
   local present, colorizer = pcall(require, "colorizer")
   if present then
      colorizer.setup({ "*" }, {
         RGB = true, -- #RGB hex codes
         RRGGBB = true, -- #RRGGBB hex codes
         names = true, -- "Name" codes like Blue
         RRGGBBAA = true, -- #RRGGBBAA hex codes
         rgb_fn = true, -- CSS rgb() and rgba() functions
         hsl_fn = true, -- CSS hsl() and hsla() functions
         css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
         css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
         mode = "foreground", -- Set the display mode.
      })
      vim.cmd "ColorizerReloadAllBuffers"
   end
end

M.searchbox = function()
   local searchbox = pcall(require, "searchbox")
   if searchbox then
      vim.api.nvim_set_keymap(
         "n",
         "/",
         ':lua require("searchbox").match_all({clear_matches = true})<CR>',
         { noremap = true }
      )
      vim.api.nvim_set_keymap(
         "n",
         "<leader>/",
         ':lua require("searchbox").replace({confirm = "menu"})<CR>',
         { noremap = true }
      )
      vim.api.nvim_set_keymap(
         "v",
         "<leader>/",
         '<Esc><cmd>lua require("searchbox").replace({exact = true, visual_mode = true, confirm = "menu"})<CR>',
         { noremap = true }
      )
   end
end

M.luasnip = function()
   local present, luasnip = pcall(require, "luasnip")
   if not present then
      return
   end

   luasnip.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
   }
   require("luasnip/loaders/from_vscode").load()
end

M.signature = function()
   local present, lspsignature = pcall(require, "lsp_signature")
   if present then
      lspsignature.setup {
         bind = true,
         doc_lines = 2,
         floating_window = true,
         fix_pos = true,
         hint_enable = true,
         hint_prefix = " ",
         hint_scheme = "String",
         hi_parameter = "Search",
         max_height = 22,
         max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
         handler_opts = {
            border = "single", -- double, single, shadow, none
         },
         zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
         padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
      }
   end
end

M.orgmode = function()
   local present, orgmode = pcall(require, "orgmode")
   if present then
      orgmode.setup({ "*" }, {
         org_highlight_latex_and_related = "entities",
         org_agenda_files = "~/org/*",
         org_default_notes_file = "~/org/notes.org",
         org_hide_leading_stars = true,
         org_hide_emphasis_markers = true,
         mappings = {
            global = {
               org_agenda = "<Leader>oa",
               org_capture = "<Leader>oc",
            },
            agenda = {
               org_agenda_later = "f",
               org_agenda_earlier = "b",
               org_agenda_goto_today = ".",
               org_agenda_day_view = "vd",
               org_agenda_week_view = "vw",
               org_agenda_month_view = "vm",
               org_agenda_year_view = "vy",
               org_agenda_quit = "q",
               org_agenda_switch_to = "<CR>",
               org_agenda_goto = { "<TAB>" },
               org_agenda_goto_date = "J",
               org_agenda_redo = "r",
               org_agenda_todo = "t",
               org_agenda_show_help = "?",
            },
            capture = {
               org_capture_finalize = "<C-c>",
               org_capture_refile = "<Leader>or",
               org_capture_kill = "<Leader>ok",
               org_capture_show_help = "?",
            },
            org = {
               org_increase_date = "<C-a>",
               org_decrease_date = "<C-x>",
               org_toggle_checkbox = "<C-Space>",
               org_open_at_point = "<Leader>oo",
               org_cycle = "<TAB>",
               org_global_cycle = "<S-TAB>",
               org_archive_subtree = "<Leader>o$",
               org_set_tags_command = "<Leader>ot",
               org_toggle_archive_tag = "<Leader>oA",
               org_do_promote = "<<",
               org_do_demote = ">>",
               org_promote_subtree = "<s",
               org_demote_subtree = ">s",
               org_meta_return = "<Leader><CR>", -- Add headling, item or row
               org_insert_heading_respect_content = "<Leader>oih", -- Add new headling after current heading block with same level
               org_insert_todo_heading = "<Leader>oiT", -- Add new todo headling right after current heading with same level
               org_insert_todo_heading_respect_content = "<Leader>oit", -- Add new todo headling after current heading block on same level
               org_move_subtree_up = "<Leader>oK",
               org_move_subtree_down = "<Leader>oJ",
               org_export = "<Leader>oe",
               org_next_visible_heading = "}",
               org_previous_visible_heading = "{",
               org_forward_heading_same_level = "]]",
               org_backward_heading_same_level = "[[",
            },
         },
      })
   end
end

return M
