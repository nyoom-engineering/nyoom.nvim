(local {: adapters
        : configurations
        : listeners
        : toggle_breakpoint
        : continue} (require :dap))
(local {: open
        : close} (require :dapui))
;; (local hydra (require :hydra))


;; (local dap_hint (.. 
;;                  "  Breakpoint     \n"
;;                  "-----------------\n"
;;                  "_s_: add breakpoint\n"
;;                  "_r_: Run DAP"))

;; (hydra {:name "DAP"
;;         :hint dap_hint
;;         :config {:invoke_on_body true :hint {:border "rounded" :offset -1}}
;;         :mode "n"
;;         :body "<leader>d"
;;         :heads [["s" toggle_breakpoint]
;;                 ["r" continue]]})
        

(tset listeners.after :event_initialized :dapui_config open)
(tset listeners.before :event_terminated :dapui_config close)
(tset listeners.before :event_exited :dapui_config close)
(tset vim.g :dap_virtual_text true)

(vim.fn.sign_define :DapBreakpoint {:text "🟥" :texthl "" :linehl "" :numhl ""})
(vim.fn.sign_define :DapStopped {:text "⭐️" :texthl "" :linehl "" :numhl ""})

(tset adapters :node2 {:type "executable"
                       :command "node"
                       :args ["/Users/I074455/Projects/github.com/microsoft/vscode-node-debug2/out/src/nodeDebug.js"]})

(tset configurations :javascript [{:name "launch"
                                    :type "node2"
                                    :request "launch"
                                    ;; :program "${file}"
                                    :program "${file}"
                                    ;; :cwd (vim.fn.getcwd)
                                    :cwd (vim.fn.getcwd)
                                    :sourceMaps true
                                    :protocol "inspector"
                                    :console "integratedTerminal"}])
;; https://github.com/hvicente/dotfiles/blob/05a31fbc1c024a8a139ac0a9480852a9961376ea/eco_nvim/lua/plugins/dap.lua#L71
;; -- NODE / TYPESCRIPT
;; dap.adapters.node2 = {
;;                       type = 'executable';
;;                       command = os.getenv('HOME') .. '/.nvm/versions/node/v16.8.0/bin/node';
;;                       args = { os.getenv('HOME') .. '/debuggers/vscode-js-debug/out/src/debugServerMain.js'}};
;;
;;
;; -- Chrome
;; dap.adapters.chrome = {
;;                        type = 'executable',
;;                        command = 'node',
;;                        args = {os.getenv('HOME') .. '/debuggers/vscode-chrome-debug/out/src/chromeDebug.js'}}
;;
;;
;; -- Configurations
;; dap.configurations.javascript = {
;;                                  {
;;                                    type = 'node2';
;;                                    request = 'launch';
;;                                    program = '${file}';
;;                                    cwd = vim.fn.getcwd();
;;                                    sourceMaps = true;
;;                                    protocol = 'inspector';
;;                                    console = 'integratedTerminal'}};
;;   
;;
;;
;; dap.configurations.javascript = {
;;                                  {
;;                                      type = 'chrome',
;;                                      request = 'attach',
;;                                      program = '${file}',
;;                                      cwd = vim.fn.getcwd(),
;;                                      sourceMaps = true,
;;                                      protocol = 'inspector',
;;                                      port = 9222,
;;                                      webRoot = '${workspaceFolder}'}}
;;     
;;
;;
;; dap.configurations.javascriptreact = {
;;                                       {
;;                                           type = 'chrome',
;;                                           request = 'attach',
;;                                           program = '${file}',
;;                                           cwd = vim.fn.getcwd(),
;;                                           sourceMaps = true,
;;                                           protocol = 'inspector',
;;                                           port = 9222,
;;                                           webRoot = '${workspaceFolder}'}}
;;     
;;
;;
;; dap.configurations.typescriptreact = {
;;                                       {
;;                                           type = 'chrome',
;;                                           request = 'attach',
;;                                           program = '${file}',
;;                                           cwd = vim.fn.getcwd(),
;;                                           sourceMaps = true,
;;                                           protocol = 'inspector',
;;                                           port = 9222,
;;                                           webRoot = '${workspaceFolder}'}}
;;     
;;
