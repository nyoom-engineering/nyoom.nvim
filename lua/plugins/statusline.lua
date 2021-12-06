local present, statusline = pcall(require, "statusline")
if not present then
   return
end

statusline.tabline = false
statusline.lsp_diagnostics = true
statusline.ale_diagnostics = false

