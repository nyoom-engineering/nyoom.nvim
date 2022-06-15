(require-macros :macros.highlight-macros)
(import-macros {: set!} :macros.option-macros)
(import-macros {: let!} :macros.variable-macros)

;; theme
(set! termguicolors)
(set! background :dark)
(set! guifont "Liga SFMono Nerd Font:h15")

;; Losely based off of IBM Carbon Palette [https://www.ibm.com/brand/experience-guides/developer/brand/color/)
(local carbon (or (and (= vim.o.background :dark)
                   {:base00 "#161616" ;; The origin color or the Carbon palette
                    :base01 "#262626" ;; A brighter shade color based on base00
                    :base02 "#393939" ;; An even more brighter shade color of base00
                    :base03 "#525252" ;; The brightest shade color based on base00
                    :base04 "#dde1e6" ;; The origin color or the Snow Storm sequence.
                    :base05 "#f2f4f8" ;; A brighter shade color of base04
                    :base06 "#ffffff" ;; The brightest shade color based on base04
                    :base07 "#08bdba" ;; A calm and highly contrasted color reminiscent of glowing ice
                    :base08 "#3ddbd9" ;; The bright and shiny primary accent color reminiscent of pure and clear energy
                    :base09 "#ff7eb6" ;; A more darkened and less saturated color reminiscent of cherry blossoms
                    :base10 "#ee5396" ;; A dark and intensive color reminiscent of the withering flowers come fall
                    :base11 "#33b1ff" ;; But never have I been a blue calm sea. I have always been a storm
                    :base12 "#78a9ff" ;; And the sky was never quite the same shade of blue again
                    :base13 "#42be65" ;; Nature in her green, tranquil woods heals and soothes all afflictions
                    :base14 "#be95ff" ;; I want to watch wisteria grow right over my bare feet
                    :base15 "#82cfff" ;; A book must be an ice axe to break the seas frozen inside our soul
                    :blend  "#131313" ;; Blend of #000000 & base00 for darker accents 
                    :none :NONE})
               {:base00 "#ECEFF4" ;; The origin color or the Carbon palette
                :base01 "#E5E9F0" ;; A brighter shade color based on base00
                :base02 "#D8DEE9" ;; An even more brighter shade color of base00
                :base03 "#4C566A" ;; The brightest shade color based on base00
                :base04 "#434C5E" ;; The origin color or the Snow Storm sequence.
                :base05 "#3B4252" ;; A brighter shade color of base04
                :base06 "#2E3440" ;; The brightest shade color based on base04
                :base07 "#8FBCBB" ;; A calm and highly contrasted color reminiscent of glowing ice
                :base08 "#88C0D0" ;; The bright and shiny primary accent color reminiscent of pure and clear energy
                :base09 "#81A1C1" ;; A more darkened and less saturated color reminiscent of cherry blossoms
                :base10 "#5E81AC" ;; A dark and intensive color reminiscent of the withering flowers come fall
                :base11 "#BF616A" ;; But never have I been a blue calm sea. I have always been a storm
                :base12 "#D08770" ;; And the sky was never quite the same shade of blue again
                :base13 "#EBCB8B" ;; Nature in her green, tranquil woods heals and soothes all afflictions
                :base14 "#A3BE8C" ;; I want to watch wisteria grow right over my bare feet
                :base15 "#B48EAD" ;; A book must be an ice axe to break the seas frozen inside our soul
                :blend  "#FAFAFA" ;; Blend of #000000 & base00 for darker accents 
                :none :NONE}))
  
;; terminal 
(let! terminal_color_0 carbon.base01)
(let! terminal_color_1 carbon.base11)
(let! terminal_color_2 carbon.base14)
(let! terminal_color_3 carbon.base13)
(let! terminal_color_4 carbon.base09)
(let! terminal_color_5 carbon.base15)
(let! terminal_color_6 carbon.base08)
(let! terminal_color_7 carbon.base05)
(let! terminal_color_8 carbon.base03)
(let! terminal_color_9 carbon.base11)
(let! terminal_color_10 carbon.base14)
(let! terminal_color_11 carbon.base13)
(let! terminal_color_12 carbon.base09)
(let! terminal_color_13 carbon.base15)
(let! terminal_color_14 carbon.base07)
(let! terminal_color_15 carbon.base06)

;; editor
(custom-set-face! ColorColumn [:nil] {:fg carbon.none :bg carbon.base01})
(custom-set-face! Cursor [:nil] {:fg carbon.base00 :bg carbon.base04})
(custom-set-face! CursorLine [:nil] {:fg carbon.none :bg carbon.base01})
(custom-set-face! CursorColumn [:nil] {:fg carbon.none :bg carbon.base01})
(custom-set-face! CursorLineNr [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! Error [:nil] {:fg carbon.base04 :bg carbon.base11})
(custom-set-face! LineNr [:nil] {:fg carbon.base03 :bg carbon.none})
;; (custom-set-face! MatchParen [:underline] {:bg carbon.base02})
(vim.cmd "hi MatchParen gui=underline guibg=#393939")
(custom-set-face! NonText [:nil] {:fg carbon.base02 :bg carbon.none})
(custom-set-face! Normal [:nil] {:fg carbon.base04 :bg carbon.base00})
(custom-set-face! Pmenu [:nil] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! PmenuSbar [:nil] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! PmenuSel [:nil] {:fg carbon.base08 :bg carbon.base02})
(custom-set-face! PmenuThumb [:nil] {:fg carbon.base08 :bg carbon.base02})
(custom-set-face! SpecialKey [:nil] {:fg carbon.base03 :bg carbon.none})
(custom-set-face! Visual [:nil] {:fg carbon.none :bg carbon.base02})
(custom-set-face! VisualNOS [:nil] {:fg carbon.none :bg carbon.base02})

;; diagnostic
(custom-set-face! DiagnosticWarn [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! DiagnosticError [:nil] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! DiagnosticInfo [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! DiagnosticHint [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! DiagnosticUnderlineWarn [:undercurl] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! DiagnosticUnderlineError [:undercurl] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! DiagnosticUnderlineInfo [:undercurl] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! DiagnosticUnderlineHint [:undercurl] {:fg carbon.base04 :bg carbon.none})

;; lsp
(custom-set-face! LspReferenceText [:nil] {:fg carbon.none :bg carbon.base03})
(custom-set-face! LspReferenceRead [:nil] {:fg carbon.none :bg carbon.base03})
(custom-set-face! LspReferenceWrite [:nil] {:fg carbon.none :bg carbon.base03})
(custom-set-face! LspSignatureActiveParameter [:nil] {:fg carbon.base08 :bg carbon.none})
(link! LspDiagnosticsDefaultError => DiagnosticError)
(link! LspDiagnosticsDefaultWarning => DiagnosticWarn)
(link! LspDiagnosticsDefaultInformation => DiagnosticInfo)
(link! LspDiagnosticsDefaultHint => DiagnosticHint)
(link! LspDiagnosticsUnderlineError  => DiagnosticUnderlineError)
(link! LspDiagnosticsUnderlineWarning => DiagnosticUnderlineWarn)
(link! LspDiagnosticsUnderlineInformation => DiagnosticUnderlineInformation)
(link! LspDiagnosticsUnderlineHint => DiagnosticUnderlineHint)

;; gutter
(custom-set-face! Folded [:nil] {:fg carbon.base03 :bg carbon.base01})
(custom-set-face! FoldColumn [:nil] {:fg carbon.base03 :bg carbon.base00})
(custom-set-face! SignColumn [:nil] {:fg carbon.base01 :bg carbon.base00})

;; navigation
(custom-set-face! Directory [:nil] {:fg carbon.base08 :bg carbon.none})

;; prompts & status
(custom-set-face! EndOfBuffer [:nil] {:fg carbon.base01 :bg carbon.none})
(custom-set-face! ErrorMsg [:nil] {:fg carbon.base04 :bg carbon.base11})
(custom-set-face! ModeMsg [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! MoreMsg [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! Question [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! WarningMsg [:nil] {:fg carbon.base00 :bg carbon.base13})
(custom-set-face! WildMenu [:nil] {:fg carbon.base08 :bg carbon.base01})

;; search
(custom-set-face! IncSearch [:nil] {:fg carbon.base06 :bg carbon.base10})
(custom-set-face! Search [:nil] {:fg carbon.base01 :bg carbon.base08})

;; tabs
(custom-set-face! TabLine [:nil] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! TabLineFill [:nil] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! TabLineSel [:nil] {:fg carbon.base08 :bg carbon.base03})

;; window
(custom-set-face! Title [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! VertSplit [:nil] {:fg carbon.base02 :bg carbon.base00})

;; Regular Syntax 
(custom-set-face! Boolean [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Character [:nil] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! Comment [:nil] {:fg carbon.base03 :bg carbon.none})
(custom-set-face! Conceal [:nil] {:fg carbon.none :bg carbon.none})
(custom-set-face! Conditional [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Constant [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! Decorator [:nil] {:fg carbon.base12 :bg carbon.none})
(custom-set-face! Define [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Delimeter [:nil] {:fg carbon.base06 :bg carbon.none})
(custom-set-face! Exception [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Float [:nil] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! Function [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! Indentifier [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! Include [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Keyword [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Label [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Number [:nil] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! Operator [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! PreProc [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Repeat [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Special [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! SpecialChar [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! SpecialComment [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! Statement [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! StorageClass [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! String [:nil] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! Structure [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Tag [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! Todo [:nil] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! Type [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Typedef [:nil] {:fg carbon.base09 :bg carbon.none})

;; Treesitter
(custom-set-face! TSAnnotation [:nil] {:fg carbon.base12 :bg carbon.none})
(custom-set-face! TSAttribute [:nil] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSBoolean [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSCharacter [:nil] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! TSComment [:italic] {:fg carbon.base03 :bg carbon.none})
(custom-set-face! TSConstructor [:nil] {:fg carbon.base0 :bg carbon.none})
(custom-set-face! TSConditional [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSConstant [:nil] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! TSConstBuiltin [:nil] {:fg carbon.base07 :bg carbon.none})
(custom-set-face! TSConstMacro [:nil] {:fg carbon.base07 :bg carbon.none})
(custom-set-face! TSError [:nil] {:fg carbon.base11 :bg carbon.none})
(custom-set-face! TSException [:nil] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSField [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSFloat [:nil] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSFunction [:bold] {:fg carbon.base12})
(custom-set-face! TSFuncBuiltin [:nil] {:fg carbon.base12 :bg carbon.none})
(custom-set-face! TSFuncMacro [:nil] {:fg carbon.base07 :bg carbon.none})
(custom-set-face! TSInclude [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSKeyword [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSKeywordFunction [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! TSKeywordOperator [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! TSLabel [:nil] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSMethod [:nil] {:fg carbon.base07 :bg carbon.none})
(custom-set-face! TSNamespace [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSNumber [:nil] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSOperator [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSParameter [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSParameterReference [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSProperty [:nil] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! TSPunctDelimiter [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! TSPunctBracket [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! TSPunctSpecial [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! TSRepeat [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSString [:nil] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! TSStringRegex [:nil] {:fg carbon.base07 :bg carbon.none})
(custom-set-face! TSStringEscape [:nil] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSSymbol [:bold] {:fg carbon.base15})
(custom-set-face! TSTag [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSTagDelimiter [:nil] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSText [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSStrong [:bold] {:fg carbon.none :bg carbon.none})
(custom-set-face! TSEmphasis [:bold] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! TSUnderline [:underline] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSStrike [:strikethrough] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSTitle [:nil] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! TSLiteral [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSURI [:underline] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! TSType [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSTypeBuiltin [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSVariable [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSVariableBuiltin [:nil] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSCurrentScope [:bold] {:fg carbon.none :bg carbon.none})
(custom-set-face! TreesitterContext [:nil] {:fg carbon.none :bg carbon.base01})

;; Neovim-specific
(custom-set-face! NvimInternalError [:nil] {:fg carbon.base00 :bg carbon.base08})
(custom-set-face! NormalFloat [:nil] {:fg carbon.base05 :bg carbon.base00})
(custom-set-face! FloatBorder [:nil] {:fg carbon.base05 :bg carbon.base00})
(custom-set-face! NormalNC [:nil] {:fg carbon.base05 :bg carbon.base00})
(custom-set-face! TermCursor [:nil] {:fg carbon.base00 :bg carbon.base04})
(custom-set-face! TermCursorNC [:nil] {:fg carbon.base00 :bg carbon.base04})

;; minimal highlights
(custom-set-face! StatusLine [:nil] {:fg carbon.base04 :bg carbon.base00})
(custom-set-face! StatusPosition [:nil] {:fg :#a2a9b0 :bg carbon.base00})
(custom-set-face! StatusNormal [:nil] {:fg carbon.base00 :bg carbon.base09})
(custom-set-face! StatusReplace [:nil] {:fg carbon.base00 :bg carbon.base08})
(custom-set-face! StatusInsert [:nil] {:fg carbon.base00 :bg carbon.base11})
(custom-set-face! StatusVisual [:nil] {:fg carbon.base00 :bg carbon.base14})
(custom-set-face! StatusTerminal [:nil] {:fg carbon.base00 :bg carbon.base15})
;; (custom-set-face! StatusLineDiagnosticWarn [:bold] {:fg carbon.base14 :bg carbon.base00})
;; (custom-set-face! StatusLineDiagnosticError [:bold] {:fg carbon.base09 :bg carbon.base00})
(vim.cmd "hi StatusLineDiagnosticWarn gui=bold guifg=#be95ff guibg=#161616")
(vim.cmd "hi StatusLineDiagnosticError gui=bold guifg=#ff7eb6 guibg=#161616")
(link! StatusCommand => StatusNormal)

;; telescope
(custom-set-face! TelescopeBorder [:nil] {:fg carbon.blend :bg carbon.blend})
(custom-set-face! TelescopePromptBorder [:nil] {:fg carbon.base02 :bg carbon.base02})
(custom-set-face! TelescopePromptNormal [:nil] {:fg carbon.base05 :bg carbon.base02})
(custom-set-face! TelescopePromptPrefix [:nil] {:fg carbon.base08 :bg carbon.base02})
(custom-set-face! TelescopeNormal [:nil] {:fg carbon.none :bg carbon.blend})
(custom-set-face! TelescopePreviewTitle [:nil] {:fg carbon.base02 :bg carbon.base11})
(custom-set-face! TelescopePromptTitle [:nil] {:fg carbon.base02 :bg carbon.base08})
(custom-set-face! TelescopeResultsTitle [:nil] {:fg carbon.blend :bg carbon.blend})
(custom-set-face! TelescopeSelection [:nil] {:fg carbon.none :bg carbon.base02})
(custom-set-face! TelescopePreviewLine [:nil] {:fg carbon.none :bg carbon.base01})

;; nvim-notify
(custom-set-face! NotifyERRORBorder [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! NotifyWARNBorder [:nil] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! NotifyINFOBorder [:nil] {:fg carbon.base05 :bg carbon.none})
(custom-set-face! NotifyDEBUGBorder [:nil] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! NotifyTRACEBorder [:nil] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! NotifyERRORIcon [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! NotifyWARNIcon [:nil] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! NotifyINFOIcon [:nil] {:fg carbon.base05 :bg carbon.none})
(custom-set-face! NotifyDEBUGIcon [:nil] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! NotifyTRACEIcon [:nil] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! NotifyERRORTitle [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! NotifyWARNTitle [:nil] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! NotifyINFOTitle [:nil] {:fg carbon.base05 :bg carbon.none})
(custom-set-face! NotifyDEBUGTitle [:nil] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! NotifyTRACETitle [:nil] {:fg carbon.base13 :bg carbon.none})

;; cmp: company-ish look 
(custom-set-face! CmpItemAbbr [:nil] {:fg carbon.base03})
(custom-set-face! CmpItemAbbrMatch [:nil] {:fg carbon.base05})
(custom-set-face! CmpItemAbbrMatchFuzzy [:nil] {:fg carbon.base04})
(link! CmpItemKindInterface => CmpItemKindVariable)
(link! CmpItemKindText => CmpItemKindVariable)
(link! CmpItemKindProperty => CmpItemKindKeyword)
(link! CmpItemKindUnit => CmpItemKindKeyword)
(link! CmpItemKindFunction => CmpItemKindMethod)

 ;; cleaner nvimtree
(custom-set-face! NvimTreeImageFile [:nil] {:fg carbon.base12})
(custom-set-face! NvimTreeFolderIcon [:nil] {:fg carbon.base12})
(custom-set-face! NvimTreeWinSeparator [:nil] {:fg carbon.base00 :bg carbon.base00})
(custom-set-face! NvimTreeFolderName [:nil] {:fg carbon.base09})
(custom-set-face! NvimTreeIndentMarker [:nil] {:fg carbon.base02})
(custom-set-face! NvimTreeEmptyFolderName [:nil] {:fg carbon.base15})
(custom-set-face! NvimTreeOpenedFolderName [:nil] {:fg carbon.base15})
(custom-set-face! NvimTreeNormal [:nil] {:fg carbon.base04 :bg carbon.blend})

;; bufferline: just match it with NvimTree
(custom-set-face! BufferLineFill [:nil] {:bg carbon.blend})
(custom-set-face! BufferLineBackground [:nil] {:bg carbon.blend})
(custom-set-face! BufferLineTabClose [:nil] {:fg carbon.base03 :bg carbon.blend})
(custom-set-face! BufferLineSeparator [:nil] {:fg carbon.base00 :bg carbon.blend})
(custom-set-face! BufferLineCloseButton [:nil] {:fg carbon.base03 :bg carbon.blend})

;; neogit
(custom-set-face! NeogitBranch [:nil] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! NeogitRemote [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! NeogitDiffAddHighlight [:nil] {:fg carbon.base13 :bg carbon.base02})
(custom-set-face! NeogitDiffDeleteHighlight [:nil] {:fg carbon.base19 :bg carbon.base02})
(custom-set-face! NeogitDiffContextHighlight [:nil] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! NeogitHunkHeader [:nil] {:fg carbon.base04 :bg carbon.base02})
(custom-set-face! NeogitHunkHeaderHighlight [:nil] {:fg carbon.base04 :bg carbon.base03})

;; gitsigns
(custom-set-face! GitSignsAdd [:nil] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! GitSignsChange [:nil] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! GitSignsDelete [:nil] {:fg carbon.base14 :bg carbon.none})

