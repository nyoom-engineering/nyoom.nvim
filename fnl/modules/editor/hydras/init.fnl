(import-macros {: use-package! : load-module} :macros.package-macros)

(use-package! :anuvyklack/hydra.nvim {:keys :<space> :config (load-module editor.hydras)})
