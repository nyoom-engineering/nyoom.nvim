;; Speed up Neovim
(require :core.optimise-builtins)

;; Set vim options
(require :core.options)

;; Mappings
(require :core.keymaps)

;; load packer
(require :pack.pack)

;; load plugins in order
(when (= (vim.fn.filereadable (.. (vim.fn.stdpath :config)
                                  :/lua/packer_compiled.lua)) 1)
  (require :packer_compiled))

;; Colorscheme
(require :core.highlights)

;; Statusline
(require :utils.statusline)

;; require custom parinfer plugin afterim :VimEnter, hence why parinfer-rust is added in /opt (we just use it to build the dylib)
(fn require-parinfer []
  (require :pack.parinfer))

(vim.api.nvim_create_augroup "parinfer" {:clear true})
(vim.api.nvim_create_autocmd :VimEnter {:callback require-parinfer :group "parinfer"})
