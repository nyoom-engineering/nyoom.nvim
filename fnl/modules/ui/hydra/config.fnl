(import-macros {: set! : colorscheme : nyoom-module-p! : augroup! : autocmd!}
               :macros)

(local {: autoload} (require :core.lib.autoload))
(local Hydra (autoload :hydra))

;; Git
(nyoom-module-p! vc-gutter
                 (do
                   (local {: toggle_linehl
                           : toggle_deleted
                           : next_hunk
                           : prev_hunk
                           : undo_stage_hunk
                           : stage_buffer
                           : preview_hunk
                           : toggle_deleted
                           : blame_line
                           : show}
                          (autoload :gitsigns))
                   (local git-hint "
                    Git
  
    _J_: next hunk     _d_: show deleted
    _K_: prev hunk     _u_: undo last stage  
    _s_: stage hunk    _/_: show base file
    _p_: preview hunk  _S_: stage buffer
    _b_: blame line    _B_: blame show full
  ^
    _<Enter>_: Neogit       _<Esc>_: Exit
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
                                               (local cursor-pos
                                                      (vim.api.nvim_win_get_cursor 0))
                                               (vim.cmd.loadview)
                                               (vim.api.nvim_win_set_cursor 0
                                                                            cursor-pos)
                                               (vim.cmd.normal :zv)
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
                                      (local mode
                                             (: (. (vim.api.nvim_get_mode)
                                                   :mode)
                                                :sub 1 1))
                                      (if (= mode :V)
                                          (do
                                            (local esc
                                                   (vim.api.nvim_replace_termcodes :<Esc>
                                                                                   true
                                                                                   true
                                                                                   true))
                                            (vim.api.nvim_feedkeys esc :x false)
                                            (vim.cmd "'<,'>Gitsigns stage_hunk"))
                                          (vim.cmd.Gitsigns :stage_hunk)))
                                    {:desc "stage hunk"}]
                                   [:u
                                    undo_stage_hunk
                                    {:desc "undo last stage"}]
                                   [:S stage_buffer {:desc "stage buffer"}]
                                   [:p preview_hunk {:desc "preview hunk"}]
                                   [:d
                                    toggle_deleted
                                    {:nowait true :desc "toggle deleted"}]
                                   [:b blame_line {:desc :blame}]
                                   [:B
                                    (fn []
                                      blame_line
                                      {:full true})
                                    {:desc "blame show full"}]
                                   ["/"
                                    show
                                    {:exit true :desc "show base file"}]
                                   [:<Enter>
                                    (fn []
                                      (vim.cmd.Neogit))
                                    {:exit true :desc :Neogit}]
                                   [:<Esc> nil {:exit true :nowait true}]]})))

;; Vim options
(nyoom-module-p! nyoom
                 (do
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
                                          (set! background :dark)))
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
                                   [:<Esc> nil {:exit true :nowait true}]]})))

;; Telescope
(nyoom-module-p! telescope
                 (do
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
                                      (vim.cmd.Telescope :find_files))]
                                   [:g
                                    (fn []
                                      (vim.cmd.Telescope :live_grep))]
                                   [:o
                                    (fn []
                                      (vim.cmd.Telescope :oldfiles))
                                    {:desc "recently opened files"}]
                                   [:h
                                    (fn []
                                      (vim.cmd.Telescope :help_tags))
                                    {:desc "vim help"}]
                                   [:k
                                    (fn []
                                      (vim.cmd.Telescope :keymaps))]
                                   [:O
                                    (fn []
                                      (vim.cmd.Telescope :vim_options))]
                                   [:r
                                    (fn []
                                      (vim.cmd.Telescope :resume))]
                                   [:p
                                    (fn []
                                      ((. (. (. (autoload :telescope)
                                                :extensions)
                                             :project)
                                          :project) {:display_type :full}))
                                    {:desc :projects}]
                                   ["/"
                                    (fn []
                                      (vim.cmd.Telescope :current_buffer_fuzzy_find))
                                    {:desc "search in file"}]
                                   ["?"
                                    (fn []
                                      (vim.cmd.Telescope :search_history))
                                    {:desc "search history"}]
                                   [";"
                                    (fn []
                                      (vim.cmd.Telescope :command_history))
                                    {:desc "command-line history"}]
                                   [:c
                                    (fn []
                                      (vim.cmd.Telescope :commands))
                                    {:desc "execute command"}]
                                   [:<Enter>
                                    (fn []
                                      (vim.cmd :NvimTreeToggle))
                                    {:exit true :desc :NvimTree}]
                                   [:<Esc> nil {:exit true :nowait true}]]})))

;; Visuals
(nyoom-module-p! tree-sitter
                 (do
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
                                   [:<Esc> nil {:exit true :nowait true}]]})))

;; debugging
(nyoom-module-p! debugger
                 (do
                   (local dap (autoload :dap))
                   (local ui (autoload :dapui))
                   (local hint "
                 Debug

      ^ ^Step^ ^ ^     ^ ^     Action
      ^ ^ ^ ^ ^ ^      ^ ^  
      ^ ^back^ ^ ^     ^_t_ toggle breakpoint  
      ^ ^ _K_^ ^        _T_ clear breakpoints  
  out _H_ ^ ^ _L_ into  _c_ continue
      ^ ^ _J_ ^ ^       _x_ terminate
      ^ ^over ^ ^     ^^_r_ open repl
      ^
  _<Esc>_               _<Enter>_: DapUI
")
                   (Hydra {:name :Debug
                           : hint
                           :config {:color :pink
                                    :invoke_on_body true
                                    :hint {:border :solid :position :middle}}
                           :mode [:n]
                           :body :<leader>d
                           :heads [[:H dap.step_out {:desc "step out"}]
                                   [:J dap.step_over {:desc "step over"}]
                                   [:K dap.step_back {:desc "step back"}]
                                   [:L dap.step_into {:desc "step into"}]
                                   [:t
                                    dap.toggle_breakpoint
                                    {:desc "toggle breakpoint"}]
                                   [:T
                                    dap.clear_breakpoints
                                    {:desc "clear breakpoints"}]
                                   [:c dap.continue {:desc :continue}]
                                   [:x dap.terminate {:desc :terminate}]
                                   [:r
                                    dap.repl.open
                                    {:exit true :desc "open repl"}]
                                   [:<Esc> nil {:exit true :nowait true}]
                                   [:<Enter>
                                    (fn []
                                      (ui.toggle))]]})))

;; filetype hydras
;; Rust
(nyoom-module-p! rust
                 (do
                   (fn rust-hydra []
                     (local rust-hint "
                  Rust

  _r_: runnables      _m_: expand macro
  _d_: debugabbles    _c_: open cargo
  _s_: rustssr        _p_: parent module
  _h_: hover actions  _w_: reload workspace
  _D_: open docs      _g_: view create graph  
^
  _i_: Toggle Inlay Hints   _<Esc>_: Exit
    ")
                     (Hydra {:name :Rust
                             :hint rust-hint
                             :config {:color :red
                                      :invoke_on_body true
                                      :hint {:position :middle :border :solid}
                                      :buffer true}
                             :mode :n
                             :body :<Leader>m
                             :heads [[:r
                                      (fn []
                                        (vim.cmd.RustRunnables))
                                      {:exit true}]
                                     [:d
                                      (fn []
                                        (vim.cmd.RustDebuggables))
                                      {:exit true}]
                                     [:s
                                      (fn []
                                        (vim.cmd.RustSSR))
                                      {:exit true}]
                                     [:h
                                      (fn []
                                        (vim.cmd.RustHoverActions))
                                      {:exit true}]
                                     [:D
                                      (fn []
                                        (vim.cmd.RustOpenExternalDocs))
                                      {:exit true}]
                                     [:m
                                      (fn []
                                        (vim.cmd.RustExpandMacro))
                                      {:exit true}]
                                     [:c
                                      (fn []
                                        (vim.cmd.RustOpenCargo))
                                      {:exit true}]
                                     [:p
                                      (fn []
                                        (vim.cmd.RustParentModule))
                                      {:exit true}]
                                     [:w
                                      (fn []
                                        (vim.cmd.RustReloadWorkspace))
                                      {:exit true}]
                                     [:g
                                      (fn []
                                        (vim.cmd.RustViewCrateGraph))
                                      {:exit true}]
                                     [:i
                                      (fn []
                                        (vim.cmd.RustToggleInlayHints))]
                                     [:<Esc> nil {:exit true :nowait true}]]}))
                   (augroup! localleader-hydras
                             (autocmd! FileType rust `(rust-hydra)))))

(nyoom-module-p! latex
                 (do
                   (fn latex-hydra []
                     (local vimtex-hint "
    ^VimTex                    
    ^                          
    _c_: Continuous Compile    
    _s_: Snapshot Compile      
    _e_: Clean Up Extra Files  
    ^                          
    ^^^^^^                   _<Esc>_^^^
       ")
                     (Hydra {:name :VimTeX
                             :hint vimtex-hint
                             :config {:color :amaranth
                                      :invoke_on_body true
                                      :hint {:border :solid :position :middle}
                                      :buffer true}
                             :mode [:n :x]
                             :body :<leader>m
                             :heads [[:c
                                      (fn []
                                        (vim.cmd :VimtexCompile))
                                      {:exit true}]
                                     [:s
                                      (fn []
                                        (vim.cmd :VimtexCompileSS))
                                      {:exit true}]
                                     [:e
                                      (fn []
                                        (vim.cmd :VimtexClean!))
                                      {:exit true}]
                                     [:<Esc> nil {:exit true :nowait true}]]}))
                   (augroup! localleader-hydras
                             (autocmd! FileType tex `(latex-hydra)))))
