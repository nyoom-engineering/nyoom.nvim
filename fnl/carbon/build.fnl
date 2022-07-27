(require-macros :macros.event-macros)

;; function to compile fnl/carbon/carbon.fnl -> colors/carbon.lua
(fn build-colorscheme []
  (let [{: build} (require :hotpot.api.make)
        allowed-globals (icollect [n _ (pairs _G)] n)
        opts {:verbosity 0
              :compiler {:modules {:allowedGlobals allowed-globals}}}]
    (build (vim.fn.stdpath :config) 
           {:verbosity 0}
           (.. (vim.fn.stdpath :config)
               :/fnl/carbon/carbon.fnl)
           (fn []
             (.. (vim.fn.stdpath :config)
                 :/colors/carbon.lua)))))

;; watch carbon.fnl and compile on exit if its changed
(let [hotpot (require :hotpot)
      setup hotpot.setup
      build hotpot.api.make.build
      uv vim.loop]
  (setup {:compiler {:modules {:correlate true}}})
  (let [handle (uv.new_fs_event)
        path (vim.fn.expand (.. (vim.fn.stdpath :config) :/fnl/carbon/carbon.fnl))]
    (uv.fs_event_start handle path {} #(vim.schedule build-colorscheme))
    (autocmd! VimLeavePre * `(:callback #(uv.close handle)))))
