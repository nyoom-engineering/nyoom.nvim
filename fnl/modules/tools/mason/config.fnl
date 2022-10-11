(import-macros {: nyoom-module-p!} :macros)

;; Init mason
(local {: setup} (require :mason))
(setup {:ui {:border :solid}})

(local mason-tools [])

;; language servers
(nyoom-module-p! tree-sitter
  (do
    ;; (nyoom-module-p! cc
    ;;   (table.insert mason-tools :clangd))

    (nyoom-module-p! clojure
      (table.insert mason-tools :clojure-lsp))

    (nyoom-module-p! java
      (table.insert mason-tools :jdtls))

    (nyoom-module-p! json
      (table.insert mason-tools :json-lsp))

    (nyoom-module-p! xml
      (table.insert mason-tools :lemminx))

    ;; (nyoom-module-p! julia
    ;;   (table.insert mason-tools :julia-lsp))
    ;;
    ;; (nyoom-module-p! kotlin
    ;;   (table.insert mason-tools :kotlin-language-server))
    ;;
    ;; (nyoom-module-p! latex
    ;;   (table.insert mason-tools :texlab))
    ;;
    ;; (nyoom-module-p! lua
    ;;   (table.insert mason-tools :lua-language-server))
    ;;
    ;; (nyoom-module-p! markdown
    ;;   (table.insert mason-tools :marksman))
    ;;
    ;; (nyoom-module-p! nim
    ;;   (table.insert mason-tools :nimlsp))
    ;;
    ;; (nyoom-module-p! nix
    ;;   (table.insert mason-tools :rnix-lsp))

    (nyoom-module-p! python
      (table.insert mason-tools :pyright))

    ;; (nyoom-module-p! rust
    ;;   (table.insert mason-tools :rust-analyzer))

    (nyoom-module-p! sh
      (table.insert mason-tools :bash-language-server))))

    ;; (nyoom-module-p! zig
    ;;   (table.insert mason-tools :zls))
    

;; formatters
(nyoom-module-p! format
  (do
    (nyoom-module-p! cc
      (table.insert mason-tools :clang-format))

    (nyoom-module-p! lua
      (table.insert mason-tools :stylua))

    (nyoom-module-p! markdown
      (table.insert mason-tools :prettier))

    (nyoom-module-p! python
      (table.insert mason-tools :yapf))

    (nyoom-module-p! sh
      (table.insert mason-tools :shfmt))))


(nyoom-module-p! syntax
  (do
    (nyoom-module-p! lua
      (table.insert mason-tools :selene))

    (nyoom-module-p! python
      (table.insert mason-tools :pylint))))


(nyoom-module-p! debugger
  (do
    (nyoom-module-p! cc
      (table.insert mason-tools :codelldb))

    (nyoom-module-p! python
      (table.insert mason-tools :debugpy))

    (nyoom-module-p! rust
      (table.insert mason-tools :codelldb))))

(vim.cmd (.. "MasonInstall " (table.concat mason-tools " ")))
