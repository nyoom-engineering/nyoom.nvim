;; This file provides the macros used for loading and modifying nyoom modules. 

;; Each catagory of modules (e.g. ui) gets its own macro (nyoom-ui!) to require/load the modules within that catagory, Users can enable/disable modules within each catagory as they please. 

;; Ideally, we don't want users modifying the modules themselves for changes. This will cause merge conflicts and issues in the future. For that we provide the after! macro. (after! neorg (...)) would load ... code after neorg is loaded, letting the user override configs for lazy loaded (and currently loaded) plugins. Not sure how to go about this, since emacs handles it differenty. With neovim the user would have to override the whole setup() table, complicating things. We could go the userconfig route, but then I would become the very thing I swore to destroy!
