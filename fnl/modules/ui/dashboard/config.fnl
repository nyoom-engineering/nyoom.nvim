(import-macros {: nyoom-module-p! : nyoom-package-count : nyoom-module-count} :macros)
(local {: setup} (require :alpha))

(nyoom-module-p! ui.dashboard.+startuptime
  (do
    ;; truncate a number to a certain decimal
    (fn truncate [num digits]
      (let [mult (^ 10 digits)]
        (/ (math.modf (* num mult)) mult)))

    ;; read startuptime, only if the file exists
    (local startup-file :/tmp/nvim-startuptime)
    (local startup-time-file (: (io.open startup-file) :read :*all))
    (local startup-time (truncate (* (tonumber (startup-time-file:match "([%d.]+)  [%d.]+: [-]+ NVIM STARTED [-]+")) 0.001) 3))
    (: (io.open startup-file :w) :close)

    ;; Honestly I can't think of a better way to do this. 
    ;; On average, compiling took 0.2+ and loading took 0.03+ so, I think its good for now
    (local compiled-or-loaded
       (if (< startup-time 0.2)
           "loaded "
           "compiled "))))

;; setup alpha
(fn button [sc txt keybind]
  (let [sc- (: (sc:gsub "%s" "") :gsub :SPC :<leader>)
        opts {:position :center
              :text txt
              :shortcut sc
              :cursor 5
              :width 36
              :align_shortcut :right
              :hl :alpha2}]
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
                     ;; (.. "Nyoom " compiled-or-loaded (nyoom-package-count) " packages across " (nyoom-module-count) " modules in " startup-time :s)))
                     (.. "Nyoom loaded " (nyoom-package-count) " packages across " (nyoom-module-count) " modules")))

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
                       :opts {:position :center :hl :alpha1}}
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
                       :opts {:position :center :hl :alpha3}}})

(setup {:layout [{:type :padding :val 5}
                 options.header
                 {:type :padding :val 2}
                 options.buttons
                 {:type :padding :val 2}
                 options.footer]
        :opts {}})
