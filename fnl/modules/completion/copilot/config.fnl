(import-macros {: packadd! : map!} :macros)
(local {: autoload} (require :core.lib.autoload))

(packadd! copilot.lua)
(local copilot (autoload :copilot))
(local client (autoload :copilot-client))

(copilot.setup) {:cmp {:enabled false}}
(client.setup) {:mapping {:accept :<CR>}}

(vim.api.nvim_set_keymap :i :<C-c>
                         "<cmd>lua require(\"copilot-client\").suggest()<CR>"
                         {:noremap true :silent true})

(map! [i] :<C-c> "<cmd>lua require(\"copilot-client\").suggest()<CR>" {:noremap true :silent true})
