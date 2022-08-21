(import-macros {: nyoom-module-p!} :macros)

;; Init mason
(local {: setup} (require :mason))
(setup {:ui {:border :solid}})

(local mason-tools [])

;; language servers
(nyoom-module-p! tree-sitter
  (do
    (nyoom-module-p! java
      (table.insert mason-tools :jdtls))

    (nyoom-module-p! julia
      (table.insert mason-tools :julia-lsp))

    (nyoom-module-p! lua
      (table.insert mason-tools :lua-language-server))

    (nyoom-module-p! markdown
      (table.insert mason-tools :marksman))

    (nyoom-module-p! nix
      (table.insert mason-tools :rnix-lsp))

    (nyoom-module-p! rust
      (table.insert mason-tools :rust-analyzer))

    (nyoom-module-p! sh
      (table.insert mason-tools :bash-language-server))))

;; formatters
(nyoom-module-p! format
  (do
    (nyoom-module-p! lua
      (table.insert mason-tools :stylua))

    (nyoom-module-p! markdown
      (table.insert mason-tools :prettier))

    (nyoom-module-p! sh
      (table.insert mason-tools :shfmt))))


(nyoom-module-p! syntax
  (do
    (nyoom-module-p! lua
      (table.insert mason-tools :selene))))


(nyoom-module-p! debugger
  (do
    (nyoom-module-p! rust
      (table.insert mason-tools :codelldb))))

(vim.cmd (.. "MasonInstall " (table.concat mason-tools " ")))
