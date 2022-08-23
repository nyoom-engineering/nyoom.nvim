(import-macros {: nyoom-module-p! : autocmd!} :macros)
(local {: setup} (require :orgmode))

(nyoom-module-p! tree-sitter
  ((. (require :orgmode) :setup_ts_grammar)))

(setup {:org_default_notes_file "~/org/refile.org"
        :org_agenda_files ["~/org/**/*"]})

;; Load tablemode on org enter
(autocmd! VimEnter *.org '(vim.cmd.TableModeToggle))
