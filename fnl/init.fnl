;; core 
(require :core)

;; load packer
(require :pack.pack)

;; Make sure packer is all ready to go
(let [compiled? (= (vim.fn.filereadable (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")) 1)
      load-compiled #(require :packer_compiled)]
 (if compiled?
     (load-compiled)
     (. (require :packer) :sync)))
