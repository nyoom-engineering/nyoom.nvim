(import-macros {: map!} :macros.keybind-macros)
(import-macros {: let!} :macros.variable-macros)

;; set leader key
(let! mapleader " ")
(let! maplocalleader " m")

;; Disable highlight on escape
(map! [n] "<esc>" "<esc><cmd>noh<cr>")

;; Easier command-line mode
(map! [n] ";" ":")

;; Some keybindings stolen from doom
(map! [n] "<leader><space>" "<cmd>Telescope find_files<CR>")
(map! [n] "<leader>bb" "<cmd>Telescope buffers<CR>")
(map! [n] "<leader>:" "<cmd>Telescope commands<CR>")

(local reflect-session {:id nil :mode :compile})
(fn new-or-attach-reflect []
  (let [reflect (require :hotpot.api.reflect)
        with-session-id (if reflect-session.id
                          (fn [f]
                            ;; session id already exists, so we can just pass
                            ;; it to whatever needs it
                            (f reflect-session.id))
                          (fn [f]
                            ;; session id does not exist, so we need to create
                            ;; an output buffer first then we can pass the
                            ;; session id on, and finally hook up the output
                            ;; buffer to a window
                            (let [buf (vim.api.nvim_create_buf true true)
                                  id (reflect.attach-output buf)]
                              (set reflect-session.id id)
                              (f id)
                              ;; create window, which will forcibly assume focus, swap the buffer
                              ;; to our output buffer and setup an autocommand to drop the session id
                              ;; when the session window is closed.
                              (vim.schedule #(do
                                               (vim.api.nvim_command "botright vnew")
                                               (vim.api.nvim_win_set_buf (vim.api.nvim_get_current_win) buf)
                                               (vim.api.nvim_create_autocmd :BufWipeout
                                                                        {:buffer buf
                                                                         :once true
                                                                         :callback #(set reflect-session.id nil)}))))))]
    ;; we want to set the session mode to our current mode, and attach the
    ;; input buffer once we have a session id
    (with-session-id (fn [session-id]
                       ;; we manually set the mode each time so it is persisted if we close the session.
                       ;; By default `reflect` will use compile mode.
                       (reflect.set-mode session-id reflect-session.mode)
                       (reflect.attach-input session-id 0)))))

(vim.keymap.set :v :hr new-or-attach-reflect)

(fn swap-reflect-mode []
  (let [reflect (require :hotpot.api.reflect)]
    ;; only makes sense to do this when we have a session active
    (when reflect-session.id
      ;; swap held mode
      (if (= reflect-session.mode :compile)
        (set reflect-session.mode :eval)
        (set reflect-session.mode :compile))
      ;; tell session to use new mode
      (reflect.set-mode reflect-session.id reflect-session.mode))))
(vim.keymap.set :n :hx swap-reflect-mode)
