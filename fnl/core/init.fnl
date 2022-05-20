;; Speed up Neovim
(require :core.optimise-builtins)

;; Set vim options
(require :core.options)

;; Mappings
(require :core.keymaps)

;; Autocommands
(require :core.events)

;; Colorscheme
(require :core.highlights)

;; Statusline
(require :utils.statusline)

;; load packer
(require :pack.pack)

;; load plugins in order
(when (= (vim.fn.filereadable (.. (vim.fn.stdpath :config)
                                  :/lua/packer_compiled.lua)) 1)
  (require :packer_compiled))
