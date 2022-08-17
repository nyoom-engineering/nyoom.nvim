(import-macros {: nyoom-module-p!} :macros)

;; Init mason
(local {: setup} (require :mason))
(setup {:ui {:border :solid}})

(local mason-tools [:lua-language-server])

(nyoom-module-p! lang.java
  (table.insert mason-tools :jdtls))

(nyoom-module-p! lang.julia
  (table.insert mason-tools :julia-lsp))

(nyoom-module-p! lang.markdown
  (table.insert mason-tools :marksman))

(nyoom-module-p! lang.nix
  (table.insert mason-tools :rnix-lsp))

(nyoom-module-p! lang.rust
  (table.insert mason-tools :rust-analyzer))

(nyoom-module-p! lang.sh
  (table.insert mason-tools :bash-language-server))

(vim.cmd (.. "MasonInstall " (table.concat mason-tools " ")))
