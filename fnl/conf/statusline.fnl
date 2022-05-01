(import-macros {: cmd} :conf.macros)
(local modes {:n "RW"
              :no "RO"
              :v "**"
              :V "**"
              "\022" "**"
              :s "S"
              :S "SL"
              "\019" "SB"
              :i "**"
              :ic "**"
              :R " ⨀ "
              :Rv " ⨀ "
              :c "VIEX"
              :cv "VIEX"
              :ce "EX"
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

(global Statusline {})
(set Statusline.active (fn []
                         (table.concat {1 (color)
                                        2 (: (string.format " %s "
                                                            (. modes
                                                               (. (vim.api.nvim_get_mode)
                                                                  :mode)))
                                             :upper)
                                        3 "%#StatusLine#"
                                        4 " %f "
                                        5 "%="
                                        6 " %Y "
                                        7 (color)
                                        8 " %l:%c "})))
(fn Statusline.inactive []
  "%#StatusInactive# %f ")

(fn Statusline.short []
  "%#StatusLine#")

(cmd "  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree*,terminal setlocal statusline=%!v:lua.Statusline.short()
  au WinLeave,BufLeave,FileType NvimTree*,terminal setlocal statusline=%!v:lua.Statusline.short()
")  
