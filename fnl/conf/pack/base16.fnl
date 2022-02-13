(import-macros {: cmd} :conf.macros)
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

;; minimal statusline
(cmd "hi StatusLineNC gui=underline guibg=#161616 guifg=#393939")
(cmd "hi StatusLine gui=underline guibg=#161616 guifg=#393939")

;; subtle delimiters
(cmd "hi MatchParen gui=underline guibg=#262626")

;; transparent vertical splits
(cmd "hi VertSplit guibg=bg guifg=bg")

;; bold various syntax & TODO
(cmd "hi Todo gui=bold")
(cmd "hi TSSymbol gui=bold")
(cmd "hi TSFunction gui=bold")

;; cmp
(cmd "hi CmpItemAbbrMatch gui=bold guifg=#FAFAFA")
(cmd "hi CmpItemAbbrMatchFuzzy guifg=#FAFAFA")
(cmd "hi CmpItemAbbr guifg=#a8a8a8")

(cmd "hi CmpItemKindVariable guibg=NONE guifg=#be95ff")
(cmd "hi CmpItemKindInterface guibg=NONE guifg=#be95ff")
(cmd "hi CmpItemKindText guibg=NONE guifg=#be95ff")

(cmd "hi CmpItemKindFunction guibg=NONE guifg=#ff7eb6")
(cmd "hi CmpItemKindMethod guibg=NONE guifg=#ff7eb6")

(cmd "hi CmpItemKindKeyword guibg=NONE guifg=#33b1ff")
(cmd "hi CmpItemKindProperty guibg=NONE guifg=#33b1ff")
(cmd "hi CmpItemKindUnit guibg=NONE guifg=#33b1ff")
