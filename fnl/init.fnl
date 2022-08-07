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

;; add Mason to path
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))

;; only load packer if you need to sync it
(let [compiled? (= (vim.fn.filereadable (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")) 1)
      load-compiled #(require :packer_compiled)]
 (if compiled?
     (load-compiled))
 (when (not compiled?)
     (require :pack.pack)
     (. (require :packer) :sync)))

;; core
(require :core)

;; statusline
(require :utils.statusline)

;; colorscheme
(colorscheme oxocarbon)


