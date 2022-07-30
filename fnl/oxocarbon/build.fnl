(require-macros :macros.event-macros)

;; function to use cargo to compile compile fnl/oxocarbon/ -> colors/oxocarbon.so
(fn build-oxocarbon []
  (os.execute (.. "cargo build -q --release --manifest-path=" 
                  (vim.fn.expand 
                    (.. (vim.fn.stdpath :config) 
                        :/fnl/oxocarbon/Cargo.toml))))
  (os.execute (.. "rm " 
                  (vim.fn.expand 
                    (.. (vim.fn.stdpath :config) 
                        :/lua/oxocarbon.so))))
  (os.execute (.. "mv " 
                 (vim.fn.expand 
                   (.. (vim.fn.stdpath :config) 
                       :/fnl/oxocarbon/target/release/liboxocarbon.dylib
                       (.. " " 
                           (.. (vim.fn.expand 
                                 (.. (vim.fn.stdpath :config) 
                                     :/lua/oxocarbon.so)))))))))

;; watch lib.rs and compile on exit if its changed
(let [hotpot (require :hotpot)
      setup hotpot.setup
      build hotpot.api.make.build
      uv vim.loop]
  (setup {:compiler {:modules {:correlate true}}})
  (let [handle (uv.new_fs_event)
        path (vim.fn.expand (.. (vim.fn.stdpath :config) :/fnl/oxocarbon/src/lib.rs))]
    (uv.fs_event_start handle path {} #(vim.schedule build-oxocarbon))
    (autocmd! VimLeavePre * `(:callback #(uv.close handle)))))
