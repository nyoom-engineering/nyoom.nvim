(import-macros {: command!} :macros)

(command! Scratch "new | setlocal bt=nofile bh=wipe nobl noswapfile")
(command! SetScratch "edit [Scratch] | setlocal bt=nofile bh=wipe nobl noswapfile")

;; load plugins
(command! PackerSync "lua require 'pack' require('packer').sync()")
(command! PackerStatus "lua require 'pack' require('packer').status()")
(command! PackerInstall "lua require 'pack' require('packer').install()")
(command! PackerUpdate "lua require 'pack' require('packer').update()")
(command! PackerCompile "lua require 'pack' require('packer').compile()")
