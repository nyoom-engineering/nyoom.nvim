(local {: autoload} (require :core.lib.autoload))
(local {: setup} (autoload :nvim-tree))

(setup {:view {:side :left :width 40 :hide_root_folder false :adaptive_size true :float {:enable true :open_win_config {:relative "editor" :width 30 :height 30 :row 1 :col 1 :border "rounded"}}}
        :disable_netrw true
        :hijack_netrw true
        :hijack_cursor true
        :update_cwd true
        :git {:enable false :ignore true}
        :hijack_directories {:enable true :auto_open true}
        :actions {:open_file {:resize_window true}}
        :renderer {:indent_markers {:enable false}}})


