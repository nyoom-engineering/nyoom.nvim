;; Speed up Neovim
(require :core.optimise-builtins)

;; Set vim options
(require :core.options)

;; Autocommands
(require :core.events)

;; Colorscheme
(require :core.highlights)

;; Statusline
(require :utils.statusline)

;; load packer
(require :pack.pack)

;; Mappings. Needs to be loaded after plugins as it depends on which-key
(require :core.keymaps)

