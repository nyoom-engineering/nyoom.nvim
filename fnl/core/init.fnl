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

;; load commands
(require :core.commands)

;; add Mason to path. This replaces the need to load mason at startup 
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))

;; load packer if its available
(if (= (vim.fn.filereadable (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")) 1)
  (require :packer_compiled))

;; userconfig
(require :config)

