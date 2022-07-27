















 local carbon = (((vim.o.background == "dark") and {base00 = "#161616", base01 = "#262626", base02 = "#393939", base03 = "#525252", base04 = "#dde1e6", base05 = "#f2f4f8", base06 = "#ffffff", base07 = "#08bdba", base08 = "#3ddbd9", base09 = "#78a9ff", base10 = "#ee5396", base11 = "#33b1ff", base12 = "#ff7eb6", base13 = "#42be65", base14 = "#be95ff", base15 = "#82cfff", blend = "#131313", none = "NONE"}) or {base00 = "#FFFFFF", base01 = "#FAFAFA", base02 = "#ECEFF1", base03 = "#161616", base04 = "#37474F", base05 = "#90A4AE", base06 = "#525252", base07 = "#08bdba", base08 = "#ff7eb6", base09 = "#ee5396", base10 = "#FF6F00", base11 = "#0f62fe", base12 = "#673AB7", base13 = "#42be65", base14 = "#be95ff", base15 = "#FFAB91", blend = "#FAFAFA", none = "NONE"})






































 do end (vim.g)["terminal_color_0"] = carbon.base01
 vim.g["terminal_color_1"] = carbon.base11
 vim.g["terminal_color_2"] = carbon.base14
 vim.g["terminal_color_3"] = carbon.base13
 vim.g["terminal_color_4"] = carbon.base09
 vim.g["terminal_color_5"] = carbon.base15
 vim.g["terminal_color_6"] = carbon.base08
 vim.g["terminal_color_7"] = carbon.base05
 vim.g["terminal_color_8"] = carbon.base03
 vim.g["terminal_color_9"] = carbon.base11
 vim.g["terminal_color_10"] = carbon.base14
 vim.g["terminal_color_11"] = carbon.base13
 vim.g["terminal_color_12"] = carbon.base09
 vim.g["terminal_color_13"] = carbon.base15
 vim.g["terminal_color_14"] = carbon.base07
 vim.g["terminal_color_15"] = carbon.base06


 vim.api.nvim_set_hl(0, "ColorColumn", {fg = carbon.none, bg = carbon.base01})
 vim.api.nvim_set_hl(0, "Cursor", {fg = carbon.base00, bg = carbon.base04})
 vim.api.nvim_set_hl(0, "CursorLine", {fg = carbon.none, bg = carbon.base01})
 vim.api.nvim_set_hl(0, "CursorColumn", {fg = carbon.none, bg = carbon.base01})
 vim.api.nvim_set_hl(0, "CursorLineNr", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Error", {fg = carbon.base04, bg = carbon.base11})
 vim.api.nvim_set_hl(0, "LineNr", {fg = carbon.base03, bg = carbon.none})
 vim.api.nvim_set_hl(0, "MatchParen", {bg = carbon.base02, underline = true})
 vim.api.nvim_set_hl(0, "NonText", {fg = carbon.base02, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Normal", {fg = carbon.base04, bg = carbon.base00})
 vim.api.nvim_set_hl(0, "Pmenu", {fg = carbon.base04, bg = carbon.base01})
 vim.api.nvim_set_hl(0, "PmenuSbar", {fg = carbon.base04, bg = carbon.base01})
 vim.api.nvim_set_hl(0, "PmenuSel", {fg = carbon.base08, bg = carbon.base02})
 vim.api.nvim_set_hl(0, "PmenuThumb", {fg = carbon.base08, bg = carbon.base02})
 vim.api.nvim_set_hl(0, "SpecialKey", {fg = carbon.base03, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Visual", {fg = carbon.none, bg = carbon.base02})
 vim.api.nvim_set_hl(0, "VisualNOS", {fg = carbon.none, bg = carbon.base02})


 vim.api.nvim_set_hl(0, "DiagnosticWarn", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "DiagnosticError", {fg = carbon.base10, bg = carbon.none})
 vim.api.nvim_set_hl(0, "DiagnosticInfo", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "DiagnosticHint", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {fg = carbon.base08, bg = carbon.none, undercurl = true})
 vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {fg = carbon.base10, bg = carbon.none, undercurl = true})
 vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {fg = carbon.base04, bg = carbon.none, undercurl = true})
 vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {fg = carbon.base04, bg = carbon.none, undercurl = true})


 vim.api.nvim_set_hl(0, "LspReferenceText", {fg = carbon.none, bg = carbon.base03})
 vim.api.nvim_set_hl(0, "LspReferenceRead", {fg = carbon.none, bg = carbon.base03})
 vim.api.nvim_set_hl(0, "LspReferenceWrite", {fg = carbon.none, bg = carbon.base03})
 vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultError", {link = "DiagnosticError"})
 vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultWarning", {link = "DiagnosticWarn"})
 vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultInformation", {link = "DiagnosticInfo"})
 vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultHint", {link = "DiagnosticHint"})
 vim.api.nvim_set_hl(0, "LspDiagnosticsUnderlineError", {link = "DiagnosticUnderlineError"})
 vim.api.nvim_set_hl(0, "LspDiagnosticsUnderlineWarning", {link = "DiagnosticUnderlineWarn"})
 vim.api.nvim_set_hl(0, "LspDiagnosticsUnderlineInformation", {link = "DiagnosticUnderlineInformation"})
 vim.api.nvim_set_hl(0, "LspDiagnosticsUnderlineHint", {link = "DiagnosticUnderlineHint"})


 vim.api.nvim_set_hl(0, "Folded", {fg = carbon.base03, bg = carbon.base01})
 vim.api.nvim_set_hl(0, "FoldColumn", {fg = carbon.base03, bg = carbon.base00})
 vim.api.nvim_set_hl(0, "SignColumn", {fg = carbon.base01, bg = carbon.base00})


 vim.api.nvim_set_hl(0, "Directory", {fg = carbon.base08, bg = carbon.none})


 vim.api.nvim_set_hl(0, "EndOfBuffer", {fg = carbon.base01, bg = carbon.none})
 vim.api.nvim_set_hl(0, "ErrorMsg", {fg = carbon.base04, bg = carbon.base11})
 vim.api.nvim_set_hl(0, "ModeMsg", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "MoreMsg", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Question", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "WarningMsg", {fg = carbon.base00, bg = carbon.base13})
 vim.api.nvim_set_hl(0, "WildMenu", {fg = carbon.base08, bg = carbon.base01})


 vim.api.nvim_set_hl(0, "IncSearch", {fg = carbon.base06, bg = carbon.base10})
 vim.api.nvim_set_hl(0, "Search", {fg = carbon.base01, bg = carbon.base08})


 vim.api.nvim_set_hl(0, "TabLine", {fg = carbon.base04, bg = carbon.base01})
 vim.api.nvim_set_hl(0, "TabLineFill", {fg = carbon.base04, bg = carbon.base01})
 vim.api.nvim_set_hl(0, "TabLineSel", {fg = carbon.base08, bg = carbon.base03})


 vim.api.nvim_set_hl(0, "Title", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "VertSplit", {fg = carbon.base02, bg = carbon.base00})


 vim.api.nvim_set_hl(0, "Boolean", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Character", {fg = carbon.base14, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Comment", {fg = carbon.base03, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Conceal", {fg = carbon.none, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Conditional", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Constant", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Decorator", {fg = carbon.base12, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Define", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Delimeter", {fg = carbon.base06, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Exception", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Float", {fg = carbon.base15, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Function", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Indentifier", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Include", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Keyword", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Label", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Number", {fg = carbon.base15, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Operator", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "PreProc", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Repeat", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Special", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "SpecialChar", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "SpecialComment", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Statement", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "StorageClass", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "String", {fg = carbon.base14, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Structure", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Tag", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Todo", {fg = carbon.base13, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Type", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "Typedef", {fg = carbon.base09, bg = carbon.none})


 vim.api.nvim_set_hl(0, "TSAnnotation", {fg = carbon.base12, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSAttribute", {fg = carbon.base15, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSBoolean", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSCharacter", {fg = carbon.base14, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSComment", {fg = carbon.base03, bg = carbon.none, italic = true})
 vim.api.nvim_set_hl(0, "TSConstructor", {fg = carbon.base0, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSConditional", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSConstant", {fg = carbon.base14, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSConstBuiltin", {fg = carbon.base07, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSConstMacro", {fg = carbon.base07, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSError", {fg = carbon.base11, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSException", {fg = carbon.base15, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSField", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSFloat", {fg = carbon.base15, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSFunction", {fg = carbon.base12, bold = true})
 vim.api.nvim_set_hl(0, "TSFuncBuiltin", {fg = carbon.base12, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSFuncMacro", {fg = carbon.base07, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSInclude", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSKeyword", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSKeywordFunction", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSKeywordOperator", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSLabel", {fg = carbon.base15, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSMethod", {fg = carbon.base07, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSNamespace", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSNumber", {fg = carbon.base15, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSOperator", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSParameter", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSParameterReference", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSProperty", {fg = carbon.base10, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSPunctDelimiter", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSPunctBracket", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSPunctSpecial", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSRepeat", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSString", {fg = carbon.base14, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSStringRegex", {fg = carbon.base07, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSStringEscape", {fg = carbon.base15, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSSymbol", {fg = carbon.base15, bold = true})
 vim.api.nvim_set_hl(0, "TSTag", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSTagDelimiter", {fg = carbon.base15, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSText", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSStrong", {fg = carbon.none, bg = carbon.none, bold = true})
 vim.api.nvim_set_hl(0, "TSEmphasis", {fg = carbon.base10, bg = carbon.none, bold = true})
 vim.api.nvim_set_hl(0, "TSUnderline", {fg = carbon.base04, bg = carbon.none, underline = true})
 vim.api.nvim_set_hl(0, "TSStrike", {fg = carbon.base04, bg = carbon.none, strikethrough = true})
 vim.api.nvim_set_hl(0, "TSTitle", {fg = carbon.base10, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSLiteral", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSURI", {fg = carbon.base14, bg = carbon.none, underline = true})
 vim.api.nvim_set_hl(0, "TSType", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSTypeBuiltin", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSVariable", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSVariableBuiltin", {fg = carbon.base04, bg = carbon.none})
 vim.api.nvim_set_hl(0, "TSCurrentScope", {fg = carbon.none, bg = carbon.none, bold = true})
 vim.api.nvim_set_hl(0, "TreesitterContext", {fg = carbon.none, bg = carbon.base01})


 vim.api.nvim_set_hl(0, "NvimInternalError", {fg = carbon.base00, bg = carbon.base08})
 vim.api.nvim_set_hl(0, "NormalFloat", {fg = carbon.base05, bg = carbon.base00})
 vim.api.nvim_set_hl(0, "FloatBorder", {fg = carbon.base05, bg = carbon.base00})
 vim.api.nvim_set_hl(0, "NormalNC", {fg = carbon.base05, bg = carbon.base00})
 vim.api.nvim_set_hl(0, "TermCursor", {fg = carbon.base00, bg = carbon.base04})
 vim.api.nvim_set_hl(0, "TermCursorNC", {fg = carbon.base00, bg = carbon.base04})


 vim.api.nvim_set_hl(0, "StatusLine", {fg = carbon.base03, bg = carbon.base00})
 vim.api.nvim_set_hl(0, "WinBar", {fg = "#a2a9b0", bg = carbon.base00})
 vim.api.nvim_set_hl(0, "StatusNormal", {fg = "#a2a9b0", bg = carbon.base00, underline = true})
 vim.api.nvim_set_hl(0, "StatusPosition", {fg = "#a2a9b0", bg = carbon.base00})
 vim.api.nvim_set_hl(0, "StatusReplace", {fg = carbon.base00, bg = carbon.base08})
 vim.api.nvim_set_hl(0, "StatusInsert", {fg = carbon.base00, bg = carbon.base12})
 vim.api.nvim_set_hl(0, "StatusVisual", {fg = carbon.base00, bg = carbon.base14})
 vim.api.nvim_set_hl(0, "StatusTerminal", {fg = carbon.base00, bg = carbon.base11})
 vim.api.nvim_set_hl(0, "StatusLineDiagnosticWarn", {fg = carbon.base14, bg = carbon.base00, bold = true})
 vim.api.nvim_set_hl(0, "StatusLineDiagnosticError", {fg = carbon.base09, bg = carbon.base00, bold = true})
 vim.api.nvim_set_hl(0, "StatusCommand", {link = "StatusNormal"})


 vim.api.nvim_set_hl(0, "TelescopeBorder", {fg = carbon.blend, bg = carbon.blend})
 vim.api.nvim_set_hl(0, "TelescopePromptBorder", {fg = carbon.base02, bg = carbon.base02})
 vim.api.nvim_set_hl(0, "TelescopePromptNormal", {fg = carbon.base05, bg = carbon.base02})
 vim.api.nvim_set_hl(0, "TelescopePromptPrefix", {fg = carbon.base08, bg = carbon.base02})
 vim.api.nvim_set_hl(0, "TelescopeNormal", {fg = carbon.none, bg = carbon.blend})
 vim.api.nvim_set_hl(0, "TelescopePreviewTitle", {fg = carbon.base02, bg = carbon.base11})
 vim.api.nvim_set_hl(0, "TelescopePromptTitle", {fg = carbon.base02, bg = carbon.base08})
 vim.api.nvim_set_hl(0, "TelescopeResultsTitle", {fg = carbon.blend, bg = carbon.blend})
 vim.api.nvim_set_hl(0, "TelescopeSelection", {fg = carbon.none, bg = carbon.base02})
 vim.api.nvim_set_hl(0, "TelescopePreviewLine", {fg = carbon.none, bg = carbon.base01})


 vim.api.nvim_set_hl(0, "NotifyERRORBorder", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyWARNBorder", {fg = carbon.base15, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyINFOBorder", {fg = carbon.base05, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", {fg = carbon.base13, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyTRACEBorder", {fg = carbon.base13, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyERRORIcon", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyWARNIcon", {fg = carbon.base15, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyINFOIcon", {fg = carbon.base05, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", {fg = carbon.base13, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyTRACEIcon", {fg = carbon.base13, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyERRORTitle", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyWARNTitle", {fg = carbon.base15, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyINFOTitle", {fg = carbon.base05, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", {fg = carbon.base13, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NotifyTRACETitle", {fg = carbon.base13, bg = carbon.none})


 vim.api.nvim_set_hl(0, "CmpItemAbbr", {fg = carbon.base03})
 vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {fg = carbon.base05})
 vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", {fg = carbon.base04})
 vim.api.nvim_set_hl(0, "CmpItemKindInterface", {link = "CmpItemKindVariable"})
 vim.api.nvim_set_hl(0, "CmpItemKindText", {link = "CmpItemKindVariable"})
 vim.api.nvim_set_hl(0, "CmpItemKindProperty", {link = "CmpItemKindKeyword"})
 vim.api.nvim_set_hl(0, "CmpItemKindUnit", {link = "CmpItemKindKeyword"})
 vim.api.nvim_set_hl(0, "CmpItemKindFunction", {link = "CmpItemKindMethod"})


 vim.api.nvim_set_hl(0, "NvimTreeImageFile", {fg = carbon.base12})
 vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", {fg = carbon.base12})
 vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", {fg = carbon.base00, bg = carbon.base00})
 vim.api.nvim_set_hl(0, "NvimTreeFolderName", {fg = carbon.base09})
 vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", {fg = carbon.base02})
 vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", {fg = carbon.base15})
 vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", {fg = carbon.base15})
 vim.api.nvim_set_hl(0, "NvimTreeNormal", {fg = carbon.base04, bg = carbon.blend})


 vim.api.nvim_set_hl(0, "BufferLineFill", {bg = carbon.blend})
 vim.api.nvim_set_hl(0, "BufferLineBackground", {bg = carbon.blend})
 vim.api.nvim_set_hl(0, "BufferLineTabClose", {fg = carbon.base03, bg = carbon.blend})
 vim.api.nvim_set_hl(0, "BufferLineSeparator", {fg = carbon.base00, bg = carbon.blend})
 vim.api.nvim_set_hl(0, "BufferLineCloseButton", {fg = carbon.base03, bg = carbon.blend})


 vim.api.nvim_set_hl(0, "NeogitBranch", {fg = carbon.base10, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NeogitRemote", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight", {fg = carbon.base13, bg = carbon.base02})
 vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", {fg = carbon.base19, bg = carbon.base02})
 vim.api.nvim_set_hl(0, "NeogitDiffContextHighlight", {fg = carbon.base04, bg = carbon.base01})
 vim.api.nvim_set_hl(0, "NeogitHunkHeader", {fg = carbon.base04, bg = carbon.base02})
 vim.api.nvim_set_hl(0, "NeogitHunkHeaderHighlight", {fg = carbon.base04, bg = carbon.base03})


 vim.api.nvim_set_hl(0, "GitSignsAdd", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "GitSignsChange", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "GitSignsDelete", {fg = carbon.base14, bg = carbon.none})


 vim.api.nvim_set_hl(0, "Trailhighlight", {fg = carbon.base03, bg = carbon.none})


 vim.api.nvim_set_hl(0, "HydraRed", {fg = carbon.base12, bg = carbon.none})
 vim.api.nvim_set_hl(0, "HydraBlue", {fg = carbon.base09, bg = carbon.none})
 vim.api.nvim_set_hl(0, "HydraAmaranth", {fg = carbon.base10, bg = carbon.none})
 vim.api.nvim_set_hl(0, "HydraTeal", {fg = carbon.base08, bg = carbon.none})
 vim.api.nvim_set_hl(0, "HydraPink", {fg = carbon.base14, bg = carbon.none})
 return vim.api.nvim_set_hl(0, "HydraHint", {fg = carbon.none, bg = carbon.blend})