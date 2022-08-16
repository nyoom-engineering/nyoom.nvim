(import-macros {: packadd! : pack : rock : use-package! : rock! : unpack! : echo!} :macros)

;; Load packer
(echo! "Loading Packer")
(packadd! packer.nvim)

;; include modules
(echo! "Compiling Module")
(include :fnl.modules)

;; Setup packer
(echo! "Initiating Packer")
(let [packer (require :packer)]
   (packer.init {:git {:clone_timeout 300}
                 :compile_path (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")
                 :display {:header_lines 2
                           :title " packer.nvim"
                           :open_fn (λ open_fn []
                                      (local {: float} (require :packer.util))
                                      (float {:border :solid}))}}))

;; Core packages
(use-package! :wbthomason/packer.nvim {:opt true})
(use-package! :nvim-lua/plenary.nvim {:module :plenary})

;; User plugins
(echo! "Loading User Plugins")
;; put any packages you want here
;; (use-pakage! ...)

;; Send plugins to packer
(echo! "Installing Plugins")
(unpack!)
