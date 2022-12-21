(import-macros {: nyoom-package-count! : nyoom-module-count!} :macros)

(local {: autoload} (require :core.lib.autoload))
(local {: truncate} (autoload :core.lib))
(local {: setup} (autoload :core.lib.setup))

(local package-counter (nyoom-package-count!))
(local module-counter (nyoom-module-count!))

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
    (set text (string.format "Nyoom loaded %d packages across %d modules in %.1fs"
                             package-counter module-counter
                             (* startup-time 0.001)))
    startup-time
    (set text (string.format "Nyoom loaded %d packages across %d modules in %.1fms"
                             package-counter module-counter
                             (truncate startup-time 3)))
    (set text (string.format "Nyoom loaded %d packages across %d modules"
                             package-counter module-counter)))

(: (io.open startup-file :w) :close)

;; setup alpha

(fn button [sc txt keybind keybind-opts]
  (let [sc- (: (sc:gsub "%s" "") :gsub :SPC :<leader>)
        opts {:position :center
              :shortcut sc
              :cursor 5
              :width 50
              :align_shortcut :right
              :hl :helpSpecial
              :hl_shortcut :String}]
    (when keybind
      (set opts.keymap
           [:n sc- keybind {:noremap true :silent true :nowait true}]))

    (fn on-press []
      (let [key (vim.api.nvim_replace_termcodes (or keybind (.. sc- :<Ignore>))
                                                true false true)]
        (vim.api.nvim_feedkeys key :t false)))

    {:type :button :val txt :on_press on-press : opts}))

(local sections
       {:header {:type :text
                 :val ["=================     ===============     ===============   ========  ========"
                       "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //"
                       "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||"
                       "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||"
                       "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||"
                       "|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||"
                       "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||"
                       "|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||"
                       "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||"
                       "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||"
                       "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||"
                       "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||"
                       "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||"
                       "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||"
                       "||   .=='    _-'          `-__\\._-'         `-_./__-'         `' |. /|  |   ||"
                       "||.=='    _-'                                                     `' |  /==.||"
                       "=='    _-'                   N Y O O M  N E O V I M                   \\/   `=="
                       "\\   _-'                                                                `-_   /"
                       " `''                                                                      ``'  "]
                 :opts {:position :center :hl :Comment}}
        :buttons {:type :group
                  :val [(button "SPC q l" "  Reload last session"
                                ":Telescope find_files <CR>")
                        (button "SPC o A" "  Open agenda"
                                ":Telescope oldfiles<CR>")
                        (button "SPC f r" "  Recently opened files"
                                ":Telescope oldfiles<CR>")
                        (button "SPC p p" "  Open project" ":<CR>")
                        (button "SPC RET" "  Jump to bookmark"
                                ":Telescope marks<CR>")
                        (button "SPC f P" "  Open private configuration"
                                ":Telescope keymaps<CR>")
                        (button "SPC h d h" "  Open documentation"
                                ":Telescope keymaps<CR>")]
                  :opts {:spacing 1}}
        :footer {:type :text :val text :opts {:position :center :hl :Comment}}
        :icon {:type :button
               :val "ﯙ"
               :opts {:position :center :hl :Decorator}
               :on_press (fn []
                           (if (= (vim.fn.has :mac) 1)
                               (os.execute "open https://github.com/nyoom-engineering/nyoom.nvim")
                               (os.execute "xdg-open https://github.com/nyoom-engineering/nyoom.nvim")))}})

(setup :alpha {:layout [{:type :padding :val 4}
                        sections.header
                        {:type :padding :val 2}
                        sections.buttons
                        {:type :padding :val 2}
                        sections.footer
                        {:type :padding :val 1}
                        sections.icon]})
