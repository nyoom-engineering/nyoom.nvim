(import-macros {: packadd! : nyoom-module-p!} :macros)
(local dap (require :dap))

;; lua setup
(nyoom-module-p! cc
  (do
    (set dap.configurations.cpp
         [{:program (fn []
                      (vim.fn.input "Path to executable: " (.. (vim.fn.getcwd) "/")
                                    :file))
           :stopOnEntry false
           :request :launch
           :type :lldb
           :args {}
           :name :Launch
           :cwd "${workspaceFolder}"}])
    (set dap.adapters.lldb {:type :executable
                            :command :lldb-vscode
                            :name :lldb})
    (set dap.configurations.c dap.configurations.cpp)))

(nyoom-module-p! lua
  (do
    (packadd! one-small-step-for-vimkind)
    (set dap.configurations.lua [{:host (fn []
                                          (local value
                                                 (vim.fn.input "Host [127.0.0.1]: "))
                                          (when (not= value "")
                                            (lua "return value"))
                                          :127.0.0.1)
                                  :name "Attach to running Neovim instance"
                                  :request :attach
                                  :port (fn []
                                          (local val
                                                 (tonumber (vim.fn.input "Port: ")))
                                          (assert val
                                                  "Please provide a port number")
                                          val)
                                  :type :nlua}])
    (set dap.adapters.nlua (fn [callback config]
                             (callback {:port config.port
                                        :type :server
                                        :host config.host})))))

(nyoom-module-p! python
   (do
     (packadd! nvim-dap-python)
     ((. (require :dap-python) :setup) "~/.virtualenvs/debugpy/bin/python")))

(packadd! nvim-dap-ui)
(local {: setup} (require :dapui))
(setup)

