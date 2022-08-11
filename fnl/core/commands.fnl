(import-macros {: command!} :macros.command-macros)

;; Scratch
(command! Scratch "new | setlocal bt=nofile bh=wipe nobl noswapfile")
(command! SetScratch "edit [Scratch] | setlocal bt=nofile bh=wipe nobl noswapfile")

(fn nyoom-package [command]
  (import-macros {: packadd! : use-package! : unpack!} :macros.package-macros)
  (packadd! packer.nvim)
  (let [packer (require :packer)]
     (packer.reset)
     (packer.init {:git {:clone_timeout 300}
                   :profile {:enable true}
                   :compile_path (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")
                   :display {:header_lines 2
                             :title " packer.nvim"
                             :open_fn (λ open_fn []
                                        (local {: float} (require :packer.util))
                                        (float {:border :solid}))}})
  
     ;; TODO add package docs 
     (use-package! :miversen33/import.nvim)
     (use-package! :wbthomason/packer.nvim {:opt true})
     (use-package! :rktjmp/hotpot.nvim {:branch :nightly})
     ;; (use-package! :udayvir-singh/tangerine.nvim)
     (use-package! :nvim-lua/plenary.nvim {:module :plenary})
     (include :fnl.modules)
     (include :fnl.packages)
     (. packer ,command)))

(command! PackerSync '(nyoom-package :sync))
