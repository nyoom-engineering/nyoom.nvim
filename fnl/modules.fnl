(import-macros {: nyoom!} :macros)
;; NOTE: TODO and FIXME modules still need work. WIP: modules work but may still be buggy

;; fnlfmt: skip
(nyoom! :completion
        cmp                  ; the ultimate code completion backend
        ;;copilot              ; the code completion of the future
        ;;fzf-lua            ; TODO a search engine for love and life
        (telescope +native)  ; the search engine of the future

        :ui
        (nyoom +modes +icons); what makes Nyoom look the way it does
        dashboard            ; a nifty splash screen for neovim
        ;;nyoom-quit         ; WIP: buggy, terrible implementation of doom-quit. 
        hydra                ; Discount modality for mythological beast hunters
        ;;indent-guides      ; highlighted indent columns
        modeline             ; snazzy, nano-emacs-inspired modeline
        ;;nvimtree           ; a project drawer, like NERDTree for vim
        neotree              ; tree-like structures for neovim
        ;;tabs               ; keep tabs on your buffers, literally
        vc-gutter            ; Get your diff out of the gutter
        window-select        ; Visually switch windows
        zen                  ; distraction-free coding or writing TODO +twilight
        noice                ; noice ui

        :editor
        fold                 ; (nigh) universal code folding
        (format +onsave)     ; automated prettiness
        ;;multiple-cursors   ; learn macros you dingus
        parinfer             ; turn lisp into python, sort of
        (hotpot +reflect)    ; lets get cooking. NOTE: essential module (for now), don't disable
        scratch              ; emacs-like scratch buffer functionality
        word-wrap            ; language-aware smart soft and hard wrapping

        :term
        ;;fshell             ; WIP: the fennel shell that works everywhere
        toggleterm           ; persistant/floating terminal wrapper for :term

        :checkers
        diagnostics          ; tasing you for every semicolon you forget
        grammar              ; tasing grammar mistake every you make
        ;;spell              ; tasing you for misspelling mispelling

        :tools
        debugger             ; stepping through code, to help you add bugs
        docker               ; row row row your boat TODO +netman?
        ;;editorconfig       ; let someone else argue about tabs vs spaces
        ;;magma              ; tame Jupyter notebooks
        mason                ; setting your tools in stone
        eval                 ; run code, run (also, repls)
        antifennel           ; for all the fennel haters out there. this ones for you
        pastebin             ; interacting with pastebin platforms
        lsp                  ; :vscode 
        (neogit              ; a git porclain for neovim
          +forge             ; Wield git like a wizard
          +diffview)         ; a git diff view for neovim
        rgb                  ; creating color strings
        tree-sitter          ; syntax and parsing, sitting in a tree... 

        :lang
        cc                   ; C > C++ == 1
        clojure              ; java with a lisp
        common-lisp          ; if you've seen one lisp, you've seen them all
        java                 ; the poster child for carpal tunnel syndrome
        julia                ; a better, faster MATLAB
        ;;kotlin             ; FIXME: a better, slicker Java(Script)
        latex                ; writing papers in Neovim has never been so fun
        lua                  ; one-based indices? one-based indices
        markdown             ; writing docs for people to ignore
        nim                  ; python + lisp at the speed of c
        (neorg               ; organize your plain life in plain text, the neovim way
          +pretty
          +present
          +export
          +nabla)
        ;;(org +pretty)      ; WIP: organize your plain life in plain text, the emacs way
        nix                  ; I hereby declare "nix geht mehr!"
        python               ; beautiful is better than ugly
        rust                 ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
        (sh +fish)           ; she sells {ba,z,fi}sh shells on the C xor
        zig                  ; C, but simpler

        :app
        ;;calendar           ; Watch your missed deadlines in real time

        :config
        ;;literate           ; FIXME: Disguise your config as poor documentation
        (default             ; Reasonable defaults for reasonable people
          +bindings 
          +which-key
          +smartparens))
