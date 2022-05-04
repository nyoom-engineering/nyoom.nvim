(local {: gmatch} string)
(local {: insert} table)

(fn ->str [x]
  "Convert given parameter into a string"
  (tostring x))

(fn str? [x]
  "Check if given parameter is a string"
  (= :string (type x)))

(fn tbl? [x]
  "Check if given parameter is a table"
  (= :table (type x)))

(fn nil? [x]
  "Check if given parameter is nil"
  (= :nil x))

(fn head [xs]
  (. xs 1))

(fn fn? [x]
  "Returns whether the parameter(s) is a function.
  A function is defined as any list with 'fn or 'hashfn as their first
  element."
  (and (list? x) (or (= `fn (head x)) (= `hashfn (head x)))))

(λ map! [[modes & options] lhs rhs ?desc]
  "Defines a new mapping using the Lua API"
  (assert-compile (or (sym? modes) (tbl? modes))
                  "expected symbol or table for modes" modes)
  (assert-compile (tbl? options) "expected table for options" options)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (list? rhs) (fn? rhs) (sym? rhs))
                  "expected string or list or function or symbol for rhs" rhs)
  (assert-compile (or (not (nil? ?desc)) (str? ?desc))
                  "expected string or nil for description" ?desc)
  (let [modes (icollect [char (gmatch (->str modes) ".")]
                char)
        options (collect [_ v (ipairs options)]
                  (->str v)
                  true)
        rhs (if (and (not (fn? rhs)) (list? rhs)) `#,rhs rhs)
        desc (if (and (not ?desc) (or (fn? rhs) (sym? rhs))) (view rhs) ?desc)
        options (if desc (doto options (tset :desc desc)) options)]
    `(vim.keymap.set ,modes ,lhs ,rhs ,options)))

(fn buf-map! [[modes & options] lhs rhs ?desc]
  "Defines a new buffer mapping using the Lua API"
  (let [options (doto options
                  (tset :buffer true))]
    (map! [modes (unpack options)] lhs rhs ?desc)))

(fn doc-map! [mode lhs options description]
  "Documents a new mapping using the which-key api"
  `(let [(ok?# which-key#) (pcall require :which-key)]
     (when ok?#
       (which-key#.register {,lhs ,description}
                            {:mode ,mode
                             :buffer ,(if options.buffer 0)
                             :silent ,(if options.silent true)
                             :noremap ,(if (not options.noremap) false)
                             :nowait ,(if options.nowait true)}))))

{: map!
 : buf-map!
 : doc-map!}
