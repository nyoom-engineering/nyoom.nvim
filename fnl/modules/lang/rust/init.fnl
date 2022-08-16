(import-macros {: use-package!} :macros)

; view rust crate info with virtual text
(use-package! :saecki/crates.nvim {:call-setup crates
                                   :event ["BufRead Cargo.toml"]})

; inlay-hints + lldb + niceties for rust-analyzer
(use-package! :simrat39/rust-tools.nvim {:nyoom-module lang.rust
                                         :ft :rust}) 



