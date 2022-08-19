(fn tangle-config []
  (let [literatefile (.. (vim.fn.stdpath :config) "/fnl/config.norg")]
    (vim.cmd.Neorg (.. "tangle" literatefile))))
(let [uv vim.loop]
  (let [handle (uv.new_fs_event)
        path (vim.fn.expand "~/.config/nvim/fnl/config.norg")]
    (uv.fs_event_start handle path {} #(vim.schedule tangle-config))
    (vim.api.nvim_create_autocmd :VimLeavePre {:callback #(uv.close handle)})))
