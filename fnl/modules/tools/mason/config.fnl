(import-macros {: nyoom-module-p!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))

;; Init mason

(local mason-tools [])
(setup :mason {:ui {:border :solid} :PATH :skip})

;; language servers

;; fnlfmt: skip
(nyoom-module-p! lsp
  (do
    (nyoom-module-p! cc
      (table.insert mason-tools :clangd))

    (nyoom-module-p! clojure
      (table.insert mason-tools :clojure-lsp))

    (nyoom-module-p! java
      (table.insert mason-tools :jdtls))

    (nyoom-module-p! julia
      (table.insert mason-tools :julia-lsp))

    (nyoom-module-p! kotlin
      (table.insert mason-tools :kotlin-language-server))

    (nyoom-module-p! latex
      (table.insert mason-tools :texlab))

    (nyoom-module-p! lua
      (table.insert mason-tools :lua-language-server))

    (nyoom-module-p! markdown
      (table.insert mason-tools :marksman))

    (nyoom-module-p! nim
      (table.insert mason-tools :nimlsp))

    (nyoom-module-p! nix
      (table.insert mason-tools :rnix-lsp))

    (nyoom-module-p! python
      (table.insert mason-tools :pyright))

    (nyoom-module-p! rust
      (table.insert mason-tools :rust-analyzer))

    (nyoom-module-p! sh
      (table.insert mason-tools :bash-language-server))

    (nyoom-module-p! zig
      (table.insert mason-tools :zls))))

;; formatters

;; fnlfmt: skip
(nyoom-module-p! format
  (do
    (nyoom-module-p! cc
      (table.insert mason-tools :clang-format))

    (nyoom-module-p! kotlin
      (table.insert mason-tools :ktlint))

    (nyoom-module-p! lua
      (table.insert mason-tools :stylua))

    (nyoom-module-p! markdown
      (table.insert mason-tools :markdownlint))

    (nyoom-module-p! python 
      (do
        (table.insert mason-tools :black)
        (table.insert mason-tools :isort)))

    (nyoom-module-p! rust
      (table.insert mason-tools :rustfmt))

    (nyoom-module-p! sh
      (table.insert mason-tools :shfmt))))

;; linters

;; fnlfmt: skip
(nyoom-module-p! diagnostics
  (do
    (nyoom-module-p! lua
      (table.insert mason-tools :selene))))

;; debugging

;; fnlfmt: skip
(nyoom-module-p! debugger
  (do
    (nyoom-module-p! cc
      (table.insert mason-tools :codelldb))

    (nyoom-module-p! python
      (table.insert mason-tools :debugpy))

    (nyoom-module-p! rust
      (table.insert mason-tools :codelldb))

    (nyoom-module-p! java
      (do
        (table.insert mason-tools :java-test)
        (table.insert mason-tools :java-debug-adapter)))))

(vim.cmd (.. "MasonInstall " (table.concat mason-tools " ")))
