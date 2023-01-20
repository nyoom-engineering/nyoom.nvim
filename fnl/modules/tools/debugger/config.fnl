(import-macros {: packadd! : nyoom-module-p!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (autoload :core.lib.setup))
(local dap (autoload :dap))

(set dap.adapters.codelldb
     {:type :server
      :port "${port}"
      :executable {:command :codelldb :args [:--port "${port}"]}})

(local lldb-configs
       [{:name "lldb: Launch (console)"
         :type :codelldb
         :request :launch
         :program (fn []
                    (vim.fn.input "Path to executable: "
                                  (.. (vim.fn.getcwd) "/") :file))
         :cwd "${workspaceFolder}"
         :stopOnEntry true}
        {:name "lldb: Launch (integratedTerminal)"
         :type :codelldb
         :request :launch
         :program (fn []
                    (vim.fn.input "Path to executable: "
                                  (.. (vim.fn.getcwd) "/") :file))}])

(local coreclr-configs
       [{:name "netcoredbg"
         :type :coreclr
         :request :launch
         :program (fn []
                    (vim.fn.input "Path to executable: "
                                  (.. (vim.fn.getcwd) "/bin/Debug/" :file)))}])
       

(nyoom-module-p! cc
                 (do
                   (set dap.configurations.c lldb-configs)
                   (set dap.configurations.c dap.configurations.cpp)))

(nyoom-module-p! csharp 
                 (do
                   (set dap.configurations.cs coreclr-configs)
                   (set dap.adapters.coreclr {:type :executable
                                              :command "/usr/local/bin/netcoredbg/netcoredbg"
                                              :args ["--interpreter=vscode"]})))

(nyoom-module-p! rust (set dap.configurations.rust lldb-configs))

(nyoom-module-p! lua
                 (do
                   (packadd! one-small-step-for-vimkind)
                   (set dap.configurations.lua
                        [{:type :nlua
                          :request :attach
                          :name "Attach to running Neovim instance"}])
                   (set dap.adapters.nlua
                        (fn [callback config]
                          (callback {:type :server
                                     :host (or config.host :127.0.0.1)
                                     :port (or config.port 8086)})))))

(nyoom-module-p! python
                 (do
                   (packadd! nvim-dap-python)
                   (local python-debug-path "~/.virtualenvs/debugpy/bin/python")
                   (nyoom-module-p! mason
                                    (local python-debug-path
                                           "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"))
                   (setup :dap-python python-debug-path)))

(packadd! nvim-dap-ui)
(setup :dapui {:icons {:expanded "" :collapsed "" :current_frame ""}
               :controls {:icons {:pause ""
                                  :play "契"
                                  :step_into ""
                                  :step_over ""
                                  :step_out ""
                                  :step_back ""
                                  :run_last ""
                                  :terminate ""}}
               :floating {:border :single}})
