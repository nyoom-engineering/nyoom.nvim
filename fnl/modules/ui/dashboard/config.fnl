(import-macros {: nyoom-module-p!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
(local {: echo!} (autoload :core.lib.io))
;; truncate a number to a certain decimal

(fn truncate [num digits]
  (let [mult (^ 10 digits)]
    (/ (math.modf (* num mult)) mult)))

(var load-counter 0)
(var unload-counter 0)
(each [_ pack (pairs packer_plugins)]
  (if pack.loaded (set load-counter (+ load-counter 1))
      (set unload-counter (+ unload-counter 1))))

(local startup-file :/tmp/nvim-startuptime)
(local startup-time-pattern "([%d.]+)  [%d.]+: [-]+ NVIM STARTED [-]+")
(local startup-time-file (or (and (io.open startup-file)
                                  (: (io.open startup-file) :read :*a))
                             nil))

(local startup-time (or (and startup-time-file
                             (tonumber (startup-time-file:match startup-time-pattern)))
                        nil))

(var text "")
(if (and startup-time (>= startup-time 1000))
    (set text
         (string.format "Nyoom loaded %d packages in %.1fs (%d packages & modules cached)"
                        load-counter (* startup-time 0.001) unload-counter))
    startup-time
    (set text (string.format "Nyoom loaded %d packages in %.1fms (%d packages & modules cached)"
                             load-counter (truncate startup-time 3)
                             unload-counter))
    (set text (string.format "Nyoom loaded %d packages (%d packages & modules cached)"
                             load-counter unload-counter)))

(: (io.open startup-file :w) :close)
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
                       ;; :val startup-message
                       :val text
                       :opts {:position :center :hl :alpha3}}})

(setup :alpha {:layout [{:type :padding :val 5}
                        options.header
                        {:type :padding :val 2}
                        options.buttons
                        {:type :padding :val 2}
                        options.footer]
               :opts {}})
