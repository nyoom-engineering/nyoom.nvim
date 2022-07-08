(require-macros :macros.highlight-macros)
(import-macros {: set!} :macros.option-macros)
(import-macros {: let!} :macros.variable-macros)

;; theme
(set! termguicolors)
(set! background :dark)
(set! guifont "Liga SFMono Nerd Font:h15")

;; neovide options
(let! neovide_cursor_vfx_mode :pixiedust)
(let! neovide_floating_blur_amount_x 5.0)
(let! neovide_floating_blur_amount_y 5.0)

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
(custom-set-face! ColorColumn [] {:fg carbon.none :bg carbon.base01})
(custom-set-face! Cursor [] {:fg carbon.base00 :bg carbon.base04})
(custom-set-face! CursorLine [] {:fg carbon.none :bg carbon.base01})
(custom-set-face! CursorColumn [] {:fg carbon.none :bg carbon.base01})
(custom-set-face! CursorLineNr [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! Error [] {:fg carbon.base04 :bg carbon.base11})
(custom-set-face! LineNr [] {:fg carbon.base03 :bg carbon.none})
(custom-set-face! MatchParen [:underline] {:bg carbon.base02})
(custom-set-face! NonText [] {:fg carbon.base02 :bg carbon.none})
(custom-set-face! Normal [] {:fg carbon.base04 :bg carbon.base00})
(custom-set-face! Pmenu [] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! PmenuSbar [] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! PmenuSel [] {:fg carbon.base08 :bg carbon.base02})
(custom-set-face! PmenuThumb [] {:fg carbon.base08 :bg carbon.base02})
(custom-set-face! SpecialKey [] {:fg carbon.base03 :bg carbon.none})
(custom-set-face! Visual [] {:fg carbon.none :bg carbon.base02})
(custom-set-face! VisualNOS [] {:fg carbon.none :bg carbon.base02})

;; diagnostic
(custom-set-face! DiagnosticWarn [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! DiagnosticError [] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! DiagnosticInfo [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! DiagnosticHint [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! DiagnosticUnderlineWarn [:undercurl] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! DiagnosticUnderlineError [:undercurl] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! DiagnosticUnderlineInfo [:undercurl] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! DiagnosticUnderlineHint [:undercurl] {:fg carbon.base04 :bg carbon.none})

;; lsp
(custom-set-face! LspReferenceText [] {:fg carbon.none :bg carbon.base03})
(custom-set-face! LspReferenceRead [] {:fg carbon.none :bg carbon.base03})
(custom-set-face! LspReferenceWrite [] {:fg carbon.none :bg carbon.base03})
(custom-set-face! LspSignatureActiveParameter [] {:fg carbon.base08 :bg carbon.none})
(link! LspDiagnosticsDefaultError => DiagnosticError)
(link! LspDiagnosticsDefaultWarning => DiagnosticWarn)
(link! LspDiagnosticsDefaultInformation => DiagnosticInfo)
(link! LspDiagnosticsDefaultHint => DiagnosticHint)
(link! LspDiagnosticsUnderlineError  => DiagnosticUnderlineError)
(link! LspDiagnosticsUnderlineWarning => DiagnosticUnderlineWarn)
(link! LspDiagnosticsUnderlineInformation => DiagnosticUnderlineInformation)
(link! LspDiagnosticsUnderlineHint => DiagnosticUnderlineHint)

;; gutter
(custom-set-face! Folded [] {:fg carbon.base03 :bg carbon.base01})
(custom-set-face! FoldColumn [] {:fg carbon.base03 :bg carbon.base00})
(custom-set-face! SignColumn [] {:fg carbon.base01 :bg carbon.base00})

;; navigation
(custom-set-face! Directory [] {:fg carbon.base08 :bg carbon.none})

;; prompts & status
(custom-set-face! EndOfBuffer [] {:fg carbon.base01 :bg carbon.none})
(custom-set-face! ErrorMsg [] {:fg carbon.base04 :bg carbon.base11})
(custom-set-face! ModeMsg [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! MoreMsg [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! Question [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! WarningMsg [] {:fg carbon.base00 :bg carbon.base13})
(custom-set-face! WildMenu [] {:fg carbon.base08 :bg carbon.base01})

;; search
(custom-set-face! IncSearch [] {:fg carbon.base06 :bg carbon.base10})
(custom-set-face! Search [] {:fg carbon.base01 :bg carbon.base08})

;; tabs
(custom-set-face! TabLine [] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! TabLineFill [] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! TabLineSel [] {:fg carbon.base08 :bg carbon.base03})

;; window
(custom-set-face! Title [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! VertSplit [] {:fg carbon.base02 :bg carbon.base00})

;; Regular Syntax 
(custom-set-face! Boolean [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Character [] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! Comment [] {:fg carbon.base03 :bg carbon.none})
(custom-set-face! Conceal [] {:fg carbon.none :bg carbon.none})
(custom-set-face! Conditional [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Constant [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! Decorator [] {:fg carbon.base12 :bg carbon.none})
(custom-set-face! Define [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Delimeter [] {:fg carbon.base06 :bg carbon.none})
(custom-set-face! Exception [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Float [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! Function [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! Indentifier [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! Include [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Keyword [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Label [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Number [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! Operator [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! PreProc [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Repeat [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Special [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! SpecialChar [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! SpecialComment [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! Statement [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! StorageClass [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! String [] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! Structure [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Tag [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! Todo [] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! Type [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! Typedef [] {:fg carbon.base09 :bg carbon.none})

;; Treesitter
(custom-set-face! TSAnnotation [] {:fg carbon.base12 :bg carbon.none})
(custom-set-face! TSAttribute [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSBoolean [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSCharacter [] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! TSComment [:italic] {:fg carbon.base03 :bg carbon.none})
(custom-set-face! TSConstructor [] {:fg carbon.base0 :bg carbon.none})
(custom-set-face! TSConditional [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSConstant [] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! TSConstBuiltin [] {:fg carbon.base07 :bg carbon.none})
(custom-set-face! TSConstMacro [] {:fg carbon.base07 :bg carbon.none})
(custom-set-face! TSError [] {:fg carbon.base11 :bg carbon.none})
(custom-set-face! TSException [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSField [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSFloat [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSFunction [] {:fg carbon.base12})
(custom-set-face! TSFuncBuiltin [] {:fg carbon.base12 :bg carbon.none})
(custom-set-face! TSFuncMacro [] {:fg carbon.base07 :bg carbon.none})
(custom-set-face! TSInclude [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSKeyword [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSKeywordFunction [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! TSKeywordOperator [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! TSLabel [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSMethod [] {:fg carbon.base07 :bg carbon.none})
(custom-set-face! TSNamespace [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSNumber [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSOperator [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSParameter [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSParameterReference [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSProperty [] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! TSPunctDelimiter [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! TSPunctBracket [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! TSPunctSpecial [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! TSRepeat [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSString [] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! TSStringRegex [] {:fg carbon.base07 :bg carbon.none})
(custom-set-face! TSStringEscape [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSSymbol [] {:fg carbon.base15})
(custom-set-face! TSTag [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSTagDelimiter [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! TSText [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSStrong [:bold] {:fg carbon.none :bg carbon.none})
(custom-set-face! TSEmphasis [:bold] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! TSUnderline [:underline] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSStrike [:strikethrough] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSTitle [] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! TSLiteral [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSURI [:underline] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! TSType [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSTypeBuiltin [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! TSVariable [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSVariableBuiltin [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! TSCurrentScope [:bold] {:fg carbon.none :bg carbon.none})
(custom-set-face! TreesitterContext [] {:fg carbon.none :bg carbon.base01})

;; Neovim-specific
(custom-set-face! NvimInternalError [] {:fg carbon.base00 :bg carbon.base08})
(custom-set-face! NormalFloat [] {:fg carbon.base05 :bg carbon.base00})
(custom-set-face! FloatBorder [] {:fg carbon.base05 :bg carbon.base00})
(custom-set-face! NormalNC [] {:fg carbon.base05 :bg carbon.base00})
(custom-set-face! TermCursor [] {:fg carbon.base00 :bg carbon.base04})
(custom-set-face! TermCursorNC [] {:fg carbon.base00 :bg carbon.base04})

;; minimal highlights
(custom-set-face! StatusLine [] {:fg carbon.base04 :bg carbon.base00})
(custom-set-face! StatusPosition [] {:fg :#a2a9b0 :bg carbon.base00})
(custom-set-face! StatusNormal [] {:fg carbon.base00 :bg carbon.base09})
(custom-set-face! StatusReplace [] {:fg carbon.base00 :bg carbon.base08})
(custom-set-face! StatusInsert [] {:fg carbon.base00 :bg carbon.base11})
(custom-set-face! StatusVisual [] {:fg carbon.base00 :bg carbon.base14})
(custom-set-face! StatusTerminal [] {:fg carbon.base00 :bg carbon.base15})
(custom-set-face! StatusLineDiagnosticWarn [:bold] {:fg carbon.base14 :bg carbon.base00})
(custom-set-face! StatusLineDiagnosticError [:bold] {:fg carbon.base09 :bg carbon.base00})
(link! StatusCommand => StatusNormal)

;; telescope
(custom-set-face! TelescopeBorder [] {:fg carbon.blend :bg carbon.blend})
(custom-set-face! TelescopePromptBorder [] {:fg carbon.base02 :bg carbon.base02})
(custom-set-face! TelescopePromptNormal [] {:fg carbon.base05 :bg carbon.base02})
(custom-set-face! TelescopePromptPrefix [] {:fg carbon.base08 :bg carbon.base02})
(custom-set-face! TelescopeNormal [] {:fg carbon.none :bg carbon.blend})
(custom-set-face! TelescopePreviewTitle [] {:fg carbon.base02 :bg carbon.base11})
(custom-set-face! TelescopePromptTitle [] {:fg carbon.base02 :bg carbon.base08})
(custom-set-face! TelescopeResultsTitle [] {:fg carbon.blend :bg carbon.blend})
(custom-set-face! TelescopeSelection [] {:fg carbon.none :bg carbon.base02})
(custom-set-face! TelescopePreviewLine [] {:fg carbon.none :bg carbon.base01})

;; nvim-notify
(custom-set-face! NotifyERRORBorder [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! NotifyWARNBorder [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! NotifyINFOBorder [] {:fg carbon.base05 :bg carbon.none})
(custom-set-face! NotifyDEBUGBorder [] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! NotifyTRACEBorder [] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! NotifyERRORIcon [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! NotifyWARNIcon [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! NotifyINFOIcon [] {:fg carbon.base05 :bg carbon.none})
(custom-set-face! NotifyDEBUGIcon [] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! NotifyTRACEIcon [] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! NotifyERRORTitle [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! NotifyWARNTitle [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! NotifyINFOTitle [] {:fg carbon.base05 :bg carbon.none})
(custom-set-face! NotifyDEBUGTitle [] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! NotifyTRACETitle [] {:fg carbon.base13 :bg carbon.none})

;; cmp: company-ish look 
(custom-set-face! CmpItemAbbr [] {:fg carbon.base03})
(custom-set-face! CmpItemAbbrMatch [] {:fg carbon.base05})
(custom-set-face! CmpItemAbbrMatchFuzzy [] {:fg carbon.base04})
(link! CmpItemKindInterface => CmpItemKindVariable)
(link! CmpItemKindText => CmpItemKindVariable)
(link! CmpItemKindProperty => CmpItemKindKeyword)
(link! CmpItemKindUnit => CmpItemKindKeyword)
(link! CmpItemKindFunction => CmpItemKindMethod)

 ;; cleaner nvimtree
(custom-set-face! NvimTreeImageFile [] {:fg carbon.base12})
(custom-set-face! NvimTreeFolderIcon [] {:fg carbon.base12})
(custom-set-face! NvimTreeWinSeparator [] {:fg carbon.base00 :bg carbon.base00})
(custom-set-face! NvimTreeFolderName [] {:fg carbon.base09})
(custom-set-face! NvimTreeIndentMarker [] {:fg carbon.base02})
(custom-set-face! NvimTreeEmptyFolderName [] {:fg carbon.base15})
(custom-set-face! NvimTreeOpenedFolderName [] {:fg carbon.base15})
(custom-set-face! NvimTreeNormal [] {:fg carbon.base04 :bg carbon.blend})

;; bufferline: just match it with NvimTree
(custom-set-face! BufferLineFill [] {:bg carbon.blend})
(custom-set-face! BufferLineBackground [] {:bg carbon.blend})
(custom-set-face! BufferLineTabClose [] {:fg carbon.base03 :bg carbon.blend})
(custom-set-face! BufferLineSeparator [] {:fg carbon.base00 :bg carbon.blend})
(custom-set-face! BufferLineCloseButton [] {:fg carbon.base03 :bg carbon.blend})

;; neogit
(custom-set-face! NeogitBranch [] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! NeogitRemote [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! NeogitDiffAddHighlight [] {:fg carbon.base13 :bg carbon.base02})
(custom-set-face! NeogitDiffDeleteHighlight [] {:fg carbon.base19 :bg carbon.base02})
(custom-set-face! NeogitDiffContextHighlight [] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! NeogitHunkHeader [] {:fg carbon.base04 :bg carbon.base02})
(custom-set-face! NeogitHunkHeaderHighlight [] {:fg carbon.base04 :bg carbon.base03})

;; gitsigns
(custom-set-face! GitSignsAdd [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! GitSignsChange [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! GitSignsDelete [] {:fg carbon.base14 :bg carbon.none})
(vim.cmd "colorscheme nord")

