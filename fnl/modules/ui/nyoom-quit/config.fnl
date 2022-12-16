(import-macros {: map!} :macros)

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

(fn going-to-quit []
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
  (if (or (= buftype :help) (= buftype :nofile)) (vim.api.nvim_command :q)
      (and last-buffer? (going-to-quit)) (vim.api.nvim_command :q)
      (= (vim.fn.confirm msg "&Yes\n&No" 2) 1) (if (and save?
                                                        (vim.api.nvim_buf_get_option 0
                                                                                     :modified))
                                                   (vim.api.nvim_command :wqa)
                                                   (vim.api.nvim_command :qa))))

(map! [c] :q `((confirm-quit) false true))
(map! [c] :wq `((confirm-quit) true true))
