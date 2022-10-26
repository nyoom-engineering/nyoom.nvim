(import-macros {: nyoom-module-p! : autocmd!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (autoload :orgmode))

(setup {:org_default_notes_file "~/org/refile.org"
        :org_agenda_files ["~/org/**/*"]})

;; Load tablemode on org enter
(autocmd! VimEnter *.org '(vim.cmd.TableModeToggle))
