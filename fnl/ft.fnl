;; filetypes you want parsing for
(local treesitter-filetypes [:bash
                             :comment
                             :fennel
                             :help
                             :lua
                             :json
                             :html
                             :yaml
                             :make
                             :markdown
                             :markdown_inline
                             :nix
                             :regex
                             :toml])

;; language servers you want to auto-install/config
;; NOTE rust_analyzer & jdtls have their own plugins (see lang/)
;; sumneko_lua is already set up seperately
(local lsp-servers [:clojure_lsp
                    :jsonls
                    :lemminx
                    :jdtls
                    :pyright])

{: lsp-servers
 : treesitter-filetypes}
