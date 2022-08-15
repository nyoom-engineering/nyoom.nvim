(local {: extend-keep} (require :utils.parinfer.sriapi))

(local incr-bst (require :utils.parinfer.incremental-change))
(local {:run run-parinfer} (require :utils.parinfer.lib))
(local {: get-options : get-buf-options : update-option :setup opts-setup}
       (require :utils.parinfer.options))

(local buf-apply-diff incr-bst.buf-apply-diff)
(local (t/cat t/ins) (values table.concat table.insert))
(local (json split cmd) (values vim.json vim.split vim.cmd))
(local ns (vim.api.nvim_create_namespace "parinfer"))

(local state {})

;; vim.fn functions
(local expand vim.fn.expand)
(local win_gettype vim.fn.win_gettype)

;; api functions
(local create_augroup vim.api.nvim_create_augroup)
(local create_autocmd vim.api.nvim_create_autocmd)
(local del_augroup_by_id vim.api.nvim_del_augroup_by_id)
(local del_autocmd vim.api.nvim_del_autocmd)
(local win_get_cursor vim.api.nvim_win_get_cursor)
(local win_set_cursor vim.api.nvim_win_set_cursor)
(local get_current_buf vim.api.nvim_get_current_buf)
(local buf_get_changedtick vim.api.nvim_buf_get_changedtick)
(local buf_get_option vim.api.nvim_buf_get_option)
(local buf_set_lines vim.api.nvim_buf_set_lines)
(local buf_get_lines vim.api.nvim_buf_get_lines)
(local buf_add_highlight vim.api.nvim_buf_add_highlight)
(local buf_clear_namespace vim.api.nvim_buf_clear_namespace)

(local process-events
  [:CursorMoved :InsertEnter :TextChanged :TextChangedI :TextChangedP])
(local cursor-events
  [:BufEnter :WinEnter])

(fn notify-error [buf request res]
  (vim.notify
    (t/cat [(.. "[Parinfer] error in buffer " buf)
            (json.encode (or (?. res :error) {}))
            (json.encode request)
            (json.encode (or res {}))]
           "\n")
    vim.log.levels.ERROR))

;; creates parinfennel augroup if necessary & stores id in state
(fn ensure-augroup []
  (when (= nil state.augroup)
    (tset state :augroup (create_augroup "parinfennel" {:clear true}))))

;; deletes parinfennel augroup if it exists
(fn del-augroup []
  (when (not= nil state.augroup)
    (del_augroup_by_id state.augroup)
    (tset state :augroup nil)))

;; creates an autocmd in `parinfennel` group
(fn autocmd [events opts]
  (create_autocmd events (extend-keep opts {:group "parinfennel"})))

;; shorthand for attaching a callback to a buffer
(fn buf-autocmd [buf events func]
  (t/ins (. state buf :autocmds)
         (autocmd events {:callback func :buffer buf})))

;; expands autocmd buffer argument and converts to a number
(fn abuf []
  (tonumber (expand "<abuf>")))

;; highlight 'parenTrails' that are being handled by parinfer
(fn handle-trails [group]
  (fn [buf trails]
    (buf_clear_namespace buf ns 0 -1)
    (when trails
      (each [_ {: startX : endX : lineNo} (ipairs trails)]
        (buf_add_highlight buf ns group lineNo startX endX)))))

;; gets cursor position, (0, 0) indexed
(fn get-cursor []
  (let [[row col] (win_get_cursor 0)]
    (values (- row 1) col)))

;; sets cursor position, (0, 0) indexed
(fn set-cursor [row col]
  (win_set_cursor 0 [(+ row 1) col]))

;; gets entire buffer text as one string
(fn get-buf-content [buf]
  (let [lines (buf_get_lines buf 0 -1 false)]
    (values (t/cat lines "\n") lines)))

;; creates a function that refreshes the state of buf's changedtick
(fn refresh-changedtick [buf]
  (let [bufstate (. state buf)]
    #(tset bufstate :changedtick (buf_get_changedtick buf))))

;; creates a function that refreshes the state of buf's cursor position
(fn refresh-cursor [buf]
  (let [bufstate (. state buf)]
    #(let [(cl cx) (get-cursor)]
       (doto bufstate
         (tset :cursorX cx)
         (tset :cursorLine cl)))))

;; creates a function that refreshes the state of buf's text & changedtick
(fn refresh-text [buf]
  (let [bufstate (. state buf)]
    #(let [ct (buf_get_changedtick buf)]
       (when (not= ct bufstate.changedtick)
         (doto bufstate
           (tset :changedtick ct)
           (tset :text (get-buf-content buf)))))))

;; creates a function that refreshes the state of
;; buf's cursor, text, and changedtick
(fn refresher [buf]
  (let [ref-t (refresh-text buf) ref-c (refresh-cursor buf)]
    #(do (ref-t) (ref-c))))

;; make a process-buffer function with enclosed settings
(fn make-processor [buf mode buf-opts]
  (let [bufstate (. state buf)
        {: commentChar
         : stringDelimiters
         : forceBalance
         : lispVlineSymbols
         : lispBlockComments
         : guileBlockComments
         : schemeSexpComments
         : janetLongStrings
         : trail_highlight
         : trail_highlight_group} buf-opts
        refresh-cursor (refresh-cursor buf)
        refresh-text (refresh-text buf)
        refresh-changedtick (refresh-changedtick buf)
        trails-fn (when trail_highlight (handle-trails trail_highlight_group))]

    (fn process []
      (when (not= bufstate.changedtick (buf_get_changedtick buf))
        (let [(cl cx) (get-cursor)
              (text lines) (get-buf-content buf)
              req {:mode mode
                   :text text
                   :options {: commentChar
                             : stringDelimiters
                             : forceBalance
                             : lispVlineSymbols
                             : lispBlockComments
                             : guileBlockComments
                             : schemeSexpComments
                             : janetLongStrings
                             :cursorX cx
                             :cursorLine cl
                             :prevCursorX bufstate.cursorX
                             :prevCursorLine bufstate.cursorLine
                             :prevText bufstate.text}}
              res (run-parinfer req)]
          (if res.success
              (do
                (when (not= res.text text)
                  (cmd "silent! undojoin")
                  (buf-apply-diff
                    buf text lines res.text (split res.text "\n")))
                (set-cursor res.cursorLine res.cursorX)
                (tset bufstate :text res.text)
                (when (not= nil trails-fn) (trails-fn buf res.parenTrails)))
              (do
                (notify-error buf req res)
                (tset bufstate :error res.error)
                (refresh-text))))
        (refresh-changedtick))
      (refresh-cursor))))

;; initialize buffer state if necessary, process buffer in paren mode
;; TODO: handle mode. shouldn't be hard
;; all that really needs to be done is set the `process-events` autocmd
;; to call `process-{mode}` and also make sure to re-init the buffer
;; whenever mode is changed. that's also how settings can be handled
(fn enter-buffer [buf]
  (when (= nil (. state buf))
    (tset state buf {})
    (let [(cl cx) (get-cursor)
          buf-opts (get-buf-options buf)
          processors {:smart (make-processor buf :smart buf-opts)
                      :indent (make-processor buf :indent buf-opts)
                      :paren (make-processor buf :paren buf-opts)}]
      (each [k v (pairs {: processors
                         :text (get-buf-content buf)
                         :autocmds []
                         :changedtick -1
                         :cursorX cx
                         :cursorLine cl})]
        (tset state buf k v))
      (doto buf
        (buf-autocmd process-events (. processors buf-opts.mode))
        (buf-autocmd cursor-events (refresh-cursor buf))
        (buf-autocmd :InsertCharPre (refresher buf)))))
  ((. state buf :processors :paren)))

;; initializes a buffer if its window isn't a special type (qflist/etc)
(fn initialize-buffer []
  (when (= "" (win_gettype))
    (enter-buffer (abuf))))

;; removes process callbacks associated with buf
(fn detach-buffer [buf]
  (when (?. state buf :autocmds)
    (each [_ v (ipairs (. state buf :autocmds))]
      (del_autocmd v)))
  (buf_clear_namespace buf ns 0 -1)
  (tset state buf nil))

(fn disable-parinfer-rust []
  (when (= 1 (vim.fn.exists "g:parinfer_enabled"))
    (tset vim.g :parinfer_enabled 0)))

;; :ParinferSetup as well as the main entry-point of this module
;; sets up autocmds to initialize new buffers
(fn setup! [conf]
  (when conf (opts-setup conf))
  (ensure-augroup)
  (autocmd :FileType {:callback initialize-buffer
                      :pattern ["clojure"
                                "scheme"
                                "lisp"
                                "racket"
                                "hy"
                                "fennel"
                                "janet"
                                "carp"
                                "wast"
                                "yuck"
                                "dune"]}))

;; :ParinferCleanup
;; delete parinfennel augroup which contains the init callback & all processors
(fn cleanup! []
  (del-augroup))

;; :ParinferOn
(fn attach-current-buf! []
  (disable-parinfer-rust)
  (ensure-augroup)
  (enter-buffer (get_current_buf)))

;; :ParinferOff
(fn detach-current-buf! []
  (detach-buffer (get_current_buf)))

;; :ParinferRefresh
(fn refresh-current-buf! []
  (doto (get_current_buf)
    (detach-buffer)
    (enter-buffer)))

;; :ParinferTrails
(fn toggle-trails! []
  (update-option :trail_highlight #(not $))
  (refresh-current-buf!))

;;; if parinfer-rust is active commands should start with :ParinferFnl,
;; otherwise they just start with :Parinfer
(fn cmd-str [cmd-name]
  (.. (if (= 1 (vim.fn.exists "g:parinfer_enabled"))
          :ParinferFnl
          :Parinfer)
      cmd-name))

(fn parinfer-command! [s f opts]
  (vim.api.nvim_create_user_command (cmd-str s) f (or opts {})))

(parinfer-command! :On attach-current-buf!)
(parinfer-command! :Off detach-current-buf!)
(parinfer-command! :Refresh refresh-current-buf!)
(parinfer-command! :Trails toggle-trails!)
(parinfer-command! :Setup setup!)
(parinfer-command! :Cleanup cleanup!)

{: setup!
 : cleanup!
 : attach-current-buf!
 : detach-current-buf!
 : refresh-current-buf!
 : toggle-trails!
 :setup setup!
 :cleanup cleanup!
 :attach_current_buf attach-current-buf!
 :detach_current_buf detach-current-buf!
 :refresh_current_buf refresh-current-buf!
 :toggle_trails toggle-trails!}
