;; Sane defaults
(require :core.defs)
(require :core.maps)

;; Statusline
(require :utils.statusline)

;; load packer
(require :pack.pack)

;; load plugins in order
(when (= (vim.fn.filereadable (.. (vim.fn.stdpath :config)
                                  :/lua/packer_compiled.lua)) 1)
  (require :packer_compiled))

;; require custom parinfer plugin afterim :VimEnter, hence why parinfer-rust is added in /opt (we just use it to build the dylib)
(fn require-parinfer []
  (require :pack.parinfer))

(vim.api.nvim_create_augroup "parinfer" {:clear true})
(vim.api.nvim_create_autocmd :VimEnter {:callback require-parinfer :group "parinfer"})
