(require-macros :macros.highlight-macros)
(local {: setup} (require :base16-colorscheme))

;; You can either define your own colors
;; E.g. colors from https://www.ibm.com/brand/experience-guides/developer/brand/color/
(setup {:base00 "#161616"
        :base01 "#262626"
        :base02 "#393939"
        :base03 "#525252"
        :base04 "#FDFDFD"
        :base05 "#FAFAFA"
        :base06 "#FFFFFF"
        :base07 "#c1c7cd"
        :base08 "#dde1e6"
        :base09 "#f2f4f8"
        :base0A "#42be65"
        :base0B "#3ddbd9"
        :base0C "#33b1ff"
        :base0D "#ff7eb6"
        :base0E "#be95ff"
        :base0F "#3ddbd9"})

;; Custom highlights/modificatoins
;; Bold is added for fun. To see why vim.cmd is used for some, see: https://github.com/bakpakin/Fennel/issues/425

;; subtle underlines
;; (highlight! MatchParen [:underline] {:bg "#262626"})
;; (highlight! StatusNormal [:underline] {:fg "#393939"})
(vim.cmd "hi MatchParen gui=underline guibg=#262626")
(vim.cmd "hi StatusNormal gui=underline guifg=#393939")
(link! StatusCommand => StatusNormal)

;; transparent vertical splits
(highlight! Vertsplit [:none] {:fg "#161616"})

;; bold various syntax & TODO
;; (highlight! Todo [:bold] {:fg "#42be65"})
;; (highlight! TSSymbol [:bold] {:fg "#3ddbd9"})
;; (highlight! TSFunction [:bold] {:fg "#ff7eb6"})
(vim.cmd "hi Todo gui=bold guifg=#42be65")
(vim.cmd "hi TSSymbol gui=bold guifg=#3ddbd9")
(vim.cmd "hi TSFunction gui=bold guifg=#ff7eb6")

;; parens: emacs-carbon style
(highlight! rainbowcol1 [:none] {:fg "#878d96"})
(highlight! rainbowcol2 [:none] {:fg "#a8a8a8"})
(highlight! rainbowcol3 [:none] {:fg "#8d8d8d"})
(highlight! rainbowcol4 [:none] {:fg "#a2a9b0"})
(highlight! rainbowcol5 [:none] {:fg "#8f8b8b"})
(highlight! rainbowcol6 [:none] {:fg "#ada8a8"})
(highlight! rainbowcol7 [:none] {:fg "#878d96"})

;; cleaner nvimtree
(highlight! NvimTreeImageFile [:none] {:fg "#33b1ff"})
(highlight! NvimTreeFolderIcon [:none] {:fg "#525252"})
;; (highlight! NvimTreeSpecialFile [:bold] {:fg "#33b1ff"})
(vim.cmd "hi NvimTreeSpecialFile gui=bold guifg=#33b1ff")
(highlight! NvimTreeIndentMarker [:none] {:fg "#262626"})
(highlight! NvimTreeFolderName [:none] {:fg "#393939"})
(highlight! NvimTreeEmptyFolderName [:none] {:fg "#be95ff"})
;; (highlight! NvimTreeOpenedFolderName [:bold] {:fg "#be95ff"})
(vim.cmd "hi NvimTreeOpenedFolderName gui=bold guifg=#be95ff")

; cmp: company-ish look 
;; (highlight! CmpItemAbbrMatch [:bold] {:fg "#FAFAFA"})
(vim.cmd "hi CmpItemAbbrMatch gui=bold guifg=#FAFAFA")
(highlight! CmpItemAbbrMatchFuzzy [:none] {:fg "#FAFAFA"})
(highlight! CmpItemAbbr [:none] {:fg "#a8a8a8"})
(highlight! CmpItemKindVariable [:none] {:fg "#be95ff"})
(highlight! CmpItemKindMethod [:none] {:fg "#ff7eb6"})
(highlight! CmpItemKindKeyword [:none] {:fg "#33b1ff"})
(link! CmpItemKindInterface => CmpItemKindVariable)
(link! CmpItemKindText => CmpItemKindVariable)
(link! CmpItemKindProperty => CmpItemKindKeyword)
(link! CmpItemKindUnit => CmpItemKindKeyword)
(link! CmpItemKindFunction => CmpItemKindMethod)

;; minimal statusline
(highlight! StatusLine [:none] {:fg "#393939" :bg "#161616"})
(highlight! StatusLineNC [:none] {:fg "#525252" :bg "#161616"})
(highlight! StatusReplace [:none] {:fg "#161616" :bg "#dde1e6"})
(highlight! StatusInsert [:none] {:fg "#161616" :bg "#3ddbd9"})
(highlight! StatusVisual [:none] {:fg "#161616" :bg "#ff7eb6"})
(highlight! StatusTerminal [:none] {:fg "#161616" :bg "#be95ff"})
