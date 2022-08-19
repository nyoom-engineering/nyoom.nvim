(import-macros {: nyoom-module-p! : map! : let!} :macros)
(local {: setup} (require :leap)) 

;; Set leader to space by default
(let! mapleader " ")

(setup {:max_aot_targets nil
        :case_sensitive false
        :character_classes [" \t\r\n"]
        :special_keys {:repeat_search :<enter>
                       :next_match    :<enter>
                       :prev_match    :<tab>
                       :next_group    :<space>
                       :prev_group    :<tab>}})

;; Regular Leap 
(map! [nx] :s "<Plug>(leap-forward)" {:desc "Leap Forward"})
(map! [nx] :S "<Plug>(leap-backward)" {:desc "Leap Backward"})
(map! [o] :z "<Plug>(leap-forward)" {:desc "Leap Forward"})
(map! [o] :Z "<Plug>(leap-backward)" {:desc "Leap Backward"})
(map! [nxo] :gz "<Plug>(leap-cross-window)" {:desc "Leap Cross Window"})
(map! [o] :x "<Plug>(leap-forward-x)" {:desc "Leap Forward (x)"})
(map! [o] :X "<Plug>(leap-backward-x)" {:desc "Leap Backward (x)"})

;; easier command line mode + 
(map! [n] ";" ":" {:desc "vim-ex"})

(nyoom-module-p! completion.telescope
  (do
    (map! [n] "<leader><space>" "<cmd>Telescope find_files<CR>" {:desc "Find Files"})
    (map! [n] "<leader>bb" "<cmd>Telescope buffers<CR>" {:desc "Buffers"})
    (map! [n] "<leader>:" "<cmd>Telescope commands<CR>" {:desc "M-x"})))

(nyoom-module-p! ui.nyoom-quit
  (do
    (local quit-messages [;; from Doom 1
                          "Please don't leave, there's more demons to toast!"
                          "I wouldn't leave if I were you. DOS is much worse."
                          "Don't leave yet -- There's a demon around that corner!"
                          "Ya know, next time you come in here I'm gonna toast ya."
                          "Go ahead and leave. See if I care."
                          "Are you sure you want to quit this great editor?"
                          ;; from Portal
                          "You can't fire me, I quit!"
                          "I don't know what you think you are doing, but I don't like it. I want you to stop."
                          "This isn't brave. It's murder. What did I ever do to you?"
                          "I'm the man who's going to burn your house down! With the lemons!"
                          "Okay, look. We've both said a lot of things you're going to regret..."
                          ;; Custom
                          "Go ahead and leave. I'll convert your code to Fennel!"
                          "Neovim will remember that."
                          "Please don't leave, otherwise I'll tell packer to break your setup on next launch!"
                          "It's not like I'll miss you or anything, b-baka!"
                          "You are *not* prepared!"])
    (λ going-to-quit []
      (var open-buffers 0)
      (for [buf (vim.fn.bufnr 1) (vim.fn.bufnr "$")]
        (when (= (vim.fn.bufloaded buf) 1)
          (set open-buffers (+ open-buffers 1))))
      (= open-buffers 1))
    (fn confirm-quit [save? last-buffer?]
      (local buftype (vim.api.nvim_buf_get_option 0 :buftype))
      (local msg (string.format "%s  %s"
                                (. quit-messages
                                   (math.random (length quit-messages)))
                                "Really quit Neovim?"))
      (if (or (= buftype :help) (= buftype :nofile))
          (vim.api.nvim_command :q)
          (and last-buffer? (going-to-quit))
          (vim.api.nvim_command :q)
          (= (vim.fn.confirm msg "&Yes\n&No" 2) 1)
          (if (and save? (vim.api.nvim_buf_get_option 0 :modified))
              (vim.api.nvim_command :wqa)
              (vim.api.nvim_command :qa))))

    (map! [c] :q '((confirm-quit) false true))
    (map! [c] :wq '((confirm-quit) true true))))
