(import-macros {: map! : let!} :macros)

;; Set leader to space by default
(let! mapleader " ")

;; Easier command-line mode
(map! [n] ";" ":")

;; Some keybindings stolen from doom
(map! [n] "<leader><space>" "<cmd>Telescope find_files<CR>")
(map! [n] "<leader>bb" "<cmd>Telescope buffers<CR>")
(map! [n] "<leader>:" "<cmd>Telescope commands<CR>")


;; >xiaobing add
;; Telescope
(map! [n] "<C-c><C-g>" "<cmd>Telescope ghq list<CR>")
(map! [n] "<leader>bb" "<cmd>Telescope buffers<CR>")
(map! [n] "<leader>pp" "<cmd>Telescope project<CR>")
(map! [n] "<leader>pf" "<cmd>Telescope file_browser<CR>")

;; Window
(map! [n] "<C-w><C-w>" "<cmd>lua require('nvim-window').pick()<CR>")

;; Explorer
(map! [n] "<leader>op" "<cmd>NvimTreeToggle<CR>")
(map! [n] "<leader>o-" "<cmd>NnnPicker %:p:h<CR>")

;; Terminal
(map! [n] "<leader>ot" "<cmd>exe v:count1 . 'ToggleTerm'<cr>")
(map! [n] "<leader>oT" "<cmd>ToggleTerm  direction=tab<cr>")

;; Search
(map! [n] "<leader>sb" "<cmd>Telescope current_buffer_fuzzy_find<cr>")
(map! [n] "<leader>sp" "<cmd>Telescope live_grep<cr>")

;; Git
(map! [n] "<leader>gg" "<cmd>ToggleLazygit<cr>")

;; WIndow
(map! [in] "<C-x>0" "<cmd>bd<cr>")
(map! [in] "<C-x>1" "<cmd>only<cr>")
;; <
;; hotpot fun
(local reflect-session {:id nil :mode :compile})
(fn new-or-attach-reflect []
  (let [reflect (require :hotpot.api.reflect)
        with-session-id (if reflect-session.id
                          (fn [f]
                            (f reflect-session.id))
                          (fn [f]
                            (let [buf (vim.api.nvim_create_buf true true)
                                  id (reflect.attach-output buf)]
                              (set reflect-session.id id)
                              (f id)
                              (vim.schedule #(do
                                               (vim.api.nvim_command "botright vnew")
                                               (vim.api.nvim_win_set_buf (vim.api.nvim_get_current_win) buf)
                                               (vim.api.nvim_create_autocmd :BufWipeout
                                                                        {:buffer buf
                                                                         :once true
                                                                         :callback #(set reflect-session.id nil)}))))))]
    (with-session-id (fn [session-id]
                       (reflect.set-mode session-id reflect-session.mode)
                       (reflect.attach-input session-id 0)))))

(vim.keymap.set :v :hr new-or-attach-reflect)

(fn swap-reflect-mode []
  (let [reflect (require :hotpot.api.reflect)]
    (when reflect-session.id
      (if (= reflect-session.mode :compile)
        (set reflect-session.mode :eval)
        (set reflect-session.mode :compile))
      (reflect.set-mode reflect-session.id reflect-session.mode))))


(map! [n] "<space>hr" '(new-or-attach-reflect))
(map! [n] "<space>hx" '(swap-reflect-mode))
