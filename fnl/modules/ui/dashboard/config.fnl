(import-macros {: nyoom-package-count : nyoom-module-count} :macros)
(local {: setup} (require :alpha))

(fn button [sc txt keybind]
  (let [sc- (: (sc:gsub "%s" "") :gsub :SPC :<leader>)
        opts {:position :center
              :text txt
              :shortcut sc
              :cursor 5
              :width 36
              :align_shortcut :right
              :hl :AlphaButtons}]
    (when keybind
      (set opts.keymap [:n sc- keybind {:noremap true :silent true}]))
    {:type :button
     :val txt
     :on_press (fn []
                 (local key
                        (vim.api.nvim_replace_termcodes sc- true false true))
                 (vim.api.nvim_feedkeys key :normal false))
     : opts}))

(local bottom-text (if (= (nyoom-package-count) 0)
                     "Nyoom is in an incomplete state. Please run 'nyoom sync'" 
                     (.. "Nyoom loaded " (nyoom-package-count) " packages across " (nyoom-module-count) " modules in 0.0326s")))


(var options {:header {:type :text
                       :val ["   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          "
                             "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       "
                             "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     "
                             "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    "
                             "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   "
                             "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  "
                             "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   "
                             " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  "
                             " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ "
                             "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     "
                             "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     "]
                       :opts {:position :center :hl :Trailhighlight}}
              :buttons {:type :group
                        :val [(button "SPC f f" "  Find File  "
                                      ":Telescope find_files<CR>")
                              (button "SPC f o" "  Recent File  "
                                      ":Telescope oldfiles<CR>")
                              (button "SPC f g" "  Live Grep  "
                                      ":Telescope live_grep<CR>")
                              (button "SPC f p" "  Projects  "
                                      ":Telescope marks<CR>")
                              (button "SPC f k" "  Keymaps  "
                                      ":Telescope keymaps<CR>")]
                        :opts {:spacing 1}}
              :footer {:type :text
                       :val bottom-text
                       :opts {:position :center :hl :Trailhighlight}}})

(setup {:layout [{:type :padding :val 5}
                 options.header
                 {:type :padding :val 2}
                 options.buttons
                 {:type :padding :val 2}
                 options.footer]
        :opts {}})
