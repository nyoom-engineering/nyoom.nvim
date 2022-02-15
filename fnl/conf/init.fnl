;; Nyoom core is loaded first
(require :conf.modules.core)

;; User config is loaded second
(require :conf.config)

;; packer config is loaded last
(require :conf.pack)

