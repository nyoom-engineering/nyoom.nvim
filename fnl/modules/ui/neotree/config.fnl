(import-macros {: let!} :macros)
(local {: setup} (require :core.lib.setup))

(let! neo_tree_remove_legacy_commands 1)

(setup :neo-tree
       {:popup_border_style :solid
        :window {:position :left :width 25}
        :filesystem {:use_libuv_file_watcher true}
        :default_component_configs {:indent {:with_markers false}
                                    :git_status {:symbols {:deleted ""
                                                           :renamed "凜"
                                                           :untracked ""
                                                           :ignored ""
                                                           :unstaged ""
                                                           :staged ""
                                                           :conflict ""}}}})
