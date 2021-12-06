local present, statusline = pcall(require, "statusline")
if not present then
   return
end
statusline.lsp_diagnostics = true

