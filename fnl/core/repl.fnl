;; repl using neovim's builtin lua interpreter
;; uses fennel provided from hotpot
;; uses fennel macro to execute shell code

(local fennel (require :fennel))
(var sh-out false)
(var output [])

;; read user input and add prompt + wrap in sh macro if nessecary 

(fn read-chunk [parser-state]
  (io.write (if (< 0 parser-state.stack-size) ".." "λ "))
  (io.flush)
  (when (> (length output) 0)
    (io.write (table.concat output "\n") "\n"))
  (let [input (io.read)
        paren? (string.match input "(%b())")
        repl-cmd? (string.match input "^(,)")
        str (if (and (not paren?) (not repl-cmd?))
                ;; TODO: This passes the macro each time, but I can't find a way to load macros into the repl's env
                ;; Make it so we don't need to resend the macro each time
                (.. "(macro sh [...]
                   `(let [str# ,(accumulate [str# \"\" _ v# (ipairs [...])]
                                  (if (in-scope? v#) `(.. ,str# \" \" ,v#)
                                      (or (list? v#) (sym? v#)) (.. str# \" \" (tostring v#))
                                      (= (type v#) :string) (.. str# \" \" (string.format \"%q\" v#))))
                          fd# (io.popen str#)
                          d# (fd#:read :*a)]
                      (fd#:close)
                      (string.sub d# 1 (- (length d#) 1)))) (sh "
                    input ")") input)]
    (if (not paren?) (set sh-out true))
    (set output [])
    (and str (.. str "\n"))))

(fn on-values [xs]
  (local out (if sh-out
                 ; delete quotes in output (maybe not needed and prone to errors?
                 (icollect [i v (ipairs xs)]
                   (string.gsub v "\"" "")) xs))
  (table.insert output (table.concat out "\t"))
  (if sh-out (set sh-out (not sh-out))))

;; on error

(fn on-error [errtype err lua-source]
  (io.write (match errtype
              "Lua Compile" (.. "Bad code generated\n" "--- Generated Lua Start ---
" lua-source "--- Generated Lua End ---
")
              :Runtime (.. (fennel.traceback (tostring err) 4) "\n")
              _ (: "%s error: %s\n" :format errtype (tostring err)))))

;; add neovim to repl's env

(fn xpcall* [f err ...]
  (let [res (vim.F.pack_len (pcall f))]
    (when (not (. res 1))
      (tset res 2 (err (. res 2))))
    (vim.F.unpack_len res)))

(local env {})
(local fenv {})
(each [k v (pairs (getfenv 0))]
  (tset env k v)
  (tset fenv k v))

(tset fenv :xpcall xpcall*)

;; create repl with functions and env

(let [repl (setfenv fennel.repl fenv)]
  (fennel.repl {: env
                :pp fennel.view
                :readChunk read-chunk
                :onError on-error
                :allowedGlobals false}))
