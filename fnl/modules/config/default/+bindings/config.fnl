(import-macros {: nyoom-module-p! : map! : let!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
(local leap (autoload :leap))
;; Set leader to space by default

(let! mapleader " ")
;; leap and friends

(leap.add_default_mappings)
(setup :flit)
;; easier command line mode + 

(map! [n] ";" ":" {:desc :vim-ex})
;; telescope

(nyoom-module-p! telescope
                 (do
                   (map! [n] :<leader><space> "<cmd>Telescope find_files<CR>"
                         {:desc "Find Files"})
                   (map! [n] :<leader>bb "<cmd>Telescope buffers<CR>"
                         {:desc :Buffers})
                   (map! [n] "<leader>:" "<cmd>Telescope commands<CR>"
                         {:desc :M-x})))

;; calendar

(nyoom-module-p! calendar
                 (map! [n] :<leader>oc
                       "<cmd>Calendar -frame=space -google_calendar<CR>"
                       {:desc "Open Google Calendar"}))
