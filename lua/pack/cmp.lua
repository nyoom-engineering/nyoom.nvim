-- :fennel:1651676539
local _local_1_ = table
local insert = _local_1_["insert"]
local function _4_(...)
  local meta_3_auto
  local function _3_(_241, _242)
    return (require("cmp"))[_242]
  end
  meta_3_auto = {__index = _3_}
  local ret_4_auto = {}
  setmetatable(ret_4_auto, meta_3_auto)
  return ret_4_auto
end
local _local_2_ = _4_(...)
local setup = _local_2_["setup"]
local mapping = _local_2_["mapping"]
local visible = _local_2_["visible"]
local complete = _local_2_["complete"]
local _local_5_ = _local_2_["config"]
local compare = _local_5_["compare"]
local disable = _local_5_["disable"]
local _local_6_ = _local_2_["ItemField"]
local kind = _local_6_["Kind"]
local abbr = _local_6_["Abbr"]
local menu = _local_6_["Menu"]
local _local_7_ = _local_2_["SelectBehavior"]
local insert_behavior = _local_7_["Insert"]
local select_behavior = _local_7_["Select"]
local event = _local_2_["event"]
local types
do
  local meta_3_auto
  local function _8_(_241, _242)
    return (require("cmp.types"))[_242]
  end
  meta_3_auto = {__index = _8_}
  local ret_4_auto = {}
  setmetatable(ret_4_auto, meta_3_auto)
  types = ret_4_auto
end
local function _11_(...)
  local meta_3_auto
  local function _10_(_241, _242)
    return (require("lspkind"))[_242]
  end
  meta_3_auto = {__index = _10_}
  local ret_4_auto = {}
  setmetatable(ret_4_auto, meta_3_auto)
  return ret_4_auto
end
local _local_9_ = _11_(...)
local cmp_format = _local_9_["cmp_format"]
local under_compare
do
  local meta_3_auto
  local function _12_(_241, _242)
    return (require("cmp-under-comparator"))[_242]
  end
  meta_3_auto = {__index = _12_}
  local ret_4_auto = {}
  setmetatable(ret_4_auto, meta_3_auto)
  under_compare = ret_4_auto
end
local function _15_(...)
  local meta_3_auto
  local function _14_(_241, _242)
    return (require("luasnip"))[_242]
  end
  meta_3_auto = {__index = _14_}
  local ret_4_auto = {}
  setmetatable(ret_4_auto, meta_3_auto)
  return ret_4_auto
end
local _local_13_ = _15_(...)
local lsp_expand = _local_13_["lsp_expand"]
local expand_or_jump = _local_13_["expand_or_jump"]
local expand_or_jumpable = _local_13_["expand_or_jumpable"]
local jump = _local_13_["jump"]
local jumpable = _local_13_["jumpable"]
local function has_words_before()
  local col = (vim.fn.col(".") - 1)
  local ln = vim.fn.getline(".")
  return ((col == 0) or string.match(string.sub(ln, col, col), "%s"))
end
local function replace_termcodes(code)
  return vim.api.nvim_replace_termcodes(code, true, true, true)
end
local function _16_(args)
  return lsp_expand(args.body)
end
local function _17_(fallback)
  if visible() then
    return mapping.select_next_item({behavior = insert_behavior})
  elseif expand_or_jumpable() then
    return expand_or_jump()
  elseif has_words_before() then
    return vim.fn.feedkeys(replace_termcodes("<Tab>"), "n")
  else
    return fallback()
  end
end
local function _19_(fallback)
  if visible() then
    return mapping.select_prev_item({behavior = insert_behavior})
  elseif jumpable(-1) then
    return jump(-1)
  else
    return fallback()
  end
end
setup({preselect = types.cmp.PreselectMode.None, experimental = {ghost_text = true}, window = {documentation = {border = "solid"}, completion = {border = "solid"}}, snippet = {expand = _16_}, mapping = {["<C-b>"] = mapping.scroll_docs(-4), ["<C-f>"] = mapping.scroll_docs(4), ["<C-e>"] = mapping.abort(), ["<C-n>"] = mapping(mapping.select_next_item({behavior = insert_behavior}), {"i", "s"}), ["<C-p>"] = mapping(mapping.select_prev_item({behavior = insert_behavior}), {"i", "s"}), ["<Tab>"] = mapping(_17_, {"i", "s", "c"}), ["<S-Tab>"] = mapping(_19_, {"i", "s", "c"}), ["<C-Space>"] = mapping.confirm({select = true})}, sources = {{name = "nvim_lsp"}, {name = "luasnip"}, {name = "path"}, {name = "buffer"}, {name = "conjure"}, {name = "copilot"}}, sorting = {comparators = {compare.offset, compare.exact, compare.score, under_compare.under, compare.kind, compare.sort_text, compare.length, compare.order}}, formatting = {fields = {kind, abbr, menu}, format = cmp_format({with_text = false})}})
return setup.cmdline(":", {view = {separator = "|"}, sources = {{name = "path"}, {name = "cmdline"}}})