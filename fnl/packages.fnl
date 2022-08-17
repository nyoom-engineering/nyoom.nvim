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

;;; fnl/packages.fnl

;; To install a package with Doom you must declare them here and run 'nyoom sync'
;; on the command line, then restart nvim for the changes to take effect
;; The syntax is as follows: 

;; (use-package! :username/repo {:opt true
;;                               :defer reponame-to-defer
;;                               :call-setup pluginname-to-setup
;;                               :cmd [:cmds :to :lazyload]
;;                               :event [:events :to :lazyload]
;;                               :ft [:ft :to :load :on]
;;                               :requires [(pack :plugin/dependency)]
;;                               :run :commandtorun
;;                               :as :nametoloadas
;;                               :branch :repobranch
;;                               :setup (fn [])
;;                                        ;; same as setup with packer.nvim)})
;;                               :config (fn [])})
;;                                        ;; same as config with packer.nvim)})


;; User plugins
(echo! "Loading User Plugins")

;; ---------------------
;; Put your plugins here
;; ---------------------

;; Send plugins to packer
(echo! "Installing Plugins")
(unpack!)
