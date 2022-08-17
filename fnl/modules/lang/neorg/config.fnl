(import-macros {: nyoom-module-p!} :macros)
(local {: setup} (require :neorg))

(setup {:load {:core.defaults {}
               :core.norg.qol.toc {}
               :core.norg.concealer {}
               :core.gtd.base {:config {:workspace :main}}
               :core.norg.completion {:config {:engine :nvim-cmp}}
               :core.norg.dirman {:config {:workspaces {:main "~/org/neorg"}
                                           :autodetect true
                                           :autochdir true}}}})

(nyoom-module-p! config.literate
  (do
    (fn tangle-config []
      (let [literatefile (.. (vim.fn.stdpath :config) "/fnl/config.norg")]
        (vim.cmd.Neorg (.. "tangle" literatefile))))
    (let [uv vim.loop]
      (let [handle (uv.new_fs_event)
            path (vim.fn.expand "~/.config/nvim/fnl/config.norg")]
        (uv.fs_event_start handle path {} #(vim.schedule tangle-config))
        (vim.api.nvim_create_autocmd :VimLeavePre {:callback #(uv.close handle)})))))
