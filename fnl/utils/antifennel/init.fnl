;; Antifennel for neovim. Asycnronously use the ./antifennel script to compile
;; lua code back to fennel. Neat for making configurations

(fn create-file [filename text]
  (local handle (assert (io.open filename :w+)))
  (handle:write text)
  (handle:close))

(fn strip-trailing-newlines [str]
  (var ret str)
  (while (= "\n" (ret:sub -1))
    (set ret (ret:sub 1 -2)))
  ret)

(fn run-antifennel [filename start-line end-line]
  (local stdout (vim.loop.new_pipe))
  (local stderr (vim.loop.new_pipe))

  (fn on-stdout [?err ?data]
    (log (: "on-stdout() with err %s, data %s" :format ?err ?data))
    (when (not= nil ?data)
      (local lines (vim.split (strip-trailing-newlines ?data) "\n"))
      (vim.schedule (fn []
                      (vim.api.nvim_buf_set_lines 0 start-line end-line true [])
                      (vim.api.nvim_buf_set_lines 0 start-line start-line true
                                                  lines)))))

  (fn on-stderr [?err ?data]
    (log (: "on-stderr() with err %s, data %s" :format ?err ?data)))

  (fn on-exit [code signal]
    (log (: "on-exit() with exit code %d, signal %d" :format code signal))
    (when (not= 0 code)
      (log (: "spawn failed (exit code %d, signal %d)" :format code signal)))
    (assert (os.remove filename)))

  (vim.loop.spawn (:antifennel) {:args [filename] :stdio [nil stdout stderr]} on-exit)
  (vim.loop.read_start stdout on-stdout)
  (vim.loop.read_start stderr on-stderr))

(fn run [start-line end-line]
  (let [start-line (- start-line 1)
        input (vim.api.nvim_buf_get_lines 0 start-line end-line true)
        filename (vim.fn.tempname)]
    (create-file filename (table.concat input "\n"))
    (run-antifennel filename start-line end-line)))

{: run}
