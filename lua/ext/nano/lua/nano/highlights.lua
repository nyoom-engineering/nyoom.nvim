local p = require "nano.palette"
local cfg = require "nano.config"
local u = require "nano.utils"

local M = {}
local hl = { langs = {}, plugins = {} }

local highlight = vim.api.nvim_set_hl
local set_hl_ns = vim.api.nvim__set_hl_ns or vim.api.nvim_set_hl_ns
local ns = vim.api.nvim_create_namespace "nano"

local function load_highlights(highlights)
   for group_name, group_settings in pairs(highlights) do
      highlight(ns, group_name, group_settings)
   end
end

hl.predef = {
   Fg = { fg = p.fg, bold = true },
   Grey = { fg = p.grey, bold = true },
   Red = { fg = p.red },
   Yellow = { fg = p.yellow },
   Blue = { fg = p.blue },
   Purple = { fg = p.purple },
   PurpleBold = { fg = p.purple, bold = true },
   BlueItalic = { fg = p.blue, italic = cfg.italic },
   PurpleItalic = { fg = p.purple, italic = cfg.italic },
   FgItalic = { fg = p.fg, italic = cfg.italic },
   RedItalic = { fg = p.red, italic = cfg.italic },
}

hl.common = {
   Normal = { fg = p.fg, bg = p.black },
   FloatBorder = { fg = p.purple, bg = p.black },
   MsgArea = { fg = p.fg, bg = p.black },
   Terminal = { fg = p.fg, bg = p.black },
   EndOfBuffer = { fg = p.bg2, bg = p.black },
   FoldColumn = { fg = p.fg, bg = p.bg1 },
   Folded = { fg = p.fg, bg = p.bg1 },
   SignColumn = { fg = p.fg, bg = p.black },
   ToolbarLine = { fg = p.fg },
   Cursor = { reverse = true },
   vCursor = { reverse = true },
   iCursor = { reverse = true },
   lCursor = { reverse = true },
   CursorIM = { reverse = true },
   CursorColumn = { bg = p.bg1 },
   CursorLine = { bg = p.black },
   ColorColumn = { bg = p.bg1 },
   CursorLineNr = { fg = p.fg },
   LineNr = { fg = p.bg4 },
   Conceal = { fg = p.grey, bg = p.bg1 },
   DiffAdd = { fg = p.none, bg = p.yellow },
   DiffChange = { fg = p.none, bg = p.bg_green },
   DiffDelete = { fg = p.none, bg = p.bg_red },
   DiffText = { fg = p.none, reverse = true },
   Directory = { fg = p.purple },
   ErrorMsg = { fg = p.red, bold = true, underline = true },
   WarningMsg = { fg = p.purple, bold = true },
   MoreMsg = { fg = p.blue, bold = true },
   IncSearch = { fg = p.black, bg = p.bg2 },
   Search = { fg = p.black, bg = p.bg3 },
   MatchParen = { fg = p.none, bg = p.bg4 },
   NonText = { fg = p.bg4 },
   Whitespace = { fg = p.bg4 },
   SpecialKey = { fg = p.bg4 },
   Pmenu = { fg = p.fg, bg = p.bg1 },
   PmenuSbar = { fg = p.none, bg = p.bg2 },
   PmenuSel = { fg = p.black, bg = p.bg_green },
   WildMenu = { fg = p.black, bg = p.blue },
   PmenuThumb = { fg = p.none, bg = p.grey },
   Question = { fg = p.purple },
   SpellBad = { fg = p.red, underline = true, sp = p.red },
   SpellCap = { fg = p.purple, underline = true, sp = p.purple },
   SpellLocal = { fg = p.blue, underline = true, sp = p.blue },
   SpellRare = { fg = p.purple, underline = true, sp = p.purple },
   StatusLine = { fg = p.fg, bg = p.bg2 },
   StatusLineTerm = { fg = p.fg, bg = p.bg2 },
   StatusLineNC = { fg = p.grey, bg = p.bg1 },
   StatusLineTermNC = { fg = p.grey, bg = p.bg1 },
   TabLine = { fg = p.fg, bg = p.bg4 },
   TabLineFill = { fg = p.grey, bg = p.bg1 },
   TabLineSel = { fg = p.black, bg = p.bg_red },
   VertSplit = { fg = p.black, bg = p.black },
   Visual = { bg = p.bg1 },
   VisualNOS = { fg = p.none, bg = p.bg2, underline = true },
   QuickFixLine = { fg = p.blue, underline = true },
   Debug = { fg = p.purple },
   debugPC = { fg = p.black, bg = p.purple },
   debugBreakpoint = { fg = p.black, bg = p.red },
   ToolbarButton = { fg = p.black, bg = p.bg_blue },
}

hl.syntax = {
   Type = hl.predef.Fg,
   Structure = hl.predef.Fg,
   StorageClass = hl.predef.Fg,
   Identifier = hl.predef.FgItalic,
   Constant = hl.predef.FgItalic,
   PreProc = hl.predef.Red,
   PreCondit = hl.predef.Red,
   Include = hl.predef.Red,
   Keyword = hl.predef.Red,
   Define = hl.predef.Red,
   Typedef = hl.predef.Red,
   Exception = hl.predef.Red,
   Conditional = hl.predef.Red,
   Repeat = hl.predef.Red,
   Statement = hl.predef.Red,
   Macro = hl.predef.Purple,
   Error = hl.predef.Red,
   Label = hl.predef.Purple,
   Special = hl.predef.Purple,
   SpecialChar = hl.predef.Purple,
   Boolean = hl.predef.Purple,
   String = hl.predef.Yellow,
   Character = hl.predef.Yellow,
   Number = hl.predef.Purple,
   Float = hl.predef.Purple,
   Function = hl.predef.Fg,
   Operator = hl.predef.Red,
   Title = hl.predef.Yellow,
   Tag = hl.predef.Fg,
   Delimiter = hl.predef.FgItalic,
   Comment = { fg = p.bg4, italic = cfg.italic_comment },
   SpecialComment = { fg = p.bg4, italic = cfg.italic_comment },
   Todo = { fg = p.blue, bold = true, italic = cfg.italic_comment },
}

hl.plugins.lsp = {
   LspCxxHlGroupEnumConstant = hl.predef.Fg,
   LspCxxHlGroupMemberVariable = hl.predef.Fg,
   LspCxxHlGroupNamespace = hl.predef.Blue,
   LspCxxHlSkippedRegion = hl.predef.Grey,
   LspCxxHlSkippedRegionBeginEnd = hl.predef.Red,
   LspDiagnosticsDefaultError = { fg = u.color_gamma(p.red, 0.5) },
   LspDiagnosticsDefaultHint = { fg = u.color_gamma(p.purple, 0.5) },
   LspDiagnosticsDefaultInformation = { fg = u.color_gamma(p.blue, 0.5) },
   LspDiagnosticsDefaultWarning = { fg = u.color_gamma(p.purple, 0.5) },
   LspDiagnosticsUnderlineError = { underline = true, sp = u.color_gamma(p.red, 0.5) },
   LspDiagnosticsUnderlineHint = { underline = true, sp = u.color_gamma(p.purple, 0.5) },
   LspDiagnosticsUnderlineInformation = { underline = true, sp = u.color_gamma(p.blue, 0.5) },
   LspDiagnosticsUnderlineWarning = { underline = true, sp = u.color_gamma(p.purple, 0.5) },
   DiagnosticSignError = { fg = u.color_gamma(p.red, 0.5) },
   DiagnosticSignHint = { fg = u.color_gamma(p.purple, 0.5) },
   DiagnosticSignInfo = { fg = u.color_gamma(p.blue, 0.5) },
   DiagnosticSignWarn = { fg = u.color_gamma(p.purple, 0.5) },
}

hl.plugins.whichkey = {
   WhichKey = hl.predef.Red,
   WhichKeyDesc = hl.predef.Blue,
   WhichKeyGroup = hl.predef.Fg,
   WhichKeySeperator = hl.predef.PurpleBold,
}

hl.plugins.gitgutter = {
   GitGutterAdd = { fg = p.bg_green },
   GitGutterChange = { fg = p.blue },
   GitGutterDelete = { fg = p.purple },
}

hl.plugins.diffview = {
   DiffviewFilePanelTitle = { fg = p.blue, bold = true },
   DiffviewFilePanelCounter = { fg = p.purple, bold = true },
   DiffviewFilePanelFileName = hl.predef.Fg,
   DiffviewNormal = hl.common.Normal,
   DiffviewCursorLine = hl.common.CursorLine,
   DiffviewVertSplit = hl.common.VertSplit,
   DiffviewSignColumn = hl.common.SignColumn,
   DiffviewStatusLine = hl.common.StatusLine,
   DiffviewStatusLineNC = hl.common.StatusLineNC,
   DiffviewEndOfBuffer = hl.common.EndOfBuffer,
   DiffviewFilePanelRootPath = hl.predef.Grey,
   DiffviewFilePanelPath = hl.predef.Grey,
   DiffviewFilePanelInsertions = hl.predef.PurpleBold,
   DiffviewFilePanelDeletions = hl.predef.Red,
   DiffviewStatusAdded = hl.predef.PurpleBold,
   DiffviewStatusUntracked = hl.predef.Blue,
   DiffviewStatusModified = hl.predef.Blue,
   DiffviewStatusRenamed = hl.predef.Blue,
   DiffviewStatusCopied = hl.predef.Blue,
   DiffviewStatusTypeChange = hl.predef.Blue,
   DiffviewStatusUnmerged = hl.predef.Blue,
   DiffviewStatusUnknown = hl.predef.Red,
   DiffviewStatusDeleted = hl.predef.Red,
   DiffviewStatusBroken = hl.predef.Red,
}

hl.plugins.treesitter = {
   commentTSDanger = hl.predef.RedItalic,
   commentTSNote = hl.predef.BlueItalic,
   commentTSWarning = hl.predef.PurpleItalic,
}

hl.plugins.cmp = {
   CmpItemKind = hl.predef.Blue,
   CmpItemAbbrMatch = hl.predef.Red,
   CmpItemAbbrMatchFuzzy = hl.predef.Fg,
}

hl.plugins.blankline = {
   IndentBlanklineChar = { fg = p.bg1 },
   IndentBlanklineContextChar = { fg = p.bg5 },
}

hl.plugins.hop = {
   HopNextKey = { fg = p.red },
   HopNextKey1 = { fg = p.purple },
   HopNextKey2 = { fg = p.blue },
   HopUnmatched = { fg = p.bg3 },
}

hl.plugins.gitsigns = {
   GitSignsAdd = { fg = p.purple },
   GitSignsAddLn = { fg = p.purple },
   GitSignsAddNr = { fg = p.purple },
   GitSignsChange = { fg = p.yellow },
   GitSignsChangeLn = { fg = p.yellow },
   GitSignsChangeNr = { fg = p.yellow },
   GitSignsDelete = { fg = p.grey },
   GitSignsDeleteLn = { fg = p.grey },
   GitSignsDeleteNr = { fg = p.grey },
}

hl.plugins.telescope = {
   TelescopeSelectionCaret = { fg = p.red },
   TelescopeSelection = hl.predef.Fg,
   TelescopeMatching = hl.predef.Fg,
}

function M.clear_namespace()
   vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
   set_hl_ns(0)
end

local function load_sync()
   load_highlights(hl.predef)
   load_highlights(hl.common)
   load_highlights(hl.syntax)
   for _, group in pairs(hl.plugins) do
      load_highlights(group)
   end
   set_hl_ns(ns)
end

function M.setup()
   load_sync()
end

return M
