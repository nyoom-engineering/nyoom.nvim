(local {: autoload} (require :core.lib.autoload))
(local {: setup} (autoload :nvim-tree))

(setup {:view {:side :left :width 25 :hide_root_folder true :adaptive_size true}
        :disable_netrw true
        :hijack_netrw true
        :hijack_cursor true
        :update_cwd true
        :git {:enable false :ignore true}
        :hijack_directories {:enable true :auto_open true}
        :actions {:open_file {:resize_window true}}
        :renderer {:indent_markers {:enable false}}})


