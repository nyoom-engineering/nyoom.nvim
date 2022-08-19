(import-macros {: packadd! : nyoom-module-p!} :macros)
(local dap (require :dap))

;; lua setup
(nyoom-module-p! lang.lua
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

(packadd! nvim-dap-ui)
(local {: ui-setup} (require :dapui))
(ui-setup)

