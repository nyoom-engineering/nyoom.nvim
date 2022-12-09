(import-macros {: packadd!
                : pack
                : rock
                : use-package!
                : rock!
                : nyoom-init-modules!
                : nyoom-compile-modules!
                : unpack!
                : autocmd!} :macros)

(packadd! packer.nvim)
(local {: autoload} (require :core.lib.autoload))
(local {: build} (autoload :hotpot.api.make))
(local {: echo!} (autoload :core.lib.io))
(local {: init} (autoload :packer))

;; Load packer
(echo! "Loading Packer")
(local headless (= 0 (length (vim.api.nvim_list_uis))))
(init {:lockfile {:enable true
                  :path (.. (vim.fn.stdpath :config) :/lockfile.lua)}
       :compile_path (.. (vim.fn.stdpath :config) :/lua/packer_compiled.lua)
       :auto_reload_compiled false
       :display {:non_interactive headless}})

;; compile healthchecks
(echo! "Compiling Nyoom Doctor")
(build (vim.fn.stdpath :config) {:verbosity 0}
       (.. (vim.fn.stdpath :config) :/fnl/core/doctor.fnl)
       (fn []
         (.. (vim.fn.stdpath :config) :/lua/health.lua)))

;; include modules
(echo! "Initializing Module System")
(nyoom-init-modules!)

;; compile modules
(echo! "Compiling Nyoom Modules")
(nyoom-compile-modules!)

;; Core packages
(use-package! :EdenEast/packer.nvim {:opt true :branch :feat/lockfile})
(use-package! :nvim-lua/plenary.nvim {:module :plenary})

;; To install a package with Nyoom you must declare them here and run 'nyoom sync'
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

;; ---------------------
;; Put your plugins here
;; ---------------------

;; Send plugins to packer
(echo! "Installing Packages")
(unpack!)
