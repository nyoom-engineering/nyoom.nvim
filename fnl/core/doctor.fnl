;; WIP: use :checkhealth to display missing LSP executables

(local config (require :lspconfig))
(local {:report_start report-start!
        :report_info report-info!
        :report_ok report-ok!
        :report_warn report-warn!
        :report_error report-error!} vim.health)

(lambda spaces [amount]
  (table.concat (fcollect [i 0 amount]
                  " ") ""))

(lambda report! [name max-name-length]
  (assert (= :string (type name)) "expected string for name")
  (assert (= :number (type max-name-length))
          "expected number for max-name-length")
  (let [command (?. config name :cmd 1)
        spaces (spaces (- max-name-length (name:len)))]
    (if (nil? command)
        (report-warn! (string.format "%s %sthe command is not defined." spaces
                                     name))
        (executable? command)
        (report-ok! (string.format "%s %s`%s` is executable." name spaces
                                   command))
        (report-error! (string.format "%s %s`%s` is not executable." name
                                      spaces command)))))

(lambda check! []
  (report-start! "LSP server executables")
  (let [configured-servers (config.available_servers)
        configured-servers (doto configured-servers
                             (table.sort))
        max-name-length (accumulate [max 0 _ name (ipairs configured-servers)]
                          (if (> (name:len) max) (name:len) max))]
    (if (= 0 (length configured-servers))
        (report-info! "no lsp servers have been configured.")
        (each [_ server (ipairs configured-servers)]
          (report! server max-name-length)))))

{:check check!}
