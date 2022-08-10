(import-macros {: use-package! : load-module} :macros.package-macros)
(use-package! :nvim-neorg/neorg {:config (load-module app.neorg) :ft :norg :after :nvim-treesitter})


