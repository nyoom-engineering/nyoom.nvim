;; profiler for neovim fennel/lua code
;; monkey patches all functions and returns a chrome debug trace
;; preview in https://ui.perfetto.dev/

(local autocmds [:BufAdd
                 :BufDelete
                 :BufEnter
                 :BufFilePost
                 :BufFilePre
                 :BufHidden
                 :BufLeave
                 :BufModifiedSet
                 :BufNew
                 :BufNewFile
                 :BufRead
                 :BufReadPre
                 :BufUnload
                 :BufWinEnter
                 :BufWinLeave
                 :BufWipeout
                 :BufWrite
                 :BufWritePost
                 :ChanInfo
                 :ChanOpen
                 :CmdUndefined
                 :CmdlineChanged
                 :CmdlineEnter
                 :CmdlineLeave
                 :CmdwinEnter
                 :CmdwinLeave
                 :ColorScheme
                 :ColorSchemePre
                 :CompleteChanged
                 :CompleteDonePre
                 :CompleteDone
                 :CursorHold
                 :CursorHoldI
                 :CursorMoved
                 :CursorMovedI
                 :DiffUpdated
                 :DirChanged
                 :FileAppendPost
                 :FileAppendPre
                 :FileChangedRO
                 :ExitPre
                 :FileChangedShell
                 :FileChangedShellPost
                 :FileReadPost
                 :FileReadPre
                 :FileType
                 :FileWritePost
                 :FileWritePre
                 :FilterReadPost
                 :FilterReadPre
                 :FilterWritePost
                 :FilterWritePre
                 :FocusGained
                 :FocusLost
                 :FuncUndefined
                 :UIEnter
                 :UILeave
                 :InsertChange
                 :InsertCharPre
                 :TextYankPost
                 :InsertEnter
                 :InsertLeavePre
                 :InsertLeave
                 :MenuPopup
                 :OptionSet
                 :QuickFixCmdPre
                 :QuickFixCmdPost
                 :QuitPre
                 :RemoteReply
                 :SessionLoadPost
                 :ShellCmdPost
                 :Signal
                 :ShellFilterPost
                 :SourcePre
                 :SourcePost
                 :SpellFileMissing
                 :StdinReadPost
                 :StdinReadPre
                 :SwapExists
                 :Syntax
                 :TabEnter
                 :TabLeave
                 :TabNew
                 :TabNewEntered
                 :TabClosed
                 :TermOpen
                 :TermEnter
                 :TermLeave
                 :TermClose
                 :TermResponse
                 :TextChanged
                 :TextChangedI
                 :TextChangedP
                 :User
                 :VimEnter
                 :VimLeave
                 :VimLeavePre
                 :VimResized
                 :VimResume
                 :VimSuspend
                 :WinClosed
                 :WinEnter
                 :WinLeave
                 :WinNew
                 :WinScrolled])

(fn create [groupname function]
  (var cmd (string.format "aug %s\nau!" groupname))
  (each [- autocmd (ipairs autocmds)]
    (set cmd (.. cmd "\n"
                 (string.format "autocmd %s * call luaeval(\"require'profile'.%s('%s', {match=-A})\", expand('<amatch>'))"
                                autocmd function autocmd))))
  (set cmd (.. cmd "\naug END"))
  (vim.cmd cmd))

(fn instrument-start []
  (create :lua-profile-start :log-start))

(fn instrument-auto []
  (if (not= (vim.fn.exists "#lua-profile-start") 0)
      (create :lua-profile-end :log-end)
      (create :lua-profile :log-instant)))

(fn clear []
  (vim.cmd "aug lua-profile\n  au!\n\taug END"))

(local clock (require :profile.clock))
(local instrument (require :profile.instrument))

(local rawrequire require)
(var events {})
(local ignore-list [:^_G$
                    :^bit$
                    :^coroutine$
                    :^debug$
                    :^ffi$
                    :^io$
                    :^jit.*$
                    :^luv$
                    :^math$
                    :^os$
                    :^package$
                    :^string$
                    :^table$
                    "^vim%.inspect$"
                    :^profile.*$
                    "^lspconfig%.util%.script_path$"
                    "^plenary%.async_lib.*$"])

(local instrument-list {})
(local wrapped-modules {})
(local wrapped-functions {})
(set M.recording false)
(local exposed-globals {: vim : vim.fn : vim.api})
(fn all-modules []
  (vim.tbl_extend :keep package.loaded exposed-globals))

(fn should-instrument [name]
  (if (. wrapped-functions name) false
      (. wrapped-modules name) false
      (do
        (each [_ pattern (ipairs ignore-list)]
          (when (string.match name pattern)
            (lua "return false")))
        true)))

(fn wrap-function [name ___fn___]
  (fn [...]
    (let [arg-string (util.format_args ...)
          start (clock)]
      (fn handle-result [...]
        (let [delta (- (clock) start)]
          (M.add_event {: name
                        :args arg-string
                        :cat :function
                        :ph :X
                        :ts start
                        :dur delta})
          ...))

      (handle-result (___fn___ ...)))))

(fn patch-function [modname mod name]
  (let [___fn___ (. mod name)]
    (when (= (type ___fn___) :function)
      (local fnname (string.format "%s.%s" modname name))
      (when (should-instrument fnname)
        (tset wrapped-functions fnname ___fn___)
        (tset mod name (wrap-function fnname ___fn___))))))

(fn maybe-wrap-function [name]
  (let [(parent-mod-name ___fn___) (util.split_path name)
        mod (M.get_module parent-mod-name)]
    (when mod
      (patch-function parent-mod-name mod ___fn___))))

(fn wrap-module [name mod]
  (set-forcibly! name (util.normalize_module_name name))
  (when (or (not= (type mod) :table) (not (should-instrument name)))
    (lua "return "))
  (tset wrapped-modules name true)
  (each [k (pairs mod)]
    (when (not (util.startswith k "_"))
      (patch-function name mod k))))

(fn should-profile-module [name]
  (each [_ pattern (ipairs instrument-list)]
    (when (string.match name pattern)
      (lua "return true")))
  false)

(set M.hook_require (fn [module-name]
                      (when (not= rawrequire require)
                        (lua "return "))
                      (local wrapped-require
                             (wrap-function :require rawrequire))
                      (set _G.require
                           (fn [name]
                             (when (or (. package.loaded name)
                                       (not (should-profile-module name)))
                               (let [___antifnl_rtns_1___ [(rawrequire name)]]
                                 (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
                             (local mod (wrapped-require name))
                             (wrap-module name mod)
                             mod))))

(set M.clear_events (fn []
                      (set events {})))

(set M.add_event (fn [event]
                   (when M.recording
                     (table.insert events event))))

(set M.get_module
     (fn [name]
       (var (ok mod) (pcall require name))
       (if ok (if (= (type mod) :table) mod nil)
           (do
             (set mod _G)
             (local paths (util.split name "\\."))
             (each [_ token (ipairs paths)]
               (set mod (. mod token))
               (when (not mod)
                 (lua :break)))
             (or (and (= (type mod) :table) mod) nil)))))

(set M.get_events (fn []
                    events))

(set M.ignore
     (fn [name]
       (table.insert ignore-list (util.path_glob_to_regex name))))

(set M.print_modules (fn []
                       (each [module _ (pairs wrapped-modules)]
                         (print module))))

(fn instrument [_ name]
  (let [pattern (util.path_glob_to_regex name)]
    (when (not (vim.tbl_contains instrument-list pattern))
      (table.insert instrument-list pattern))
    (M.hook_require name)
    (each [modname mod (pairs (all-modules))]
      (when (string.match modname pattern)
        (wrap-module modname mod)))
    (maybe-wrap-function name)))

(setmetatable M {:__call instrument})

(local util (require :profile.util))
(local event-defaults {:pid 1 :tid 1})

(fn instrument-autocmds []
  (instrument-start))

(fn instrument [name]
  (instrument name))

(fn ignore [name]
  (instrument.ignore name))

(fn start [...]
  (each [- pattern (ipairs [...])]
    (instrument pattern))
  (instrument-auto)
  (instrument.clear-events)
  (clock.reset)
  (set instrument.recording true))

(fn is-recording []
  instrument.recording)

(fn stop [filename]
  (set instrument.recording false)
  (when filename
    (export filename)))

(fn log-start [name ...]
  (when (not instrument.recording)
    (lua "return "))
  (instrument.add-event {: name
                         :args (util.format-args ...)
                         :cat "function,manual"
                         :ph :B
                         :ts (clock)}))

(fn log-end [name ...]
  (when (not instrument.recording)
    (lua "return "))
  (instrument.add-event {: name
                         :args (util.format-args ...)
                         :cat "function,manual"
                         :ph :E
                         :ts (clock)}))

(fn log-instant [name ...]
  (when (not instrument.recording)
    (lua "return "))
  (instrument.add-event {: name
                         :args (util.format-args ...)
                         :cat ""
                         :ph :i
                         :ts (clock)
                         :s :g}))

(fn print-instrumented-modules []
  (instrument.print-modules))

(fn export [filename]
  (let [file (io.open filename :w)
        events (instrument.get-events)]
    (file:write "[")
    (each [i event (ipairs events)]
      (local e (vim.tbl-extend :keep event event-defaults))
      (var (ok jse) (pcall vim.json.encode e))
      (when (and (not ok) e.args)
        (set e.args nil)
        (set (ok jse) (pcall vim.json.encode e)))
      (if ok (do
               (file:write jse)
               (when (< i (length events))
                 (file:write ",\n")))
          (let [err (string.format "Could not encode event: %s\n%s" jse
                                   (vim.inspect e))]
            (vim.api.nvim-echo [[err :Error]] true {}))))
    (file:write "]")
    (file:close)))
