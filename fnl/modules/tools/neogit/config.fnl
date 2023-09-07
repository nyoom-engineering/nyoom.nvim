(import-macros {: augroup! : autocmd! : local-set!} :macros)

(setup :neogit {:disable_signs false
                :disable_hint true
                :disable_context_highlighting false
                :disable_builtin_notifications true
                :status {:recent_commit_count 10}
                :signs {:section ["" ""]
                        :item ["" ""]
                        :hunk ["" ""]}
                :integrations {:diffview true}
                :sections {:recent {:folded false}}
                :mappings {:status {:B :BranchPopup}}})

(augroup! neogit-config (autocmd! FileType Neogit* `(local-set! nolist))
          (autocmd! [FileType BufEnter] NeogitCommitView
                    `(local-set! evenitignore+ :CursorMoved))
          (autocmd! BufLeave NeogitCommitView
                    `(local-set! evenitignore- :CursorMoved)))
