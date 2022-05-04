-- :fennel:1651633779
local lsp = require("lspconfig")
do
  local _let_1_ = vim.diagnostic
  local config = _let_1_["config"]
  local severity = _let_1_["severity"]
  local _let_2_ = vim.fn
  local sign_define = _let_2_["sign_define"]
  config({underline = {severity = {min = severity.INFO}}, signs = {severity = {min = severity.INFO}}, virtual_text = false, update_in_insert = true, severity_sort = true, float = {show_header = false, border = "rounded"}})
  sign_define("DiagnosticSignError", {text = "\239\129\151", texthl = "DiagnosticSignError"})
  sign_define("DiagnosticSignWarn", {text = "\239\129\177", texthl = "DiagnosticSignWarn"})
  sign_define("DiagnosticSignInfo", {text = "\239\129\170", texthl = "DiagnosticSignInfo"})
  sign_define("DiagnosticSignHint", {text = "\239\129\154", texthl = "DiagnosticSignHint"})
end
do
  local _let_3_ = vim.lsp
  local with = _let_3_["with"]
  local handlers = _let_3_["handlers"]
  vim.lsp.handlers["textDocument/signatureHelp"] = with(handlers.signature_help, {border = "solid"})
  vim.lsp.handlers["textDocument/hover"] = with(handlers.hover, {border = "solid"})
end
local function on_attach(client, bufnr)
  local _local_4_ = vim.lsp.buf
  local open_float_doc_21 = _local_4_["hover"]
  local goto_definition_21 = _local_4_["definition"]
  local goto_declaration_21 = _local_4_["declaration"]
  local rename_21 = _local_4_["rename"]
  local goto_type_definition_21 = _local_4_["type_definition"]
  local open_float_actions_21 = _local_4_["code_action"]
  local _local_5_ = vim.diagnostic
  local open_float_diag_21 = _local_5_["open_float"]
  local goto_prev_diag_21 = _local_5_["goto_prev"]
  local goto_next_diag_21 = _local_5_["goto_next"]
  vim.keymap.set({"n"}, "K", open_float_doc_21, {desc = "open-float-doc!"})
  vim.keymap.set({"n"}, "<leader>a", open_float_actions_21, {desc = "open-float-actions!"})
  vim.keymap.set({"n"}, "<leader>r", rename_21, {desc = "rename!"})
  vim.keymap.set({"n"}, "<leader>d", open_float_diag_21, {desc = {focus = false}})
  vim.keymap.set({"n"}, "<leader>[d", goto_prev_diag_21, {desc = "goto-prev-diag!"})
  vim.keymap.set({"n"}, "<leader>]d", goto_next_diag_21, {desc = "goto-next-diag!"})
  vim.keymap.set({"n"}, "<leader>gd", goto_definition_21, {desc = "goto-definition!"})
  return vim.keymap.set({"n"}, "<leader>gD", goto_declaration_21, {desc = "goto-declaration!"})
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = {"markdown", "plaintext"}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = {valueSet = {1}}
capabilities.textDocument.completion.completionItem.resolveSupport = {properties = {"documentation", "detail", "additionalTextEdits"}}
local defaults = {on_attach = on_attach, capabilities = capabilities, flags = {debounce_text_changes = 150}}
return lsp.sumneko_lua.setup({on_attach = on_attach, capabilities = capabilities, settings = {Lua = {diagnostics = {globals = {"vim"}}, workspace = {library = {[vim.fn.expand("$VIMRUNTIME/lua")] = true, [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true}, maxPreload = 100000, preloadFileSize = 10000}}}})