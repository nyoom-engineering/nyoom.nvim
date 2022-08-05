(local {: setup} (require :toggleterm))

(fn _G.set_terminal_keymaps []
 (vim.api.nvim_buf_set_keymap 0 :t :jk "<C-\\><C-n>" {:noremap true :silent true})
 (vim.api.nvim_buf_set_keymap 0 :t :<C-x> "<C-\\><C-n>:ToggleTerm<cr>" {:noremap true :silent true})
 (vim.api.nvim_buf_set_keymap 0 :t :<C-h> "<C-\\><C-n><C-W>h" {:noremap true :silent true})
 (vim.api.nvim_buf_set_keymap 0 :t :<C-j> "<C-\\><C-n><C-W>j" {:noremap true :silent true}))
 
(setup)
(vim.cmd "autocmd! TermEnter term://*toggleterm#* lua set_terminal_keymaps()")
(local Terminal (. (require :toggleterm.terminal) :Terminal))
(local lazygit (Terminal:new {:cmd :lazygit :dir "git_dir" :direction :float :hidden true}))
(local btop (Terminal:new {:cmd :btop :direction :float :hidden true}))
;; (local nnn (Terminal:new {:cmd :nnn :dir (vim.fn.expand "%:p:h") :direction :float :hidden true :env ["EDITOR:nvim"]}))
;; (local nnn (Terminal:new {:cmd :nnn :dir (vim.fn.expand "%:p:h") :direction :float :hidden true}))
;; (local nvim-headless (Terminal:new {:cmd "nvim --headless PlugSync" :hidden true}))
(local nbb (Terminal:new {:cmd "nbb nrepl-server :port 1337" :hidden true}))

(fn _lazygit_toggle []
 (lazygit:toggle))

(fn _btop_toggle []
 (btop:toggle))

(fn _nbb_toggle []
 (nbb:toggle))

(vim.api.nvim_create_user_command :ToggleLazygit _lazygit_toggle {:bang false})
(vim.api.nvim_create_user_command :ToggleBTOP _btop_toggle {:bang false})
;; (vim.api.nvim_create_user_command :ToggleNNN _nnn_toggle {:bang false})
;; (vim.api.nvim_create_user_command :ToggleNVIM _nvim_toggle {:bang false})
(vim.api.nvim_create_user_command :ToggleNBB _nbb_toggle {:bang false})
(vim.api.nvim_create_user_command
    :FloatToggle 
    #(:
      (Terminal:new {:direction :float
                     :hidden true
                     :on_open #(vim.api.nvim_buf_set_keymap
                                $.bufnr
                                :n
                                :q
                                "<cmd>close<cr>"
                                {:noremap true :silent true})})
      :toggle)
     {:bang false})
