(import-macros {: nyoom!} :macros)
;; NOTE: Currently this file does nothing. It will in the future however!

(macrodebug
  (nyoom! completion.cmp             ; the ultimate code completion backend
          ;;completion.compleet      ; the *other* ultiamte code completion backend
          ;;completion.fzf-lua       ; a search engine for love and life
          completion.telescope       ; the search engine of the future

          ui.nyoom                   ; what makes Nyoom look the way it does
          ui.dashboard               ; a nifty splash screen for neovim
          ui.nyoom-quit              ; quit-message prompts when you quit Emacs
          ui.hydra                   ; the heads don't byte
          ;;ui.indent-guides         ; highlighted indent columns
          ui.modeline                ; snazzy, nano-emacs-inspired modeline, plus API
          ;;ui.nvimtree              ; a project drawer, like NERDTree for vim
          ;;ui.tabs                  ; a tab bar for Neovim
          ui.vc-gutter               ; vcs diff in the fringe
          ;;ui.vi-tilde-fringe       ; fringe tildes to mark beyond EOB
          ;;ui.window-select         ; visually switch windows
          ;;ui.zen                   ; distraction-free coding or writing
          ;;ui.notify                ; pretty notifications for neovim
 
          ;;editor.fold              ; (nigh) universal code folding
          ;;editor.format            ; automated prettiness
          editor.leap                ; intuitive motions
          ;;editor.multiple-cursors  ; editing in many places at once
          editor.parinfennel         ; turn lisp into python, sort of
          ;;editor.aniseed           ; who knew fennel could be this tasty
          editor.hotpot              ; lets get cooking
          editor.snippets            ; my elves. They type so I don't have to
          ;;editor.word-wrap         ; soft wrapping with language-aware indent
 
          ;;term.nshell              ; the fennel shell that works everywhere
          term.term                  ; basic terminal emulator for neovim
 
          ;;checkers.spell           ; tasing you for misspelling mispelling
          ;;checkers.grammar         ; tasing grammar mistake every you make
 
          ;;tools.profile            ; profile your configuration today
          ;;tools.debugger           ; FIXME stepping through code, to help you add bugs
          ;;tools.direnv             ; direcory-specific enviornment
          ;;tools.docker             ; row row row your boat
          ;;tools.editorconfig       ; let someone else argue about tabs vs spaces
          ;;tools.magma              ; tame Jupyter notebooks with emacs
          tools.conjure              ; run code, run (also, repls)
          tools.antifennel           ; hate fennel? write lua and compile it back
          ;;tools.gist               ; interacting with github gists
          tools.lsp                  ; :vscode 
          tools.neogit               ; a git porcelain for Neovim
          ;;tools.make               ; run make tasks from Neovim
          ;;tools.rgb                ; creating color strings
          tools.tree-sitter          ; syntax and parsing, sitting in a tree...
 
          ;;lang.java                ; the poster child for carpal tunnel syndrome
          lang.neorg                 ; organize your plain life in plain text
          ;;lang.rust                ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
 
          core.core                  ; don't disable this :)
          ;;core.literate            ; literate configurations for neovim
          core.parens))              ; basic parenthesis management




