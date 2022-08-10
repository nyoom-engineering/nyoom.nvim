(import-macros {: use-package! : call-setup : load-module} :macros.package-macros)

(use-package! :saecki/crates.nvim {:event ["BufRead Cargo.toml"] :config (call-setup crates)})
(use-package! :simrat39/rust-tools.nvim {:ft :rust :branch :modularize_and_inlay_rewrite :config (load-module lang.rust)}) 
