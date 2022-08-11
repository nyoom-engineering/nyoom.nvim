(import-macros {: command!} :macros.command-macros)

(command! Scratch "new | setlocal bt=nofile bh=wipe nobl noswapfile")
(command! SetScratch "edit [Scratch] | setlocal bt=nofile bh=wipe nobl noswapfile")

;; load plugins
(command! PackerSync "lua require 'pack.pack' require('packer').sync()")
(command! PackerStatus "lua require 'pack.pack' require('packer').status()")
(command! PackerInstall "lua require 'pack.pack' require('packer').install()")
(command! PackerUpdate "lua require 'pack.pack' require('packer').update()")
(command! PackerCompile "lua require 'pack.pack' require('packer').compile()")

