(import-macros {: nyoom-module-p!
                : set!
                : vlua
                : autocmd!
                : packadd!} :macros)

;; modeline

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
              :t ""})

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
  (var filename (or (and (= (vim.fn.expand "%") "") " nyoom-nvim v")
                    (vim.fn.expand "%:t")))
  (when (not= filename " nyoom-nvim ")
    (set filename (.. " " filename " ")))
  (.. "%#Normal#" filename "%#NormalNC#"))

;; but overwrite them with conditional features if enabled

(nyoom-module-p! vc-gutter (fn get-git-status []
                             (let [branch (or vim.b.gitsigns_status_dict
                                              {:head ""})
                                   is-head-empty (not= branch.head "")]
                               (or (and is-head-empty
                                        (string.format "(λ • #%s) "
                                                       (or branch.head "")))
                                   ""))))

;; get the number of entries of certain severity

(nyoom-module-p! lsp
                 (fn get-lsp-diagnostic []
                   (when (not (rawget vim :lsp))
                     (lua "return \"\""))

                   (fn get-severity [s]
                     (length (vim.diagnostic.get 0 {:severity s})))

                   (local result
                          {:errors (get-severity vim.diagnostic.severity.ERROR)
                           :warnings (get-severity vim.diagnostic.severity.WARN)
                           :info (get-severity vim.diagnostic.severity.INFO)
                           :hints (get-severity vim.diagnostic.severity.HINT)})
                   (string.format " %%#StatusLineDiagnosticWarn#%s %%#StatusLineDiagnosticError#%s "
                                  (or (. result :warnings) 0)
                                  (or (. result :errors) 0))))

(fn get-searchcount []
  (when (= vim.v.hlsearch 0)
    (lua "return \"%#Normal# %l:%c \""))
  (local (ok count) (pcall vim.fn.searchcount {:recompute true}))
  (when (or (or (not ok) (= count.current nil)) (= count.total 0))
    (lua "return \"\""))
  (when (= count.incomplete 1)
    (lua "return \"?/?\""))
  (local too-many (: ">%d" :format count.maxcount))
  (local total (or (and (> count.total count.maxcount) too-many) count.total))
  (.. "%#Normal#" (: " %s matches " :format total)))

(global Statusline {})
(set Statusline.statusline
     (fn []
       (table.concat [(color)
                      (: (string.format " %s "
                                        (. modes
                                           (. (vim.api.nvim_get_mode) :mode)))
                         :upper)
                      (get-fileinfo)
                      (get-git-status)
                      (get-bufnr)
                      "%="
                      (get-lsp-diagnostic)
                      (get-filetype)
                      (get-searchcount)])))

(set! laststatus 3)
(set! cmdheight 0)
(set! statusline (.. "%!" (vlua Statusline.statusline)))

(fn load-incline []
  (local count (length (vim.fn.getbufinfo {:buflisted 1})))
  (when (>= count 2)
    (do
      (packadd! incline.nvim)
      (local {: autoload} (require :core.lib.autoload))
      (local {: setup} (autoload :core.lib.setup))
      (local {: diagnostic-icons} (autoload :core.shared))

      (fn incline-diagnostic-label [props]
        (let [label {}]
          (each [severity icon (pairs diagnostic-icons)]
            (local n
                   (length (vim.diagnostic.get props.buf
                                               {:severity (. vim.diagnostic.severity
                                                             (string.upper severity))})))
            (when (> n 0)
              (table.insert label
                            {1 (.. icon " " n " ")
                             :group (.. :DiagnosticSign severity)})))
          (when (> (length label) 0)
            (table.insert label [" "]))
          label))

      (fn incline-git-diff [props]
        (let [icons {:removed "" :changed "" :added ""}
              labels {}
              signs (vim.api.nvim_buf_get_var props.buf :gitsigns_status_dict)]
          (each [name icon (pairs icons)]
            (when (and (tonumber (. signs name)) (> (. signs name) 0))
              (table.insert labels
                            {1 (.. icon " " (. signs name) " ")
                             :group (.. :Diff name)})))
          (when (> (length labels) 0)
            (table.insert labels [" "]))
          labels))

      (setup :incline {:render (fn [props]
                                 (local filename
                                        (vim.fn.fnamemodify (vim.api.nvim_buf_get_name props.buf)
                                                            ":t"))
                                 (local (ft-icon ft-color)
                                        ((. (autoload :nvim-web-devicons)
                                            :get_icon_color) filename))
                                 (local modified
                                        (or (and (vim.api.nvim_buf_get_option props.buf
                                                                              :modified)
                                                 "bold,italic")
                                            :bold))
                                 (local buffer
                                        [[(incline-diagnostic-label props)]
                                         [(incline-git-diff props)]
                                         {1 ft-icon :guifg ft-color}
                                         [" "]
                                         {1 filename :gui modified}])
                                 buffer)
                       :hide {:cursorline true
                              :focused_win false
                              :only_win true}
                       :ignore {:buftypes {}
                                :filetypes [:fugitiveblame
                                            :DiffviewFiles
                                            :DiffviewFileHistory
                                            :DiffviewFHOptionPanel
                                            :Outline
                                            :dashboard]
                                :floating_wins true
                                :unlisted_buffers false
                                :wintypes :special}
                       :highlight {:groups {:InclineNormal :NONE
                                            :InclineNormalNC :NONE}}
                       :window {:margin {:horizontal {:left 0 :right 1}
                                         :vertical {:bottom 0 :top 1}}
                                :options {:winblend 20
                                          :signcolumn :no
                                          :wrap false}
                                :padding {:left 2 :right 2}
                                :padding_char " "
                                :placement {:vertical :top :horizontal :right}
                                :width :fit
                                :winhighlight {:active {:EndOfBuffer :None
                                                        :Normal :InclineNormal
                                                        :Search :None}
                                               :inactive {:EndOfBuffer :None
                                                          :Normal :InclineNormalNC
                                                          :Search :None}}
                                :zindex 10}}))))

(autocmd! [:BufAdd :TabEnter] * `(load-incline))
