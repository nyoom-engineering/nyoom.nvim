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
   (use-package! :wbthomason/packer.nvim {:opt true})
   (use-package! :rktjmp/hotpot.nvim {:branch :nightly})
   (use-package! :nvim-lua/plenary.nvim {:module :plenary})

   (include :fnl.modules)
   (include :fnl.packages)

   (packer.sync))
