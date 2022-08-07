(local {: ->str : nil?} (require :macros.types-macros))
(local {: begins-with?} (require :macros.string-macros))
(local {: quoted? : fn?
        : quoted->fn
        : gensym-checksum
        : expand-exprs
        : vlua} (require :macros.compile-time-macros))

(λ set! [name ?value]
  "Set a vim option using the vim.opt.<name> API.
  Accepts the following arguments:
  name -> must be a symbol.
          - If it ends with '+' it appends to the current value.
          - If it ends with '-' it removes from the current value.
          - If it ends with with '^' it prepends to the current value.
  value -> anything.
           - If it is not specified, whether the name begins with 'no' is used
             as a boolean value.
           - If it is a quoted expression or a function it becomes
             v:lua.<symbol>()."
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (if (nil? ?value)
                  (not (begins-with? :no name))
                  ?value)
        value (if (quoted? value)
                (quoted->fn value)
                value)
        name (if (and (nil? ?value) (begins-with? :no name))
               (name:match "^no(.+)$")
               name)
        exprs (if (fn? value)
                [`(tset _G ,(->str (gensym-checksum value {:prefix "__"})) ,value)]
                [])
        value (if (fn? value)
                (vlua (gensym-checksum value {:prefix "__"}))
                value)
        exprs (doto exprs
                    (table.insert (match (name:sub -1)
                                    "+" `(: (. vim.opt ,(name:sub 1 -2)) :append ,value)
                                    "-" `(: (. vim.opt ,(name:sub 1 -2)) :remove ,value)
                                    "^" `(: (. vim.opt ,(name:sub 1 -2)) :prepend ,value)
                                    _ `(tset vim.opt ,name ,value))))]
    (expand-exprs exprs)))

(λ local-set! [name ?value]
  "Set a vim option using the vim.opt_local.<name> API.
  Accepts the following arguments:
  name -> must be a symbol.
          - If it ends with '+' it appends to the current value.
          - If it ends with '-' it removes from the current value.
          - If it ends with with '^' it prepends to the current value.
  value -> anything.
           - If it is not specified, whether the name begins with 'no' is used
             as a boolean value.
           - If it is a quoted expression or a function it becomes
             v:lua.<symbol>()."
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (if (nil? ?value)
                  (not (begins-with? :no name))
                  ?value)
        value (if (quoted? value)
                (quoted->fn value)
                value)
        name (if (and (nil? ?value) (begins-with? :no name))
               (name:match "^no(.+)$")
               name)
        exprs (if (fn? value)
                [`(tset _G ,(->str (gensym-checksum value {:prefix "__"})) ,value)]
                [])
        value (if (fn? value)
                (vlua (gensym-checksum value {:prefix "__"}))
                value)
        exprs (doto exprs
                    (table.insert (match (name:sub -1)
                                    "+" `(: (. vim.opt_local ,(name:sub 1 -2)) :append ,value)
                                    "-" `(: (. vim.opt_local ,(name:sub 1 -2)) :remove ,value)
                                    "^" `(: (. vim.opt_local ,(name:sub 1 -2)) :prepend ,value)
                                    _ `(tset vim.opt_local ,name ,value))))]
    (expand-exprs exprs)))

{: set!
 : local-set!}
