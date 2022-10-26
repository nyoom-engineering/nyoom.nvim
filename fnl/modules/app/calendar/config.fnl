(import-macros {: let!} :macros)

;; follow the steps in https://github.com/itchyny/calendar.vim to set up your secrets
(vim.cmd.source "~/.cache/calendar.vim/credentials.vim")

;; load google calendar
(let! calendar_google_calendar 1)
(let! calendar_google_task 1)
