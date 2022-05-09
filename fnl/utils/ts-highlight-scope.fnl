(import-macros {: lazy-require!} :macros.package-macros)
(local ts-utils (lazy-require! :nvim-treesitter.ts_utils))
(local locals (lazy-require! :nvim-treesitter.locals))

(local ns (vim.api.nvim_create_namespace "ts-highlight-scope"))

(fn buf-augroup [buf]
  (string.format "ts-highlight-scope-%d" buf))

(fn highlight-char [buf pos hl-group]
  (vim.highlight.range buf ns hl-group pos pos {:inclusive true :priority 500}))

(fn highlight-ends [buf node]
  (let [(start-row start-col end-row end-col) (node:range)]
    (highlight-char buf [start-row start-col] :MatchParen)
    (highlight-char buf [end-row (+ -1 end-col)] :MatchParen)))

(fn clear-highlights [buf]
  (vim.api.nvim_buf_clear_namespace buf ns 0 -1))

(fn highlight-scope [buf]
  (clear-highlights buf)
  (let [cursor-node (ts-utils.get_node_at_cursor)
        scope (locals.containing_scope cursor-node buf)]
    (when (and scope (not= 0 (scope:start)))
      (highlight-ends buf scope))))

(fn attach [buf]
  (let [augroup (buf-augroup buf)]
    (vim.api.nvim_create_augroup augroup {:clear true})
    (vim.api.nvim_create_autocmd :CursorMoved
                                 {:buffer buf
                                  :group augroup
                                  :callback #(highlight-scope buf)})
    (vim.api.nvim_create_autocmd :BufLeave
                                 {:buffer buf
                                  :group augroup
                                  :callback #(clear-highlights buf)})))

(fn detach [buf]
  (clear-highlights buf)
  (vim.api.nvim_del_augroup_by_name (buf-augroup buf)))

{: attach : detach}
