(fn ->str [x]
  "Convert given parameter into a string"
  (tostring x))

(fn tbl? [x]
  "Check if given parameter is a table"
  (= :table (type x)))

(λ custom-set-face! [name attributes colors]
  "Defines a highlight group using the vim API.
  e.g. (highlight! Error [:bold] {:fg :hex})"
  (assert-compile (sym? name) "expected symbol for name" name)
  (assert-compile (tbl? attributes) "expected table for attributes" attributes)
  (assert-compile (tbl? colors) "expected colors for colors" colors)
  (let [name (->str name)
        colors (collect [_ v (ipairs attributes) :into colors]
                 (->str v)
                 true)]
    `(vim.api.nvim_set_hl 0 ,name ,colors)))

(λ link! [new to old]
  "Defines a highlight group using the vim API.
  e.g. (link! new => old)"
  (assert-compile (sym? new) "expected symbol for new" new)
  (assert-compile (= `=> to) "expected => for to" to)
  (assert-compile (sym? old) "expected symbol for old" old)
  (let [new (->str new)
        old (->str old)]
    `(vim.api.nvim_set_hl 0 ,new {:link ,old})))

{: custom-set-face!
 : link!}
