(import-macros {: nyoom!} :macros)

;;; fnl/modules.fnl 
;; NOTE: Any module with an asterisk after it (*) either isn't ready or implemented yet.

(nyoom! :completion
	cmp; the ultimate code completion backend
        ;;completion.compleet      ; the *other* ultiamte code completion backend*
        ;;completion.fzf-lua       ; a search engine for love and life*
        (telescope +native))       ; the search engine of the future

(nyoom! :ui
	nyoom                   ; what makes Nyoom look the way it does*
        ;;ui.dashboard             ; a nifty splash screen for neovim*
        ;;ui.nyoom-quit            ; quit-message prompts when you quit Emacs
        hydra                   ; the heads don't byte
        ;;ui.indent-guides         ; highlighted indent columns*
        ;;ui.modeline              ; snazzy, nano-emacs-inspired modeline, plus API*
        nvimtree              ; a project drawer, like NERDTree for vim
        ;;ui.tabs                  ; a tab bar for Neovim*
        vc-gutter               ; vcs diff in the fringe
        ;;ui.vi-tilde-fringe       ; fringe tildes to mark beyond EOB*
        window-select         ; visually switch windows
        ;;ui.zen                     ; distraction-free coding or writing
        notify)                  ; pretty notifications for neovim

(nyoom! :editor
	leap                ; intuitive motions
        parinfer            ; turn lisp into python, sort of*
        (hotpot +reflect)             ; lets get cooking
        comment)

(nyoom! :term
	toggleterm)          ; persistant/floating terminal wrapper for :term

(nyoom! :checkers
        syntax)           ; tasing you for misspelling mispelling

(nyoom! :tools
        mason                ; setting your tools in stone
        conjure              ; run code, run (also, repls)
        ;;tools.antifennel         ; hate fennel? write lua and compile it back*
        pastebin             ; interacting with pastebin platforms
        lsp                  ; :vscode 
        (neogit +forge)               ; a git porcelain for Neovim
        rgb                ; creating color strings
        tree-sitter)          ; syntax and parsing, sitting in a tree...

(nyoom! :lang
	lua
	markdown
	sh)

(nyoom! :themes
	tokyonight)

(nyoom! :config
        (default +bindings +smartparens))
