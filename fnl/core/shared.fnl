(local diagnostic-icons {:error "" :warning "" :info "" :hint ""})
(local userconfigs {})
(local lsp-servers {})
(local cmp-sources [])
(local mason-tools [])
(local formatters [])
(local linters [])
(local null-ls-sources [])

(fn add-language-server [server ?config]
  (tset lsp-servers server (or ?config {})))

(fn add-mason-tool [tool]
  (table.insert mason-tools tool))

(fn add-formatter [formatter]
  (table.insert formatters formatter))

(fn add-linter [linter]
  (table.insert linters linter))

{: diagnostic-icons
 : userconfigs
 : lsp-servers
 : null-ls-sources
 : formatters
 : linters
 : cmp-sources
 : mason-tools
 : add-language-server
 : add-mason-tool
 : add-formatter
 : add-linter}
