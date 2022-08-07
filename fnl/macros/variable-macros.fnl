(local {: str? : ->str} (require :macros.types-macros))

(λ let-with-scope! [[scope] name value]
  (assert-compile (or (str? scope) (sym? scope)) "expected string or symbol for scope" scope)
  (assert-compile (or (= :b (->str scope))
                      (= :w (->str scope))
                      (= :t (->str scope))
                      (= :g (->str scope))) "expected scope to be either b, w, t or g" scope)
  (assert-compile (or (str? name) (sym? name)) "expected string or symbol for name" name)
  (let [name (->str name)
        scope (->str scope)]
    `(tset ,(match scope
              :b 'vim.b
              :w 'vim.w
              :t 'vim.t
              :g 'vim.g) ,name ,value)))

(λ let-global! [name value]
  (assert-compile (or (str? name) (sym? name)) "expected string or symbol for name" name)
  (let [name (->str name)]
    `(tset vim.g ,name ,value)))

(λ let! [...]
  "Set a vim variable using the vim.<scope>.name API.
  Accepts the following arguments:
  [scope] -> optional. Can be either [g], [w], [t] or [b]. It's either a symbol
             or a string surrounded by square brackets.
  name -> either a symbol or a string.
  value -> anything.
  Example of use:
  ```fennel
  (let! hello :world)
  (let! [w] hello :world)
  ```
  That compiles to:
  ```fennel
  (tset vim.g :hello :world)
  (tset vim.w :hello :world)
  ```"
   (match [...]
     [[scope] name value] (let-with-scope! [scope] name value)
     [name value] (let-global! name value)
     _ (error "expected let! to have at least two arguments: name value")))

{: let!}
