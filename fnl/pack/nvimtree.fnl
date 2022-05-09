(import-macros {: let!} :macros.option-macros)
(import-macros {: lazy-require!} :macros.package-macros)

(let! :g.nvim_tree_git_hl 1)
(let! :g.nvim_tree_add_trailing 0)
(let! :g.nvim_tree_highlight_opened_files 0)
(let! :g.nvim_tree_show_icons {:git 1 :folders 1 :files 1 :folder_arrows 1})
(let! :g.nvim_tree_icons {:default ""
                          :symlink ""
                          :git {:deleted ""
                                :ignored "◌"
                                :renamed "➜"
                                :staged "✓"
                                :unmerged ""
                                :unstaged "✗"
                                :untracked "★"}
                          :folder {:default ""
                                   :empty ""
                                   :empty_open ""
                                   :open ""
                                   :symlink ""
                                   :symlink_open ""
                                   :arrow_open ""
                                   :arrow_closed ""}})

(local {: setup} (lazy-require! :nvim-tree))
(setup {:view {:side :left :width 25 :hide_root_folder true}
        :disable_netrw true
        :hijack_netrw true
        :hijack_cursor true
        :update_cwd true
        :git {:enable false :ignore true}
        :hijack_directories {:enable true :auto_open true}
        :actions {:open_file {:resize_window true}}
        :renderer {:indent_markers {:enable false}}})


