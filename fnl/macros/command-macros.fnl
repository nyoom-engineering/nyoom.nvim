(local {: format} string)

(fn empty? [xs]
  (= 0 (length xs)))

(fn nil? [x]
  (= nil x))

(fn str? [x]
  (= :string (type x)))

(fn ->str [x]
  (tostring x))

(fn head [xs]
  (. xs 1))

(fn fn? [x]
  "Returns whether the parameter(s) is a function.
  A function is defined as any list with 'fn or 'hashfn as their first
  element."
  (and
    (list? x)
    (or (= 'fn (head x))
        (= 'hashfn (head x)))))

(λ command! [name expr ?desc]
  "Define a user command using the lua API.
  See the help for nvim_add_user_command for more information."
  (assert-compile (or (str? name) (sym? name)) "expected string or symbol for name" name)
  (assert-compile (or (str? expr) (fn? expr) (sym? expr)) "expected string or function or symbol for expr" expr)
  (assert-compile (or (nil? ?desc) (str? ?desc)) "expected string or nil for description" ?desc)
  (let [name (->str name)
        desc (if (and (not ?desc) (or (fn? expr) (sym? expr))) (view expr)
               ?desc)]
    `(vim.api.nvim_create_user_command ,name ,expr {:desc ,desc})))

(λ local-command! [name expr ?desc]
  "Define a user command using the lua API.
  See the help for nvim_add_user_command for more information."
  (assert-compile (or (str? name) (sym? name)) "expected string or symbol for name" name)
  (assert-compile (or (str? expr) (fn? expr) (sym? expr)) "expected string or function or symbol for expr" expr)
  (assert-compile (or (nil? ?desc) (str? ?desc)) "expected string or nil for description" ?desc)
  (let [name (->str name)
        desc (if (and (not ?desc) (or (fn? expr) (sym? expr))) (view expr)
               ?desc)]
    `(vim.api.nvim_buf_create_user_command ,name ,expr {:desc ,desc})))

{: command!
 : local-command!}
