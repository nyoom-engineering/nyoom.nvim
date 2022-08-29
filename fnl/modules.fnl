(import-macros {: nyoom!} :macros)
;; we shouldn't have to repeat the `nyoom!` calls but somethings buggy NOTE: Any module with a TODO either isn't ready or hasn't been implemented yet.
(nyoom! :completion
        cmp                  ; the ultimate code completion backend
        ;;compleet           ; TODO the *other* ultimate code completion backend
        ;;fzf-lua            ; TODO a search engine for love and life
        (telescope +native)  ; the search engine of the future

        :ui
        nyoom                ; what makes Nyoom look the way it does
        dashboard            ; a nifty splash screen for neovim
        ;;nyoom-quit         ; buggy, terrible implementation of doom-quit. 
        hydra                ; the heads don't byte
        ;;indent-guides      ; highlighted indent columns
        modeline             ; snazzy, nano-emacs-inspired modeline
        nvimtree           ; a project drawer, like NERDTree for vim
        ;;tabs               ; keep tabs on your buffers, literally
        vc-gutter            ; vcs diff in the fringe
        not-vi-tilde-fringe  ; disable fringe tildes to mark beyond EOB
        window-select      ; visually switch windows
        ;;zen                ; distraction-free coding or writing TODO +twilight
        notify)              ; pretty notifications for neovim

(nyoom! :editor
        fold               ; (nigh) universal code folding
        (format +onsave)     ; automated prettiness
        ;;multiple-cursors   ; TODO editing in many places at once
        parinfer             ; turn lisp into python, sort of
        (hotpot +reflect)    ; lets get cooking. please don't disable this
        scratch)              ; emacs-like scratch buffer functionality
        ;;word-wrap          ; soft wrapping with language-aware indent
  

(nyoom! :term
                                                                      	toggleterm)          ; persistant/floating terminal wrapper for :term

(nyoom! :checkers
        syntax)           ; tasing you for misspelling mispelling

(nyoom! :tools
        mason                ; setting your tools in stone
        eval                 ; run code, run (also, repls)
        antifennel           ; hate fennel? write lua and compile it back
        pastebin             ; interacting with pastebin platforms
        lsp                  ; :vscode 
        (neogit +forge)               ; a git porcelain for Neovim
        rgb                ; creating color strings
        tree-sitter)          ; syntax and parsing, sitting in a tree...

(nyoom! :lang
        ;;cc                 ; C > C++ == 1
        ;;clojure            ; java with a lisp
        ;;common-lisp        ; if you've seen one lisp, you've seen them all
        ;;java               ; the poster child for carpal tunnel syndrome
        ;;julia              ; a better, faster MATLAB
        ;;kotlin             ; a better, slicker Java(Script)
        ;;latex              ; writing papers in Emacs has never been so fun
        lua                  ; one-based indices? one-based indices
        markdown             ; writing docs for people to ignore
        ;;nim                ; python + lisp at the speed of c
        ;;neorg              ; organize your plain life in plain text, the neovim way TODO +export +present
        ;;(org +pretty)      ; organize your plain life in plain text, the emacs way
        ;;nix                  ; I hereby declare "nix geht mehr!"
        python             ; beautiful is better than ugly
        ;;rust                 ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
        (sh +fish))          ; she sells {ba,z,fi}sh shells on the C xor
        ;;zig                ; C, but simpler

(nyoom! :config
        (default +bindings +smartparens))
