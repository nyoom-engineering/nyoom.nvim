(local {:sumhexa md5} (require :utils.md5))
(local {: format} string)

(fn ->str [x]
  (tostring x))

(fn empty? [xs]
  (= 0 (length xs)))

(fn str? [x]
  (= :string (type x)))

(fn nil? [x]
  (= nil x))

(fn head [xs]
  (. xs 1))

(fn includes? [xs x]
  (accumulate [is? false
               _ v (ipairs xs)
               :until is?] (= v x)))

(fn fn? [x]
  "Returns whether the parameter(s) is a function.
  A function is defined as any list with 'fn or 'hashfn as their first
  element."
  (and
    (list? x)
    (or (= 'fn (head x))
        (= 'hashfn (head x)))))

(λ gensym-checksum [...]
  "Generates a new symbol from the checksum of the object passed as
  a paremeter.
  The paremeter first is casted into a string using the function
  `fennel.view`.
  If only one paremeter is passed to the function the return value is the
  checksum as a symbol.
  If two paremeters are passed, the first one is considered the prefix.
  If three paremeters are passed, the first one is considered the prefix and
  the last one is considered the suffix.
  This function depends on the md5 library and the fennel library."
  (match [...]
    [prefix object suffix] (sym (.. prefix (md5 (view object)) suffix))
    [prefix object] (gensym-checksum prefix object "")
    [object] (gensym-checksum "" object "")))

(λ vlua [x]
  "Return a symbol mapped to `v:lua.%s()`, where `%s` is the symbol."
  (assert-compile (sym? x) "expected symbol for x" x)
  (format "v:lua.%s()" (->str x)))

(λ set! [name ?value]
  "Set a vim option using the lua API.
  The name of the option must be a symbol.
  If no value is specified, if the name begins with 'no' the value becomes
  false, it becomes true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (or ?value
                  (not (name:match "^no")))
        name (or (name:match "^no(.+)$")
                 name)]
    (if (fn? value)
      (let [fsym (gensym-checksum "__" value)]
        `(do
           (global ,fsym ,value)
           (tset vim.opt ,name ,(vlua fsym))))
      (match (name:sub -1)
        :+ `(: (. vim.opt ,(name:sub 1 -2)) :append ,value)
        :- `(: (. vim.opt ,(name:sub 1 -2)) :remove ,value)
        :^ `(: (. vim.opt ,(name:sub 1 -2)) :prepend ,value)
        _ `(tset vim.opt ,name ,value)))))

(fn set!-mult [...]
  "Set one or multiple vim options using the lua API.
  The name of the option must be a symbol.
  If no value is specified, if the name begins with 'no' the value becomes
  false, it becomes true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (fn aux [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      (where [name value & rest] (not (sym? value))) [(set! name value)
                                                      (unpack (aux (unpack rest)))]
      [name & rest] [(set! name)
                     (unpack (aux (unpack rest)))]
      _ []))
  (let [exprs (aux ...)]
    (if
      (> (length exprs) 1) `(do ,(unpack exprs))
      (unpack exprs))))

(λ local-set! [name ?value]
  "Set a vim local option using the lua API.
  The name of the option must be a symbol.
  If no value is specified, if the name begins with 'no' the value becomes
  false, it becomes true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (or ?value
                  (not (name:match "^no")))
        name (or (name:match "^no(.+)$")
                 name)]
    (if (fn? value)
      (let [fsym (gensym-checksum "__" value)]
        `(do
           (global ,fsym ,value)
           (tset vim.opt_local ,name ,(vlua fsym))))
      (match (name:sub -1)
        :+ `(: (. vim.opt_local ,(name:sub 1 -2)) :append ,value)
        :- `(: (. vim.opt_local ,(name:sub 1 -2)) :remove ,value)
        :^ `(: (. vim.opt_local ,(name:sub 1 -2)) :prepend ,value)
        _ `(tset vim.opt_local ,name ,value)))))

(fn local-set!-mult [...]
  "Set one or multiple vim local options using the lua API.
  The name of the option must be a symbol.
  If no value is specified, if the name begins with 'no' the value becomes
  false, it becomes true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (fn aux [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      (where [name value & rest] (not (sym? value))) [(local-set! name value)
                                                      (unpack (aux (unpack rest)))]
      [name & rest] [(local-set! name)
                     (unpack (aux (unpack rest)))]
      _ []))
  (let [exprs (aux ...)]
    (if
      (> (length exprs) 1) `(do ,(unpack exprs))
      (unpack exprs))))

(λ let! [name value]
  "Set a vim variable using the lua API.
  The name can be either a symbol or a string.
  If the name begins with [gbwt] followed by [/:.], the name is scoped to the
  respective scope:
  g -> global (default)
  b -> buffer
  w -> window
  t -> tab"
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)
        scope (when (includes? ["g/" "b/" "w/" "t/"
                                "g." "b." "w." "t."
                                "g:" "b:" "w:" "t:"] (name:sub 1 2))
                (name:sub 1 1))
        name (if
               (nil? scope) name
               (name:sub 3))]
    `(tset ,(match scope
              :b 'vim.b
              :w 'vim.w
              :t 'vim.t
              _ 'vim.g) ,name ,value)))

(fn let!-mult [...]
  "Set one or multiple vim variables using the lua API.
  The name can be either a symbol or a string.
  If the name begins with [gbwt] followed by [/:.], the name is scoped to the
  respective scope:
  g -> global (default)
  b -> buffer
  w -> window
  t -> tab"
  (fn aux [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      [name value & rest] [(let! name value)
                           (unpack (aux (unpack rest)))]
      _ []))
  (let [exprs (aux ...)]
    (if
      (> (length exprs) 1) `(do ,(unpack exprs))
      (unpack exprs)))) 

{: vlua
 : gensym-checksum
 :set! set!-mult
 :let! let!-mult
 :local-set! local-set!-mult}

