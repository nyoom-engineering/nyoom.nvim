(import-macros {: set! : local-set!} :macros.option-macros)

;; Icons/text for each mode 
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

;; Make our statusline colourful
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

;; get git status via gitsigns
(fn get-git-status []
  (let [branch (or vim.b.gitsigns_status_dict
                   {:head ""})
        is-head-empty (not= branch.head "")]
    (or (and is-head-empty
             (string.format "(λ • #%s)"
                            (or branch.head "")))
        "")))

;; vim.diagnostic integration
(fn get-lsp-diagnostic []
  (local buf-clients (vim.lsp.buf_get_clients 0))
  (local next next)
  (when (= (next buf-clients) nil)
    (lua "return \"\""))

  (local diagnostics (vim.diagnostic.get 0))
  (local count [0 0 0 0])

  (each [_ diagnostic (ipairs diagnostics)]
    (tset count diagnostic.severity (+ (. count diagnostic.severity) 1)))

  (local result {:errors (. count vim.diagnostic.severity.ERROR)
                 :warnings (. count vim.diagnostic.severity.WARN)
                 :info (. count vim.diagnostic.severity.INFO)
                 :hints (. count vim.diagnostic.severity.HINT)})

  (string.format " %%#StatusLineDiagnosticWarn#%s %%#StatusLineDiagnosticError#%s "
                 (or (. result :warnings) 0) (or (. result :errors) 0)))

;; Normally we would have an inactive and a short section as well, but since we have a global statusline now I removed them
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

(set! winbar "%!v:lua.Statusline.winbar()")
(set! statusline "%!v:lua.Statusline.statusline()")
