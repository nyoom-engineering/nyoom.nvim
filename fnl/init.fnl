(require-macros :macros.event-macros)
(import-macros {: colorscheme} :macros.highlight-macros)

;; disable some built-in Neovim plugins and unneeded providers
(let [built-ins [:gzip
                 :zip
                 :zipPlugin
                 :tar
                 :tarPlugin
                 :getscript
                 :getscriptPlugin
                 :vimball
                 :vimballPlugin
                 :2html_plugin
                 :matchit
                 :matchparen
                 :logiPat
                 :rrhelper
                 :netrw
                 :netrwPlugin
                 :netrwSettings
                 :netrwFileHandlers]
      providers [:perl :node :ruby :python :python3]]
  (each [_ v (ipairs built-ins)]
    (let [plugin (.. :loaded_ v)]
      (tset vim.g plugin 1)))
  (each [_ v (ipairs providers)]
    (let [provider (.. :loaded_ v :_provider)]
      (tset vim.g provider 0))))

;; make sure packer is all ready to go
(let [compiled? (= (vim.fn.filereadable (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")) 1)
      load-compiled #(require :packer_compiled)]
 (if compiled?
     (load-compiled)
     (. (require :packer) :sync)))

;; function to use cargo to compile compile fnl/oxocarbon/ -> colors/oxocarbon.so syncronously
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

;; core
(require :core)

;; colorscheme
(require :oxocarbon)

;; statusline
(require :utils.statusline)

;; load plugins
(require :pack.pack)



