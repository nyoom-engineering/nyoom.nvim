local M = {}
local space = " "
local vim = vim

function M.current_function()
   local lsp_function = vim.b.lsp_current_function
   if lsp_function == nil then
      return ""
   end
   return lsp_function
end

-- icons       
function M.diagnostics()
   local diagnostics = ""
   local e = vim.lsp.diagnostic.get_count(0, [[Error]])
   local w = vim.lsp.diagnostic.get_count(0, [[Warning]])
   local i = vim.lsp.diagnostic.get_count(0, [[Information]])
   local h = vim.lsp.diagnostic.get_count(0, [[Hint]])
   diagnostics = e ~= 0 and diagnostics .. " " .. e .. space or diagnostics
   diagnostics = w ~= 0 and diagnostics .. " " .. w .. space or diagnostics
   diagnostics = i ~= 0 and diagnostics .. "𝒊 " .. i .. space or diagnostics
   diagnostics = h ~= 0 and diagnostics .. " " .. h .. space or diagnostics
   return diagnostics
end

local function format_messages(messages)
   local result = {}
   local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
   local ms = vim.loop.hrtime() / 1000000
   local frame = math.floor(ms / 120) % #spinners
   local i = 1
   for _, msg in pairs(messages) do
      -- Only display at most 2 progress messages at a time to avoid clutter
      if i < 3 then
         table.insert(result, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
         i = i + 1
      end
   end
   return table.concat(result, " ") .. " " .. spinners[frame + 1]
end

-- REQUIRES LSP
function M.lsp_progress()
   local messages = vim.lsp.util.get_progress_messages()
   if #messages == 0 then
      return ""
   end
   return format_messages(messages)
end

-- REQUIRES NVIM LIGHTBULB
function M.lightbulb()
   local has_lightbulb, lightbulb = pcall(require, "nvim-lightbulb")
   if not has_lightbulb then
      return ""
   end

   if lightbulb.get_status_text() ~= "" then
      return "" .. space
   else
      return ""
   end
end

return M
