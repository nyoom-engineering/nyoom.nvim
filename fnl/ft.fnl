;; filetypes you want parsing for
(local treesitter-filetypes [:bash
                             :comment
                             :fennel
                             :help
                             :julia
                             :lua
                             :make
                             :markdown
                             :markdown_inline
                             :nix
                             :regex
                             :rust
                             :toml])

;; language servers you want to auto-install/config
;; NOTE rust_analyzer & jdtls have their own plugins (see lang/)
;; sumneko_lua is already set up seperately
(local lsp-servers [:clojure_lsp
                    :rnix
                    :pyright])

{: lsp-servers
 : treesitter-filetypes}
