(import-macros {: set!} :macros.option-macros)
(import-macros {: colorscheme} :macros.highlight-macros)
(local Hydra (require :hydra))

;; Git
;; We only want to load the git integration when a git repo is detected
(local loader (. (require :packer) :loader))
(local gitrepo (vim.fn.isdirectory :.git/index))
(when gitrepo
  (loader "gitsigns.nvim")
  (local {: toggle_linehl
          : toggle_deleted
          : next_hunk
          : prev_hunk
          : undo_stage_hunk
          : stage_buffer
          : preview_hunk
          : toggle_deleted
          : blame_line
          : show} (require :gitsigns))
  (local git-hint "
  
                    Git
  
    _J_: next hunk     _d_: show deleted
    _K_: prev hunk     _u_: undo last stage  
    _s_: stage hunk    _/_: show base file
    _p_: preview hunk  _S_: stage buffer
    _b_: blame line    _B_: blame show full
  ^
    _<Enter>_: Neogit         _q_: Exit
  
  ")
  (Hydra {:name :Git
          :hint git-hint
          :mode [:n :x]
          :body :<leader>g
          :config {:buffer bufnr
                   :color :red
                   :invoke_on_body true
                   :hint {:border :solid :position :middle}
                   :on_key (fn []
                             (vim.wait 50))
                   :on_enter (fn []
                               (vim.cmd.mkview)
                               (vim.cmd "silent! %foldopen!")
                               (toggle_linehl true))
                   :on_exit (fn []
                              (local cursor-pos (vim.api.nvim_win_get_cursor 0))
                              (vim.cmd.loadview)
                              (vim.api.nvim_win_set_cursor 0 cursor-pos)
                              (vim.cmd.normal "zv")
                              (toggle_linehl false)
                              (toggle_deleted false))}
          :heads [[:J
                   (fn []
                     (when vim.wo.diff
                       (lua "return \"]c\""))
                     (vim.schedule (fn []
                                     (next_hunk)))
                     :<Ignore>)
                   {:expr true :desc "next hunk"}]
                  [:K
                   (fn []
                     (when vim.wo.diff
                       (lua "return \"[c\""))
                     (vim.schedule (fn []
                                     (prev_hunk)))
                     :<Ignore>)
                   {:expr true :desc "prev hunk"}]
                  [:s
                   (fn []
                     (local mode (: (. (vim.api.nvim_get_mode) :mode) :sub 1
                                    1))
                     (if (= mode :V)
                         (do
                           (local esc
                                  (vim.api.nvim_replace_termcodes :<Esc> true
                                                                  true true))
                           (vim.api.nvim_feedkeys esc :x false)
                           (vim.cmd "'<,'>Gitsigns stage_hunk"))
                         (vim.cmd.Gitsigns "stage_hunk")))
                   {:desc "stage hunk"}]
                  [:u 
                   undo_stage_hunk
                   {:desc "undo last stage"}]
                  [:S 
                   stage_buffer
                   {:desc "stage buffer"}]
                  [:p 
                   preview_hunk 
                   {:desc "preview hunk"}]
                  [:d
                   toggle_deleted
                   {:nowait true :desc "toggle deleted"}]
                  [:b 
                   blame_line 
                   {:desc :blame}]
                  [:B
                   (fn []
                     blame_line {:full true})
                   {:desc "blame show full"}]
                  ["/"
                   show
                   {:exit true :desc "show base file"}]
                  [:<Enter>
                   (fn []
                      (vim.cmd.Neogit))
                   {:exit true :desc :Neogit}]
                  [:q 
                   nil 
                   {:exit true :nowait true :desc :exit}]]}))
  
;; Vim options
(local options-hint "
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters  
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  _b_ Toggle Background
  ^
       ^^^^              _<Esc>_

")

(Hydra {:name :Options
        :hint options-hint
        :config {:color :amaranth
                 :invoke_on_body true
                 :hint {:border :solid :position :middle}}
        :mode [:n :x]
        :body :<leader>o
        :heads [[:b
                 (fn []
                   (if (= vim.o.background :dark) 
                       (set! background :light)
                       (set! background :dark))
                  (require :oxocarbon))
 
                 {:desc :Background}]
                [:n
                 (fn []
                   (if (= vim.o.number true) 
                       (set! nonumber)
                       (set! number)))
                 {:desc :number}]
                [:r
                 (fn []
                   (if (= vim.o.relativenumber true)
                       (set! norelativenumber)
                       (do
                         (set! number)
                         (set! relativenumber))))
                 {:desc :relativenumber}]
                [:v
                 (fn []
                   (if (= vim.o.virtualedit :all)
                       (set! virtualedit :block)
                       (set! virtualedit :all)))
                 {:desc :virtualedit}]
                [:i
                 (fn []
                   (if (= vim.o.list true) 
                       (set! nolist)
                       (set! list)))
                 {:desc "show invisible"}]
                [:s
                 (fn []
                   (if (= vim.o.spell true) 
                       (set! nospell)
                       (set! spell)))
                 {:exit true :desc :spell}]
                [:w
                 (fn []
                   (if (= vim.o.wrap true)
                       (set! nowrap)
                       (set! wrap)))
                 {:desc :wrap}]
                [:c
                 (fn []
                   (if (= vim.o.cursorline true)
                       (set! nocursorline)
                       (set! cursorline)))
                 {:desc "cursor line"}]
                [:<Esc> 
                 nil 
                 {:exit true}]]})

;; Telescope
(local telescope-hint "
           _o_: old files   _g_: live grep
           _p_: projects    _/_: search in file
           _r_: resume      _f_: files
   ▁
           _h_: vim help    _c_: execute command
           _k_: keymaps     _;_: commands history  
           _O_: options     _?_: search history
  ^
  _<Esc>_         _<Enter>_: NvimTree

")

(Hydra {:name :Telescope
        :hint telescope-hint
        :config {:color :teal
                 :invoke_on_body true
                 :hint {:position :middle :border :solid}}
        :mode :n
        :body :<Leader>f
        :heads [[:f 
                 (fn []
                   (vim.cmd "Telescope find_files"))]
                [:g 
                 (fn []
                   (vim.cmd "Telescope live_grep"))]
                [:o
                 (fn []
                   (vim.cmd "Telescope oldfiles"))
                 {:desc "recently opened files"}]
                [:h 
                 (fn []
                   (vim.cmd "Telescope help_tags"))
                 {:desc "vim help"}]
                [:k 
                 (fn []
                   (vim.cmd "Telescope keymaps"))]
                [:O 
                 (fn []
                   (vim.cmd "Telescope vim_options"))]
                [:r 
                 (fn []
                   (vim.cmd "Telescope resume"))]
                [:p 
                 (fn []
                   ((. (. (. (require :telescope) :extensions) :project) :project) {:display_type :full}))
                 {:desc :projects}]
                ["/"
                 (fn []
                   (vim.cmd "Telescope current_buffer_fuzzy_find"))
                 {:desc "search in file"}]
                ["?"
                 (fn []
                   (vim.cmd "Telescope search_history"))
                 {:desc "search history"}]
                [";"
                 (fn []
                   (vim.cmd "Telescope command_history"))
                 {:desc "command-line history"}]
                [:c
                 (fn []
                   (vim.cmd "Telescope commands"))
                 {:desc "execute command"}]
                [:<Enter>
                 (fn []
                    (vim.cmd :NvimTreeToggle))
                 {:exit true :desc :NvimTree}]
                [:<Esc> 
                 nil 
                 {:exit true :nowait true}]]})

;; Visuals
(local visuals-hint "
  ^ ^     פּ Visuals
  ^
  _z_ TrueZen Ataraxis
  _p_ TS Playground
  _h_ TS Highlight Capture  
  ^
  ^^^^              _<Esc>_

")

(Hydra {:name :Visuals
        :hint visuals-hint
        :config {:color :teal
                 :invoke_on_body true
                 :hint {:border :solid :position :middle}}
        :mode [:n :x]
        :body :<leader>z
        :heads [[:z
                 (fn []
                   (vim.cmd :TZAtaraxis))]
                [:p
                 (fn []
                   (vim.cmd :TSPlayground))]
                [:h
                 (fn []
                   (vim.cmd :TSHighlightCapturesUnderCursor))]
                [:<Esc> 
                 nil 
                 {:exit true}]]})

;; Rust
;; (local rust-hint "
;;
;;                   Rust
;;
;;   _r_: runnables      _m_: expand macro
;;   _d_: debugabbles    _c_: open cargo
;;   _s_: rustssr        _p_: parent module
;;   _h_: hover actions  _w_: reload workspace
;;   _D_: open docs      _g_: view create graph  
;; ^
;;   _i_: Toggle Inlay Hints     _q_: Exit
;;
;; ")
;;
;; (Hydra {:name :Rust
;;         :hint rust-hint
;;         :config {:color :red
;;                  :invoke_on_body true
;;                  :hint {:position :middle :border :solid}}
;;         :mode :n
;;         :body :<Leader>r
;;         :heads [[:r 
;;                  (fn []
;;                    (vim.cmd.RustRunnables))
;;                  {:exit true}]
;;                 [:d 
;;                  (fn []
;;                    (vim.cmd.RustDebuggables))
;;                  {:exit true}]
;;                 [:s
;;                  (fn []
;;                    (vim.cmd.RustSSR))
;;                  {:exit true}]
;;                 [:h 
;;                  (fn []
;;                    (vim.cmd.RustHoverActions))
;;                  {:exit true}]
;;                 [:D 
;;                  (fn []
;;                    (vim.cmd.RustOpenExternalDocs))
;;                  {:exit true}]
;;                 [:m 
;;                  (fn []
;;                    (vim.cmd.RustExpandMacro))
;;                  {:exit true}]
;;                 [:c 
;;                  (fn []
;;                    (vim.cmd.RustOpenCargo))
;;                  {:exit true}]
;;                 [:p 
;;                  (fn []
;;                    (vim.cmd.RustParentModule))
;;                  {:exit true}]
;;                 [:w
;;                  (fn []
;;                    (vim.cmd.RustReloadWorkspace))
;;                  {:exit true}]
;;                 [:g
;;                  (fn []
;;                    (vim.cmd.RustViewCrateGraph))
;;                  {:exit true}]
;;                 [:i
;;                  (fn []
;;                    (vim.cmd.RustToggleInlayHints))]
;;                 [:q
;;                  nil 
;;                  {:exit true :nowait true}]]})
;;
;;
;;
;;
;;
;;
;;
;;
;;
