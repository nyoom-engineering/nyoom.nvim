(import-macros {: autocmd!} :macros)

(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))

(setup :orgmode {:org_default_notes_file "~/org/refile.org"
                 :org_agenda_files ["~/org/**/*"]})

;; Load tablemode on org enter

(autocmd! VimEnter *.org `(vim.cmd.TableModeToggle))
