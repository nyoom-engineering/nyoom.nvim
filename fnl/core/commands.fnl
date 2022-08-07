(import-macros {: command!} :macros.command-macros)

;; Scratch
(command! Scratch "new | setlocal bt=nofile bh=wipe nobl noswapfile")
(command! SetScratch "edit [Scratch] | setlocal bt=nofile bh=wipe nobl noswapfile")

;; Packer
(command! PackerCompile "lua require 'pack.pack' require('packer').compile()")
(command! PackerInstall "lua require 'pack.pack' require('packer').install()")
(command! PackerStatus "lua require 'pack.pack' require('packer').status()")
(command! PackerSync "lua require 'pack.pack' require('packer').sync()")
(command! PackerUpdate "lua require 'pack.pack' require('packer').update()")
