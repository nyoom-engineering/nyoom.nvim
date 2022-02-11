;; This configuration is modular. Each group of configuration (mappings, settings, packages) is in its own file. This file loads the other 3.

;; require vim settings
(require :conf.config)
;; require mappings
(require :conf.maps)
;; require plugins
(require :conf.pack)
