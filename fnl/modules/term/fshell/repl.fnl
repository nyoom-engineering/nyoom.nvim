;; heavily modified version of https://github.com/gpanders/fennel-repl.nvim to function as a shell

(local {: autoload} (require :core.lib.autoload))
(local fennel (autoload :fennel))

(local state {:n 1})
(var output-sh false)

(vim.cmd "
function! FennelReplCallback(text)
    call luaeval('require(\"modules.term.fshell.repl\").callback(_A[1], _A[2])', [bufnr(), a:text])
endfunction")

(fn create-buf []
  (let [bufnr (vim.api.nvim_create_buf true true)]
    (doto bufnr
      (vim.api.nvim_buf_set_name (: "fennel-repl.%d" :format state.n))
      (vim.api.nvim_buf_set_option :buftype :prompt)
      (vim.api.nvim_buf_set_option :filetype :fennel)
      (vim.api.nvim_buf_set_option :complete ".")
      (vim.fn.prompt_setcallback :FennelReplCallback)
      (vim.fn.prompt_setprompt (.. "$ ")))
    (vim.api.nvim_command (: "autocmd BufEnter <buffer=%d> startinsert" :format
                             bufnr))
    bufnr))

(fn create-win [bufnr opts]
  (let [mods (or opts.mods "")]
    (vim.api.nvim_command (: "%s sbuffer %d" :format mods bufnr))
    (when opts.height
      (vim.api.nvim_win_set_height 0 opts.height))
    (when opts.width
      (vim.api.nvim_win_set_width 0 opts.width))
    (vim.api.nvim_get_current_win)))

(fn find-repl-win [bufnr]
  (. (icollect [_ win (ipairs (vim.api.nvim_list_wins))]
       (when (= (vim.api.nvim_win_get_buf win) bufnr)
         win)) 1))

(fn close [bufnr]
  (let [win (find-repl-win bufnr)]
    (doto bufnr
      (vim.api.nvim_buf_set_lines -1 -1 true ["[Process exited]"])
      (vim.api.nvim_buf_set_option :buftype "")
      (vim.api.nvim_buf_set_option :modified false)
      (vim.api.nvim_buf_set_option :modifiable false))
    (vim.api.nvim_win_close win false)
    (set state.n (+ state.n 1))
    (set state.bufnr nil)))

(fn read-chunk [parser-state]
  (let [input (coroutine.yield parser-state.stack-size)
        paren? (string.match input "(%b())")
        repl-cmd? (string.match input "^(,)")
        input (if (and (not paren?) (not repl-cmd?))
                  (.. "(sh " input ")")
                  input)]
    (if (not paren?) (set output-sh true))
    (and input (.. input "\n"))))

(fn on-values [vals]
  (local vals (if output-sh
                  (icollect [i v (ipairs vals)]
                    (string.gsub v "\"" ""))
                  vals))
  (coroutine.yield -1 (.. (table.concat vals "\t") "\n"))
  (if output-sh (set output-sh (not output-sh))))

(fn on-error [errtype err lua-source]
  (coroutine.yield -1
                   (match errtype
                     :Runtime (.. (fennel.traceback (tostring err) 4) "\n")
                     _ (: "%s error: %s\n" :format errtype (tostring err)))))

(fn write [bufnr ...]
  (let [text (-> (table.concat [...] " ") (string.gsub "\\n" "\n"))
        lines (vim.split text "\n")]
    (vim.api.nvim_buf_set_lines bufnr -2 -1 true lines)))

(fn xpcall* [f err ...]
  (let [res (vim.F.pack_len (pcall f))]
    (when (not (. res 1))
      (tset res 2 (err (. res 2))))
    (vim.F.unpack_len res)))

(fn callback [bufnr text]
  (let [(ok? stack-size out) (coroutine.resume state.coro text)]
    (if (and ok? (= (coroutine.status state.coro) :suspended))
        (do
          (->> (if (< 0 stack-size) ".." "$ ")
               (vim.fn.prompt_setprompt bufnr))
          (when (> 0 stack-size)
            (write bufnr out)
            (coroutine.resume state.coro)))
        (close bufnr))))

(fn open [?opts]
  (let [opts (or ?opts {})
        init-repl? (= nil state.bufnr)
        bufnr (or state.bufnr (create-buf))
        win (or (find-repl-win bufnr) (create-win bufnr opts))
        env {}
        fenv {}]
    (set state.bufnr bufnr)
    (vim.api.nvim_set_current_win win)
    (when init-repl?
      (each [k v (pairs (getfenv 0))]
        (tset env k v)
        (tset fenv k v))
      (tset env :print #(write bufnr $... "\n"))
      (tset fenv :xpcall xpcall*)
      (let [repl (setfenv fennel.repl fenv)]
        (set state.coro
             (coroutine.create #(repl {: env
                                       :allowedGlobals false
                                       :pp fennel.view
                                       :readChunk read-chunk
                                       :onValues on-values
                                       :onError on-error})))
        (coroutine.resume state.coro)))
    bufnr))

{: open : callback}
