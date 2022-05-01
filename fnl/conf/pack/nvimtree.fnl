(import-macros {: let!} :conf.macros)
(local {: setup} (require :nvim-tree))

(let! nvim_tree_show_icons {:git 0 :folders 1 :files 0 :folder_arrows 0})

(setup {:view {:width 30 :side :left :hide_root_folder true}
        :hijack_cursor true
        :update_cwd true
        :renderer {:indent_markers {:enable true}
                   :icons {:webdev_colors false}}
        :hijack_directories {:enable true :auto_open true}})

