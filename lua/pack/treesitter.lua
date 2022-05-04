-- :fennel:1651604987
local function _3_(...)
  local meta_3_auto
  local function _2_(_241, _242)
    return (require("nvim-treesitter.configs"))[_242]
  end
  meta_3_auto = {__index = _2_}
  local ret_4_auto = {}
  setmetatable(ret_4_auto, meta_3_auto)
  return ret_4_auto
end
local _local_1_ = _3_(...)
local setup = _local_1_["setup"]
local parsers
do
  local meta_3_auto
  local function _4_(_241, _242)
    return (require("nvim-treesitter.parsers"))[_242]
  end
  meta_3_auto = {__index = _4_}
  local ret_4_auto = {}
  setmetatable(ret_4_auto, meta_3_auto)
  parsers = ret_4_auto
end
local parser_config = parsers.get_parser_configs()
parser_config.norg = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg", files = {"src/parser.c", "src/scanner.cc"}, branch = "main"}}
parser_config.norg_meta = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg-meta", files = {"src/parser.c"}, branch = "main"}}
parser_config.norg_table = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg-table", files = {"src/parser.c"}, branch = "main"}}
return setup({ensure_installed = {"lua", "vim", "fennel", "markdown", "nix"}, highlight = {enable = true, use_languagetree = true}, indent = {enable = true}, rainbow = {enable = true, extended_mode = true}, incremental_selection = {enable = true, keymaps = {init_selection = "gnn", node_incremental = "grn", scope_incremental = "grc", node_decremental = "grm"}}, textobjects = {select = {enable = true}, lookahead = true, keymaps = {af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = "@class.inner"}, move = {enable = true, set_jumps = true, goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"}, goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"}, goto_previous_start = {["[m"] = "@function.outer", ["[["] = "@class.outer"}, goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}}}})