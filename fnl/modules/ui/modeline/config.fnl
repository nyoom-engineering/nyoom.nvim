(import-macros {: set! : local-set! : nyoom-module-p!} :macros)
(local modes {:n :RW
              :no :RO
              :v "**"
              :V "**"
              "\022" "**"
              :s :S
              :S :SL
              "\019" :SB
              :i "**"
              :ic "**"
              :R :RA
              :Rv :RV
              :c :VIEX
              :cv :VIEX
              :ce :EX
              :r :r
              :rm :r
              :r? :r
              :! "!"
              :t :t})
(fn color []
  (let [mode (. (vim.api.nvim_get_mode) :mode)]
    (var mode-color "%#StatusLine#")
    (if (= mode :n) (set mode-color "%#StatusNormal#")
        (or (= mode :i) (= mode :ic)) (set mode-color "%#StatusInsert#")
        (or (or (= mode :v) (= mode :V)) (= mode "\022"))
        (set mode-color "%#StatusVisual#") (= mode :R)
        (set mode-color "%#StatusReplace#") (= mode :c)
        (set mode-color "%#StatusCommand#") (= mode :t)
        (set mode-color "%#StatusTerminal#"))
    mode-color))

;; by default these can be blank:
(fn get-git-status []
  "")
(fn get-lsp-diagnostic []
  "")

;; but overwrite them with conditional features if enabled
(nyoom-module-p! vc-gutter
  (fn get-git-status []
    (let [branch (or vim.b.gitsigns_status_dict
                     {:head ""})
          is-head-empty (not= branch.head "")]
      (or (and is-head-empty
               (string.format "(λ • #%s)"
                              (or branch.head "")))
          ""))))

(nyoom-module-p! lsp
  (fn get-lsp-diagnostic []
    (when (not (rawget vim :lsp))
      (lua "return \"\""))
    (local count [0 0 0 0])
    (local result {:errors (. count vim.diagnostic.severity.ERROR)
                   :warnings (. count vim.diagnostic.severity.WARN)
                   :info (. count vim.diagnostic.severity.INFO)
                   :hints (. count vim.diagnostic.severity.HINT)})
    (string.format " %%#StatusLineDiagnosticWarn#%s %%#StatusLineDiagnosticError#%s "
                   (or (. result :warnings) 0) (or (. result :errors) 0))))

(global Statusline {})
(set Statusline.statusline (fn []
                             (table.concat [(color)
                                            (: (string.format " %s "
                                                              (. modes
                                                                 (. (vim.api.nvim_get_mode)
                                                                    :mode)))
                                               :upper)
                                            "%#StatusLine#"
                                            " %f "
                                            "%#StatusPosition#"
                                            (get-git-status)
                                            "%="
                                            (get-lsp-diagnostic)
                                            "%#StatusPosition#"
                                            " %l:%c "])))
(set Statusline.winbar (fn []
                         (table.concat ["%#WinBar#"
                                        " %f "])))
(set! laststatus 3)
(set! cmdheight 0)
(set! winbar "%!v:lua.Statusline.winbar()")
(set! statusline "%!v:lua.Statusline.statusline()")
