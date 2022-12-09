(local {: autoload} (require :core.lib.autoload))
(local {: nil?} (autoload :core.lib))
(local config (autoload :lspconfig))
(local {:report_start report-start!
        :report_info report-info!
        :report_ok report-ok!
        :report_warn report-warn!
        :report_error report-error!} vim.health)

(λ executable? [command]
  (= 1 (vim.fn.executable command)))

(λ report! [name]
  (assert (= :string (type name)) "expected string for name")
  (let [command (?. config name :cmd 1)]
    (if (nil? command)
        (report-warn! (string.format "**%s**: the command is not defined." name))
        (executable? command)
        (report-ok! (string.format "**%s**: the command '_%s_' is executable."
                                   name command))
        (report-error! (string.format "**%s**: the command '_%s_' is not executable."
                                      name command)))))

(λ check! []
  (report-start! "LSP server executables")
  (let [configured-servers (config.available_servers)
        configured-servers (doto configured-servers (table.sort))]
    (if (= 0 (length configured-servers))
        (report-info! "no lsp servers have been configured.")
        (each [_ server (ipairs configured-servers)]
          (report! server)))))

{:check check!}
