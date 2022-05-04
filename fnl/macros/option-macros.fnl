(fn ->str [x]
  "Convert given parameter into a string"
  (tostring x))

(fn str? [x]
  "Check if given parameter is a string"
  (= :string (type x)))

(fn includes? [xs x]
  "Check if given parameter exists in given list"
  (accumulate [is? false _ v (ipairs xs) :until is?]
   (= v x)))

(λ set! [name value]
  "Set a Neovim option using the Lua API"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)]
    `(tset vim.opt ,name ,value)))

(λ let! [name value]
  "Set a Neovim variable using the Lua API"
  (assert-compile (or (sym? name) (str? name))
                  "expected symbol or string for name" name)
  (let [name (->str name)
        scope (when (includes? [:g. :b. :w. :t. "g:" "b:" "w:" "t:"]
                               (name:sub 1 2))
                (name:sub 1 1))
        name (name:sub 3)]
    `(tset ,(match scope
              :g `vim.g
              :b `vim.b
              :w `vim.w
              :t `vim.t) ,name ,value)))

(λ set-local! [name value]
  " Set a Neovim option (local to buffer) using the Lua API"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)]
    `(tset vim.opt_local ,name ,value)))

{: set!
 : let!
 : set-local!}
