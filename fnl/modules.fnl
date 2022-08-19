(import-macros {: nyoom!} :macros)

;;; fnl/modules.fnl 
;; NOTE: Any module with a TODO either isn't ready or hasn't been implemented yet.

(nyoom! completion.cmp             ; the ultimate code completion backend
        ;;completion.compleet      ; TODO the *other* ultimate code completion backend
        ;;completion.fzf-lua       ; TODO a search engine for love and life
        completion.telescope       ; the search engine of the future

        ui.nyoom                   ; what makes Nyoom look the way it does
        ui.dashboard               ; a nifty splash screen for neovim
        ;;ui.nyoom-quit            ; TODO quit-message prompts when you quit Emacs
        ui.hydra                   ; the heads don't byte
        ;;ui.indent-guides         ; highlighted indent columns
        ui.modeline                ; snazzy, nano-emacs-inspired modeline
        ;;ui.nvimtree              ; a project drawer, like NERDTree for vim
        ;;ui.tabs                  ; a tab bar for Neovim
        ui.vc-gutter               ; vcs diff in the fringe
        ;ui.vi-tilde-fringe        ; fringe tildes to mark beyond EOB
        ;;ui.window-select         ; visually switch windows
        ;;ui.zen                   ; distraction-free coding or writing
        ui.notify                  ; pretty notifications for neovim

        ;;editor.fold              ; (nigh) universal code folding
        ;;editor.format            ; automated prettiness
        ;;editor.multiple-cursors  ; TODO editing in many places at once
        editor.parinfer            ; turn lisp into python, sort of
        editor.parens              ; basic parenthesis management
        editor.hotpot              ; lets get cooking
        ;;editor.word-wrap         ; soft wrapping with language-aware indent

        ;;term.fshell              ; the fennel shell that works everywhere
        ;;term.toggleterm          ; persistant/floating terminal wrapper for :term

        ;;checkers.spell           ; tasing you for misspelling mispelling

        ;;tools.profile            ; profile your configuration today
        ;;tools.debugger           ; FIXME stepping through code, to help you add bugs
        ;;tools.docker             ; row row row your boat
        ;;tools.editorconfig       ; let someone else argue about tabs vs spaces
        ;;tools.magma              ; TODO tame Jupyter notebooks
        tools.mason                ; setting your tools in stone
        tools.conjure              ; run code, run (also, repls)
        tools.antifennel           ; hate fennel? write lua and compile it back
        tools.pastebin             ; interacting with pastebin platforms
        tools.lsp                  ; :vscode 
        tools.neogit               ; a git porcelain for Neovim
        ;;tools.rgb                ; creating color strings
        tools.tree-sitter          ; syntax and parsing, sitting in a tree...

        lang.java                  ; the poster child for carpal tunnel syndrome
        ;;lang.julia               ; a better, faster MATLAB
        lang.markdown              ; writing docs for people to ignore
        lang.neorg                 ; organize your plain life in plain text
        lang.nix                   ; I hereby declare "nix geht mehr!"
        lang.rust                  ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
        ;;lang.sh                  ; she sells {ba,z,fi}sh shells on the C xor

        config.default             ; Don't disable this!
        config.bindings)           ; intuitive motions
        ;;config.literate          ; literate configurations for neovim
