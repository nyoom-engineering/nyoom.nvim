;;                                 C A R B O N
;;        _..._         _..._         _..._         _..._         _..._
;;      .:::::::.     .::::. `.     .::::  `.     .::'   `.     .'     `.
;;     :::::::::::   :::::::.  :   ::::::    :   :::       :   :         :
;;     :::::::::::   ::::::::  :   ::::::    :   :::       :   :         :
;;     `:::::::::'   `::::::' .'   `:::::   .'   `::.     .'   `.       .'
;;       `':::''       `'::'-'       `'::.-'       `':..-'       `-...-'
;; 
;;   Colorscheme name:    carbon themeing system
;;   Description:         Neovim Colorschemes based on base16 in fennel made with (hs)luv <3 
;;   Author:              https://github.com/shaunsingh

(import-macros {: custom-set-face! : let! : set! : nyoom-module-p!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: blend-hex} (autoload :modules.ui.nyoom.colorutils))

;; reset variables

(when vim.g.colors_name
  (vim.cmd "hi clear"))

;; set defaults

(let! colors_name :carbon)
(set! termguicolors true)

;; carbon palette 
;; (nyoom-module-p! nyoom.+carbon

(local base00 "#161616")
(local base06 "#ffffff")
(local base09 "#78a9ff")

(local carbon (or (and (= vim.o.background :dark)
                       {: base00
                        :base01 (blend-hex base00 base06 0.085)
                        :base02 (blend-hex base00 base06 0.18)
                        :base03 (blend-hex base00 base06 0.3)
                        :base04 (blend-hex base00 base06 0.82)
                        :base05 (blend-hex base00 base06 0.95)
                        : base06
                        :base07 "#08bdba"
                        :base08 "#3ddbd9"
                        : base09
                        :base10 "#ee5396"
                        :base11 "#33b1ff"
                        :base12 "#ff7eb6"
                        :base13 "#42be65"
                        :base14 "#be95ff"
                        :base15 "#82cfff"
                        :blend "#131313"
                        :none :NONE})
                  {:base00 base06
                   :base01 (blend-hex base00 base06 0.95)
                   :base02 (blend-hex base00 base06 0.82)
                   :base03 base00
                   :base04 "#37474F"
                   :base05 "#90A4AE"
                   :base06 "#525252"
                   :base07 "#08bdba"
                   :base08 "#ff7eb6"
                   :base09 "#ee5396"
                   :base10 "#FF6F00"
                   :base11 "#0f62fe"
                   :base12 "#673AB7"
                   :base13 "#42be65"
                   :base14 "#be95ff"
                   :base15 "#FFAB91"
                   :blend "#FAFAFA"
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

(custom-set-face! :ColorColumn [] {:fg carbon.none :bg carbon.base01})
(custom-set-face! :Cursor [] {:fg carbon.base00 :bg carbon.base04})
(custom-set-face! :CursorLine [] {:fg carbon.none :bg carbon.base01})
(custom-set-face! :CursorColumn [] {:fg carbon.none :bg carbon.base01})
(custom-set-face! :CursorLineNr [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! :QuickFixLine [] {:fg carbon.none :bg carbon.base01})
(custom-set-face! :Error [] {:fg carbon.base04 :bg carbon.base11})
(custom-set-face! :LineNr [] {:fg carbon.base03 :bg carbon.base00})
(custom-set-face! :NonText [] {:fg carbon.base02 :bg carbon.none})
(custom-set-face! :Normal [] {:fg carbon.base04 :bg carbon.base00})
(custom-set-face! :Pmenu [] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! :PmenuSbar [] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! :PmenuSel [] {:fg carbon.base08 :bg carbon.base02})
(custom-set-face! :PmenuThumb [] {:fg carbon.base08 :bg carbon.base02})
(custom-set-face! :SpecialKey [] {:fg carbon.base03 :bg carbon.none})
(custom-set-face! :Visual [] {:fg carbon.none :bg carbon.base02})
(custom-set-face! :VisualNOS [] {:fg carbon.none :bg carbon.base02})
(custom-set-face! :TooLong [] {:fg carbon.none :bg carbon.base02})
(custom-set-face! :Debug [] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! :Macro [] {:fg carbon.base07 :bg carbon.none})
(custom-set-face! :MatchParen [:underline] {:fg carbon.none :bg carbon.base02})
(custom-set-face! :Bold [:bold] {:fg carbon.none :bg carbon.none})
(custom-set-face! :Italic [:italic] {:fg carbon.none :bg carbon.none})
(custom-set-face! :Underlined [:underline] {:fg carbon.none :bg carbon.none})

;; diagnostics

(nyoom-module-p! diagnostics
                 (do
                   (custom-set-face! :DiagnosticWarn []
                                     {:fg carbon.base08 :bg carbon.none})
                   (custom-set-face! :DiagnosticError []
                                     {:fg carbon.base10 :bg carbon.none})
                   (custom-set-face! :DiagnosticInfo []
                                     {:fg carbon.base09 :bg carbon.none})
                   (custom-set-face! :DiagnosticHint []
                                     {:fg carbon.base04 :bg carbon.none})
                   (custom-set-face! :DiagnosticUnderlineWarn [:undercurl]
                                     {:fg carbon.base08 :bg carbon.none})
                   (custom-set-face! :DiagnosticUnderlineError [:undercurl]
                                     {:fg carbon.base10 :bg carbon.none})
                   (custom-set-face! :DiagnosticUnderlineInfo [:undercurl]
                                     {:fg carbon.base04 :bg carbon.none})
                   (custom-set-face! :DiagnosticUnderlineHint [:undercurl]
                                     {:fg carbon.base04 :bg carbon.none})))

;; lsp

(nyoom-module-p! lsp
                 (do
                   (custom-set-face! :LspReferenceText []
                                     {:fg carbon.none :bg carbon.base03})
                   (custom-set-face! :LspReferenceread []
                                     {:fg carbon.none :bg carbon.base03})
                   (custom-set-face! :LspReferenceWrite []
                                     {:fg carbon.none :bg carbon.base03})
                   (custom-set-face! :LspSignatureActiveParameter []
                                     {:fg carbon.base08 :bg carbon.none})))

;; gutter

(custom-set-face! :Folded [] {:fg carbon.base02 :bg carbon.base01})
(custom-set-face! :FoldColumn [] {:fg carbon.base01 :bg carbon.base00})
(custom-set-face! :SignColumn [] {:fg carbon.base01 :bg carbon.base00})

;; navigation

(custom-set-face! :Directory [] {:fg carbon.base08 :bg carbon.none})

;; prompts

(custom-set-face! :EndOfBuffer [] {:fg carbon.base01 :bg carbon.none})
(custom-set-face! :ErrorMsg [] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! :ModeMsg [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! :MoreMsg [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! :Question [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! :Substitute [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! :WarningMsg [] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! :WildMenu [] {:fg carbon.base08 :bg carbon.base01})

;; vimhelp

(custom-set-face! :helpHyperTextJump [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! :helpSpecial [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :helpHeadline [] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! :helpHeader [] {:fg carbon.base15 :bg carbon.none})

;; diff

(custom-set-face! :DiffAdded [] {:fg carbon.base07 :bg carbon.none})
(custom-set-face! :DiffChanged [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :DiffRemoved [] {:fg carbon.base10 :bg carbon.none})
(custom-set-face! :DiffAdd [] {:bg "#122f2f" :fg carbon.none})
(custom-set-face! :DiffChange [] {:bg "#222a39" :fg carbon.none})
(custom-set-face! :DiffText [] {:bg "#2f3f5c" :fg carbon.none})
(custom-set-face! :DiffDelete [] {:bg "#361c28" :fg carbon.none})

;; search

(custom-set-face! :IncSearch [] {:fg carbon.base06 :bg carbon.base10})
(custom-set-face! :Search [] {:fg carbon.base01 :bg carbon.base08})

;; tabs

(custom-set-face! :TabLine [] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! :TabLineFill [] {:fg carbon.base04 :bg carbon.base01})
(custom-set-face! :TabLineSel [] {:fg carbon.base08 :bg carbon.base03})

;; window

(custom-set-face! :Title [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! :VertSplit [] {:fg carbon.base01 :bg carbon.base00})

;; regular syntax

(custom-set-face! :Boolean [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :Character [] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! :Comment [] {:fg carbon.base03 :bg carbon.none})
(custom-set-face! :Conceal [] {:fg carbon.none :bg carbon.none})
(custom-set-face! :Conditional [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :Constant [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! :Decorator [] {:fg carbon.base12 :bg carbon.none})
(custom-set-face! :Define [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :Delimeter [] {:fg carbon.base06 :bg carbon.none})
(custom-set-face! :Exception [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :Float [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! :Function [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! :Identifier [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! :Include [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :Keyword [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :Label [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :Number [] {:fg carbon.base15 :bg carbon.none})
(custom-set-face! :Operator [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :PreProc [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :Repeat [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :Special [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! :SpecialChar [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! :SpecialComment [] {:fg carbon.base08 :bg carbon.none})
(custom-set-face! :Statement [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :StorageClass [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :String [] {:fg carbon.base14 :bg carbon.none})
(custom-set-face! :Structure [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :Tag [] {:fg carbon.base04 :bg carbon.none})
(custom-set-face! :Todo [] {:fg carbon.base13 :bg carbon.none})
(custom-set-face! :Type [] {:fg carbon.base09 :bg carbon.none})
(custom-set-face! :Typedef [] {:fg carbon.base09 :bg carbon.none})

;; treesitter

(nyoom-module-p! tree-sitter
                 (do
                   ;;; misc
                   (custom-set-face! "@comment" [:italic]
                                     {:fg carbon.base03 :bg carbon.none})
                   (custom-set-face! "@error" []
                                     {:fg carbon.base11 :bg carbon.none})
                   ;; @none
                   ;; @preproc
                   ;; @define
                   (custom-set-face! "@operator" []
                                     {:fg carbon.base09 :bg carbon.none})
                   ;;; punctuation
                   (custom-set-face! "@puncuation.delimiter" []
                                     {:fg carbon.base08 :bg carbon.none})
                   (custom-set-face! "@punctuation.bracket" []
                                     {:fg carbon.base08 :bg carbon.none})
                   (custom-set-face! "@punctuation.special" []
                                     {:fg carbon.base08 :bg carbon.none})
                   ;;; literals
                   (custom-set-face! "@string" []
                                     {:fg carbon.base14 :bg carbon.none})
                   (custom-set-face! "@string.regex" []
                                     {:fg carbon.base07 :bg carbon.none})
                   (custom-set-face! "@string.escape" []
                                     {:fg carbon.base15 :bg carbon.none})
                   ;; @string.special
                   (custom-set-face! "@character" []
                                     {:fg carbon.base14 :bg carbon.none})
                   ;; @character.special
                   (custom-set-face! "@boolean" []
                                     {:fg carbon.base09 :bg carbon.none})
                   (custom-set-face! "@number" []
                                     {:fg carbon.base15 :bg carbon.none})
                   (custom-set-face! "@float" []
                                     {:fg carbon.base15 :bg carbon.none})
                   ;;; functions
                   (custom-set-face! "@function" [:bold]
                                     {:fg carbon.base12 :bg carbon.none})
                   (custom-set-face! "@function.builtin" []
                                     {:fg carbon.base12 :bg carbon.none})
                   ;; @function.call
                   (custom-set-face! "@function.macro" []
                                     {:fg carbon.base07 :bg carbon.none})
                   (custom-set-face! "@method" []
                                     {:fg carbon.base07 :bg carbon.none})
                   ;; @method.call
                   (custom-set-face! "@constructor" []
                                     {:fg carbon.base09 :bg carbon.none})
                   (custom-set-face! "@parameter" []
                                     {:fg carbon.base04 :bg carbon.none})
                   ;;; keywords
                   (custom-set-face! "@keyword" []
                                     {:fg carbon.base09 :bg carbon.none})
                   (custom-set-face! "@keyword.function" []
                                     {:fg carbon.base08 :bg carbon.none})
                   (custom-set-face! "@keyword.operator" []
                                     {:fg carbon.base08 :bg carbon.none})
                   ;; @keyword.return
                   (custom-set-face! "@conditional" []
                                     {:fg carbon.base09 :bg carbon.none})
                   (custom-set-face! "@repeat" []
                                     {:fg carbon.base09 :bg carbon.none})
                   ;; @debug
                   (custom-set-face! "@label" []
                                     {:fg carbon.base15 :bg carbon.none})
                   (custom-set-face! "@include" []
                                     {:fg carbon.base09 :bg carbon.none})
                   (custom-set-face! "@exception" []
                                     {:fg carbon.base15 :bg carbon.none})
                   ;;; types
                   (custom-set-face! "@type" []
                                     {:fg carbon.base09 :bg carbon.none})
                   (custom-set-face! "@type.builtin" []
                                     {:fg carbon.base04 :bg carbon.none})
                   ;; @type.defintion
                   ;; @type.qualifier
                   ;; @storageclass
                   ;; @storageclass.lifetime
                   (custom-set-face! "@attribute" []
                                     {:fg carbon.base15 :bg carbon.none})
                   (custom-set-face! "@field" []
                                     {:fg carbon.base04 :bg carbon.none})
                   (custom-set-face! "@property" []
                                     {:fg carbon.base10 :bg carbon.none})
                   ;;; identifiers
                   (custom-set-face! "@variable" []
                                     {:fg carbon.base04 :bg carbon.none})
                   (custom-set-face! "@variable.builtin" []
                                     {:fg carbon.base04 :bg carbon.none})
                   (custom-set-face! "@constant" []
                                     {:fg carbon.base14 :bg carbon.none})
                   (custom-set-face! "@constant.builtin" []
                                     {:fg carbon.base07 :bg carbon.none})
                   (custom-set-face! "@constant.macro" []
                                     {:fg carbon.base07 :bg carbon.none})
                   (custom-set-face! "@namespace" []
                                     {:fg carbon.base04 :bg carbon.none})
                   (custom-set-face! "@symbol" [:bold]
                                     {:fg carbon.base15 :bg carbon.none})
                   ;;; text
                   (custom-set-face! "@text" []
                                     {:fg carbon.base04 :bg carbon.none})
                   (custom-set-face! "@text.strong" []
                                     {:fg carbon.none :bg carbon.none})
                   (custom-set-face! "@text.emphasis" [:bold]
                                     {:fg carbon.base10 :bg carbon.none})
                   (custom-set-face! "@text.underline" [:underline]
                                     {:fg carbon.base10 :bg carbon.none})
                   (custom-set-face! "@text.strike" [:strikethrough]
                                     {:fg carbon.base10 :bg carbon.none})
                   (custom-set-face! "@text.title" []
                                     {:fg carbon.base10 :bg carbon.none})
                   (custom-set-face! "@text.literal" []
                                     {:fg carbon.base04 :bg carbon.none})
                   (custom-set-face! "@text.uri" [:underline]
                                     {:fg carbon.base14 :bg carbon.none})
                   ;; @text.math
                   ;; @text.environment
                   ;; @text.environment.name
                   ;; @text.reference
                   ;; @text.todo
                   ;; @text.note
                   ;; @text.warning
                   ;; @text.danger
                   ;; @text.diff.add
                   ;; @text.diff.delete
                   ;;; tags
                   (custom-set-face! "@tag" []
                                     {:fg carbon.base04 :bg carbon.none})
                   ;; @tag.attribute
                   (custom-set-face! "@tag.delimiter" []
                                     {:fg carbon.base15 :bg carbon.none})
                   ;;; Conceal
                   ;; @conceal
                   ;;; Spell
                   ;; @spell
                   ;; @nospell
                   ;;; non-standard
                   ;; @variable.global
                   ;;; locals
                   ;; @definition
                   ;; @definition.constant
                   ;; @definition.function
                   ;; @definition.method
                   ;; @definition.var
                   ;; @definition.parameter
                   ;; @definition.macro
                   ;; @definition.type
                   ;; @definition.field
                   ;; @definition.enum
                   ;; @definition.namespace
                   ;; @definition.import
                   ;; @definition.associated
                   ;; @scope
                   (custom-set-face! "@reference" []
                                     {:fg carbon.base04 :bg carbon.none})))

;; neovim

(custom-set-face! :NvimInternalError [] {:fg carbon.base00 :bg carbon.base08})
(custom-set-face! :NormalFloat [] {:fg carbon.base05 :bg carbon.blend})
(custom-set-face! :FloatBorder [] {:fg carbon.blend :bg carbon.blend})
(custom-set-face! :NormalNC [] {:fg carbon.base05 :bg carbon.base00})
(custom-set-face! :TermCursor [] {:fg carbon.base00 :bg carbon.base04})
(custom-set-face! :TermCursorNC [] {:fg carbon.base00 :bg carbon.base04})

;; statusline/winbar

(nyoom-module-p! modeline
                 (do
                   (custom-set-face! :StatusReplace []
                                     {:fg carbon.base00 :bg carbon.base08})
                   (custom-set-face! :StatusInsert []
                                     {:fg carbon.base00 :bg carbon.base12})
                   (custom-set-face! :StatusVisual []
                                     {:fg carbon.base00 :bg carbon.base14})
                   (custom-set-face! :StatusTerminal []
                                     {:fg carbon.base00 :bg carbon.base11})
                   (custom-set-face! :StatusNormal []
                                     {:fg carbon.base00 :bg carbon.base15})
                   (custom-set-face! :StatusCommand []
                                     {:fg carbon.base00 :bg carbon.base13})
                   (custom-set-face! :StatusLineDiagnosticWarn [:bold]
                                     {:fg carbon.base14 :bg carbon.base00})
                   (custom-set-face! :StatusLineDiagnosticError [:bold]
                                     {:fg carbon.base08 :bg carbon.base00})))

;; telescope

(nyoom-module-p! telescope
                 (do
                   (custom-set-face! :TelescopeBorder []
                                     {:fg carbon.blend :bg carbon.blend})
                   (custom-set-face! :TelescopePromptBorder []
                                     {:fg carbon.base02 :bg carbon.base02})
                   (custom-set-face! :TelescopePromptNormal []
                                     {:fg carbon.base05 :bg carbon.base02})
                   (custom-set-face! :TelescopePromptPrefix []
                                     {:fg carbon.base08 :bg carbon.base02})
                   (custom-set-face! :TelescopeNormal []
                                     {:fg carbon.none :bg carbon.blend})
                   (custom-set-face! :TelescopePreviewTitle []
                                     {:fg carbon.base02 :bg carbon.base12})
                   (custom-set-face! :TelescopePromptTitle []
                                     {:fg carbon.base02 :bg carbon.base11})
                   (custom-set-face! :TelescopeResultsTitle []
                                     {:fg carbon.blend :bg carbon.blend})
                   (custom-set-face! :TelescopeSelection []
                                     {:fg carbon.none :bg carbon.base02})
                   (custom-set-face! :TelescopePreviewLine []
                                     {:fg carbon.none :bg carbon.base01})))

;; notify

(nyoom-module-p! notify
                 (do
                   (custom-set-face! :NotifyERRORBorder []
                                     {:fg carbon.base08 :bg carbon.none})
                   (custom-set-face! :NotifyWARNBorder []
                                     {:fg carbon.base15 :bg carbon.none})
                   (custom-set-face! :NotifyINFOBorder []
                                     {:fg carbon.base05 :bg carbon.none})
                   (custom-set-face! :NotifyDEBUGBorder []
                                     {:fg carbon.base13 :bg carbon.none})
                   (custom-set-face! :NotifyTRACEBorder []
                                     {:fg carbon.base13 :bg carbon.none})
                   (custom-set-face! :NotifyERRORIcon []
                                     {:fg carbon.base08 :bg carbon.none})
                   (custom-set-face! :NotifyWARNIcon []
                                     {:fg carbon.base15 :bg carbon.none})
                   (custom-set-face! :NotifyINFOIcon []
                                     {:fg carbon.base05 :bg carbon.none})
                   (custom-set-face! :NotifyDEBUGIcon []
                                     {:fg carbon.base13 :bg carbon.none})
                   (custom-set-face! :NotifyTRACEIcon []
                                     {:fg carbon.base13 :bg carbon.none})
                   (custom-set-face! :NotifyERRORTitle []
                                     {:fg carbon.base08 :bg carbon.none})
                   (custom-set-face! :NotifyWARNTitle []
                                     {:fg carbon.base15 :bg carbon.none})
                   (custom-set-face! :NotifyINFOTitle []
                                     {:fg carbon.base05 :bg carbon.none})
                   (custom-set-face! :NotifyDEBUGTitle []
                                     {:fg carbon.base13 :bg carbon.none})
                   (custom-set-face! :NotifyTRACETitle []
                                     {:fg carbon.base13 :bg carbon.none})))

;; cmp

(nyoom-module-p! cmp
                 (do
                   (custom-set-face! :CmpItemAbbr []
                                     {:fg "#adadad" :bg carbon.none})
                   (custom-set-face! :CmpItemAbbrMatch [:bold]
                                     {:fg carbon.base05 :bg carbon.none})
                   (custom-set-face! :CmpItemAbbrMatchFuzzy [:bold]
                                     {:fg carbon.base04 :bg carbon.none})
                   (custom-set-face! :CmpItemMenu [:italic]
                                     {:fg carbon.base04 :bg carbon.none})
                   (custom-set-face! :CmpItemKindInterface []
                                     {:fg carbon.base01 :bg carbon.base08})
                   (custom-set-face! :CmpItemKindColor []
                                     {:fg carbon.base01 :bg carbon.base08})
                   (custom-set-face! :CmpItemKindTypeParameter []
                                     {:fg carbon.base01 :bg carbon.base08})
                   (custom-set-face! :CmpItemKindText []
                                     {:fg carbon.base01 :bg carbon.base09})
                   (custom-set-face! :CmpItemKindEnum []
                                     {:fg carbon.base01 :bg carbon.base09})
                   (custom-set-face! :CmpItemKindKeyword []
                                     {:fg carbon.base01 :bg carbon.base09})
                   (custom-set-face! :CmpItemKindConstant []
                                     {:fg carbon.base01 :bg carbon.base10})
                   (custom-set-face! :CmpItemKindConstructor []
                                     {:fg carbon.base01 :bg carbon.base10})
                   (custom-set-face! :CmpItemKindReference []
                                     {:fg carbon.base01 :bg carbon.base10})
                   (custom-set-face! :CmpItemKindFunction []
                                     {:fg carbon.base01 :bg carbon.base11})
                   (custom-set-face! :CmpItemKindStruct []
                                     {:fg carbon.base01 :bg carbon.base11})
                   (custom-set-face! :CmpItemKindClass []
                                     {:fg carbon.base01 :bg carbon.base11})
                   (custom-set-face! :CmpItemKindModule []
                                     {:fg carbon.base01 :bg carbon.base11})
                   (custom-set-face! :CmpItemKindOperator []
                                     {:fg carbon.base01 :bg carbon.base11})
                   (custom-set-face! :CmpItemKindField []
                                     {:fg carbon.base01 :bg carbon.base12})
                   (custom-set-face! :CmpItemKindProperty []
                                     {:fg carbon.base01 :bg carbon.base12})
                   (custom-set-face! :CmpItemKindEvent []
                                     {:fg carbon.base01 :bg carbon.base12})
                   (custom-set-face! :CmpItemKindUnit []
                                     {:fg carbon.base01 :bg carbon.base13})
                   (custom-set-face! :CmpItemKindSnippet []
                                     {:fg carbon.base01 :bg carbon.base13})
                   (custom-set-face! :CmpItemKindFolder []
                                     {:fg carbon.base01 :bg carbon.base13})
                   (custom-set-face! :CmpItemKindVariable []
                                     {:fg carbon.base01 :bg carbon.base14})
                   (custom-set-face! :CmpItemKindFile []
                                     {:fg carbon.base01 :bg carbon.base14})
                   (custom-set-face! :CmpItemKindMethod []
                                     {:fg carbon.base01 :bg carbon.base15})
                   (custom-set-face! :CmpItemKindValue []
                                     {:fg carbon.base01 :bg carbon.base15})
                   (custom-set-face! :CmpItemKindEnumMember []
                                     {:fg carbon.base01 :bg carbon.base15})))

;; nvimtree

(nyoom-module-p! nvimtree
                 (do
                   (custom-set-face! :NvimTreeImageFile []
                                     {:fg carbon.base12 :bg carbon.none})
                   (custom-set-face! :NvimTreeFolderIcon []
                                     {:fg carbon.base12 :bg carbon.none})
                   (custom-set-face! :NvimTreeWinSeparator []
                                     {:fg carbon.base00 :bg carbon.base00})
                   (custom-set-face! :NvimTreeFolderName []
                                     {:fg carbon.base09 :bg carbon.none})
                   (custom-set-face! :NvimTreeIndentMarker []
                                     {:fg carbon.base02 :bg carbon.none})
                   (custom-set-face! :NvimTreeEmptyFolderName []
                                     {:fg carbon.base15 :bg carbon.none})
                   (custom-set-face! :NvimTreeOpenedFolderName []
                                     {:fg carbon.base15 :bg carbon.none})
                   (custom-set-face! :NvimTreeNormal []
                                     {:fg carbon.base04 :bg carbon.base00})))

;; neogit

(nyoom-module-p! neogit
                 (do
                   (custom-set-face! :NeogitBranch []
                                     {:fg carbon.base10 :bg carbon.none})
                   (custom-set-face! :NeogitRemote []
                                     {:fg carbon.base09 :bg carbon.none})
                   (custom-set-face! :NeogitHunkHeader []
                                     {:fg carbon.base04 :bg carbon.base02})
                   (custom-set-face! :NeogitHunkHeaderHighlight []
                                     {:fg carbon.base04 :bg carbon.base03})))

;; hydra

(nyoom-module-p! hydra
                 (do
                   (custom-set-face! :HydraRed []
                                     {:fg carbon.base12 :bg carbon.none})
                   (custom-set-face! :HydraBlue []
                                     {:fg carbon.base09 :bg carbon.none})
                   (custom-set-face! :HydraAmaranth []
                                     {:fg carbon.base10 :bg carbon.none})
                   (custom-set-face! :HydraTeal []
                                     {:fg carbon.base08 :bg carbon.none})
                   (custom-set-face! :HydraPink []
                                     {:fg carbon.base14 :bg carbon.none})
                   (custom-set-face! :HydraHint []
                                     {:fg carbon.none :bg carbon.blend})))

;; alpha

(nyoom-module-p! dashboard
                 (do
                   (custom-set-face! :alpha1 []
                                     {:fg carbon.base03 :bg carbon.none})
                   (custom-set-face! :alpha2 []
                                     {:fg carbon.base04 :bg carbon.none})
                   (custom-set-face! :alpha3 []
                                     {:fg carbon.base03 :bg carbon.none})))

;; headlines.nvim

(nyoom-module-p! org
                 (do
                   (custom-set-face! :CodeBlock []
                                     {:fg carbon.none :bg carbon.base01})))

;; nvim-bufferline

(nyoom-module-p! tabs
                 (do
                   (custom-set-face! :BufferLineDiagnostic [:bold]
                                     {:fg carbon.base10 :bg carbon.none})
                   (custom-set-face! :BufferLineDiagnosticVisible [:bold]
                                     {:fg carbon.base10 :bg carbon.none})))
