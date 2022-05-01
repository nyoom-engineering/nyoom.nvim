(import-macros {: cmd : highlight!} :conf.macros)
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

;; subtle delimiters
(cmd "hi MatchParen gui=underline guibg=#262626")

;; transparent vertical splits
(cmd "hi VertSplit guibg=bg guifg=bg")

;; bold various syntax & TODO
(cmd "hi Todo gui=bold")
(cmd "hi TSSymbol gui=bold")
(cmd "hi TSFunction gui=bold")

;; parens: trying to make it closer to emacs carbon
(cmd "hi rainbowcol1 guifg=#878d96")
(cmd "hi rainbowcol2 guifg=#a8a8a8")
(cmd "hi rainbowcol3 guifg=#8d8d8d")
(cmd "hi rainbowcol4 guifg=#a2a9b0")
(cmd "hi rainbowcol5 guifg=#8f8b8b")
(cmd "hi rainbowcol6 guifg=#ada8a8")
(cmd "hi rainbowcol7 guifg=#878d96")

;; minimal statusline
(cmd "hi StatusInactive guifg=#525252")
(cmd "hi StatusLine guibg=#161616 guifg=#393939")
(cmd "hi StatusLineNC guibg=#161616 guifg=#525252")
(cmd "hi StatusNormal gui=underline guibg=#161616 guifg=#393939")
(cmd "hi StatusCommand gui=underline guibg=#161616 guifg=#393939")
(cmd "hi StatusReplace guifg=#161616 guibg=#dde1e6")
(cmd "hi StatusInsert guifg=#161616 guibg=#3ddbd9")
(cmd "hi StatusVisual guifg=#161616 guibg=#ff7eb6")
(cmd "hi StatusTerminal guifg=#161616 guibg=#be95ff")

;; better nvimtree
(cmd "hi NvimTreeImageFile guifg=#33b1ff")
(cmd "hi NvimTreeFolderIcon guifg=#525252")
(cmd "hi NvimTreeFolderIcon guifg=#525252")
(cmd "hi NvimTreeSpecialFile guifg=#be95ff")
(cmd "hi NvimTreeIndentMarker guifg=#525252")
(cmd "hi NvimTreeFolderName guibg=NONE guifg=NONE")
(cmd "hi NvimTreeEmptyFolderName guibg=NONE guifg=NONE")
(cmd "hi NvimTreeOpenedFolderName guibg=NONE guifg=NONE")
(cmd "hi NvimTreeWindowPicker guifg=#FAFAFA, guibg=#262626")


