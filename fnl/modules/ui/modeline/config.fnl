(import-macros {: set! : nyoom-module-p! : vlua} :macros)

(local cache {:bufnrs {}})
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
              :t :})

;; by default these can be blank:
(fn get-git-status []
  "")
(fn get-lsp-diagnostic []
  "")

(fn get-filetype []
  (.. "%#NormalNC#" vim.bo.filetype))

(fn get-bufnr []
  (.. "%#Comment#" (vim.api.nvim_get_current_buf)))

(fn color []
  (let [mode (. (vim.api.nvim_get_mode) :mode)]
    (var mode-color "%#Normal#")
    (if (= mode :n) (set mode-color "%#StatusNormal#")
        (or (= mode :i) (= mode :ic)) (set mode-color "%#StatusInsert#")
        (or (or (= mode :v) (= mode :V)) (= mode "\022"))
        (set mode-color "%#StatusVisual#") (= mode :R)
        (set mode-color "%#StatusReplace#") (= mode :c)
        (set mode-color "%#StatusCommand#") (= mode :t)
        (set mode-color "%#StatusTerminal#"))
    mode-color))

(fn get-fileinfo []
  (var filename (or (and (= (vim.fn.expand "%") "") " nyoom-nvim ")
                    (vim.fn.expand "%:t")))
  (when (not= filename " nyoom-nvim ")
        (set filename (.. " " filename " ")))
  (.. "%#Normal#" filename))

;; but overwrite them with conditional features if enabled
(nyoom-module-p! vc-gutter
  (fn get-git-status []
    (let [branch (or vim.b.gitsigns_status_dict
                     {:head ""})
          is-head-empty (not= branch.head "")]
      (or (and is-head-empty
               (.. :%#NormalNC# (string.format "(λ • #%s) "
                                              (or branch.head ""))))
          ""))))

;; get the number of entries of certain severity
(nyoom-module-p! lsp
  (fn get-lsp-diagnostic []
    (when (not (rawget vim :lsp))
      (lua "return \"\""))
    (fn get-severity [s]
      (length (vim.diagnostic.get 0 {:severity s})))
    (local result {:errors (get-severity vim.diagnostic.severity.ERROR)
                   :warnings (get-severity vim.diagnostic.severity.WARN)
                   :info (get-severity vim.diagnostic.severity.INFO)
                   :hints (get-severity vim.diagnostic.severity.HINT)})
    (string.format " %%#StatusLineDiagnosticWarn#%s %%#StatusLineDiagnosticError#%s "
                   (or (. result :warnings) 0) (or (. result :errors) 0))))

(fn get-searchcount []
  (when (= vim.v.hlsearch 0)
    (lua "return \"%#Normal# %l:%c \""))
  (local (ok count) (pcall vim.fn.searchcount {:recompute true}))
  (when (or (or (not ok) (= count.current nil)) (= count.total 0))
    (lua "return \"\""))
  (when (= count.incomplete 1)
    (lua "return \"?/?\""))
  (local too-many (: ">%d" :format count.maxcount))
  (local total (or (and (> count.total count.maxcount) too-many)
                   count.total))
  (.. "%#Normal#" (: " %s matches " :format total)))

(global Statusline {})
(set Statusline.statusline (fn []
                             (table.concat [(color)
                                            (: (string.format " %s "
                                                              (. modes
                                                                 (. (vim.api.nvim_get_mode)
                                                                    :mode)))
                                               :upper)
                                            (get-fileinfo)
                                            (get-git-status)
                                            (get-bufnr)
                                            "%="
                                            (get-lsp-diagnostic)
                                            (get-filetype)
                                            (get-searchcount)])))

(set Statusline.winbar (fn []
                         (table.concat ["%#Comment#"
                                        " %f "])))

(set! laststatus 3)
(set! cmdheight 0)
(set! statusline (.. "%!" (vlua Statusline.statusline)))
(set! winbar (.. "%!" (vlua Statusline.winbar)))

