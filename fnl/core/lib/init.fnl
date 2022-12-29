(local stdlib {})
;; load modified luafun + core libs by default

(local fun (require :core.lib.fun))
(each [k v (pairs fun)]
  (tset stdlib k v))

(local autoload (require :core.lib.autoload))
(each [k v (pairs autoload)]
  (tset stdlib k v))

(local tables (require :core.lib.tables))
(each [k v (pairs tables)]
  (tset stdlib k v))

(local setup (require :core.lib.setup))
(each [k v (pairs setup)]
  (tset stdlib k v))

(local io (require :core.lib.io))
(each [k v (pairs io)]
  (tset stdlib k v))

;; lazy load crypt/colorutils/profile

(tset stdlib :crypt (autoload.autoload :core.lib.crypt))
(tset stdlib :colorutils (autoload.autoload :core.lib.color))
(tset stdlib :profile (autoload.autoload :core.lib.profile))

(fn stdlib.nil? [x]
  "Returns true if the given value is nil, false otherwise.
  Arguments:
  * `x`: a value

  Example:
  ```fennel
  (assert (= (nil? nil) true))
  (assert (= (nil? 1) false))
  ```"
  (= nil x))

(fn stdlib.str? [x]
  "Returns true if the given value is a string, false otherwise.
  Arguments:
  * `x`: a value

  Example:
  ```fennel
  (assert (= (str? \"hello world\") true))
  (assert (= (str? 1) false))
  ```"
  (= :string (type x)))

(fn stdlib.num? [x]
  "Returns true if the given value is a number, false otherwise.
  Arguments:
  * `x`: a value

  Example:
  ```fennel
  (assert (= (num? 1) true))
  (assert (= (num? \"hello world\") false))
  ```"
  (= :number (type x)))

(fn stdlib.bool? [x]
  "Returns true if the given value is a boolean, false otherwise.
  Arguments:
  * `x`: a value

  Example:
  ```fennel
  (assert (= (bool? true) true))
  (assert (= (bool? \"hello\") false))
  ```"
  (= :boolean (type x)))

(fn stdlib.fn? [x]
  "Returns true if the given value is a function, false otherwise.
  Arguments:
  * `x`: a value

  Example:
  ```fennel
  (assert (= (fn? (fn [])) true))
  (assert (= (fn? \"hello world\") false))
  ```"
  (= :function (type x)))

(fn stdlib.executable? [...]
  "Returns true if the input is executable, false otherwise.
  Arguments:
  * `...`: a string

  Example:
  ```fennel
  (assert (= (executable? :python3) true))
  (assert (= (executable? :python3) false))
  ```"
  (= 1 (vim.fn.executable ...)))

(fn stdlib.nightly? []
  "Returns true if the given neovim is of version 0.9, false otherwise.

  Example:
  ```fennel
  (assert (= (nightly?) true))
  (assert (= (nightly?) false))
  ```"
  (let [nightly (vim.fn.has :nvim-0.9.0)]
    (= nightly 1)))

(fn stdlib.headless? []
  "Returns true if the current instance is running headless, false otherwise.

  Example:
  ```fennel
  (assert (= (headless?) true))
  (assert (= (headless?) false))
  ```"
  (= (length (vim.api.nvim_list_uis)) 0))

(fn stdlib.->str [x]
  "Converts `x` to a string.

  Arguments:
  * `x`: the value to convert to a string

  Example:
  ```fennel
  (assert (= (->str {a: 1, b: 2}) \"{a: 1, b: 2}\"))
  (assert (= (->str 123) \"123\"))
  ```"
  (tostring x))

(fn stdlib.->bool [x]
  "Converts `x` to a boolean.

  Arguments:
  * `x`: the value to convert to a boolean

  Example:
  (assert (= (->bool 1) true))
  (assert (= (->bool 0) false))
  (assert (= (->bool \"hello\") true))
  (assert (= (->bool "
  ") false))\n  ```"
  (if x true false))

(fn stdlib.empty? [xs]
  "Returns true if the given list is empty, false otherwise.
  Arguments:
  * `xs`: a list

  Example:
  ```fennel
  (assert (= (empty? []) true))
  (assert (= (empty? [1, 2, 3]) false))
  ```"
  (= 0 (length xs)))

(fn stdlib.contains? [xs x]
  "Returns `true` if `xs` contains the value `x`, `false` otherwise.

  Arguments:
  * `xs`: the list or table to check
  * `x`: the value to search for

  Example:
  ```fennel
  (assert (= (contains? [1, 2, 3, 4, 5] 3) true))
  (assert (= (contains? [1, 2, 3, 4, 5] 6) false))
  ```"
  (fun.any #(= $ x) xs))

(fn stdlib.truncate [num digits]
  "Truncates a value to a given number of digits.

  Arguments:
  * `num`: the value to truncate.
  * `digits`: the number of digits to truncate to.

  Example:
  ```fennel
  (assert (= (truncate .123456 3) .123)
  ```"
  (let [mult (^ 10 digits)]
    (/ (math.modf (* num mult)) mult)))

(fn stdlib.begins-with? [chars str]
  "Returns `true` if the string `str` begins with the characters in `chars`, `false` otherwise.

  Arguments:
  * `chars`: the characters to check for at the beginning of `str`
  * `str`: the string to check

  Example:
  ```fennel
  (assert (= (begins-with? \"hello\" \"hello, world!\") true)
  (assert (= (begins-with? \"hey\" \"hello, world!\") false)
  ```"
  (stdlib.->bool (str:match (.. "^" chars))))

(fn stdlib.rand [n]
  "Draws a random floating point number between 0 and `n`, where `n` is 1.0 if omitted.

  Arguments:
  * `n`: optional, the maximum value of the random number to generate. Defaults to 1.0 if not provided.

  Example:
  ```fennel
  (assert (> (rand) 0))
  (assert (< (rand) 1))
  (assert (> (rand 2) 0))
  (assert (< (rand 2) 2))
  ```"
  (* (math.random) (or n 1)))

(fn stdlib.++ [n]
  "Increments `n` by 1 and returns the result.

  Arguments:
  * `n`: the number to increment

  Example:
  ```fennel
  (assert (= (++ 3) 4)
  (assert (= (++ 1) 2)
  ```"
  (+ n 1))

(fn stdlib.-- [n]
  "Decrements `n` by 1 and returns the result.

  Arguments:
  * `n`: the number to decrement

  Example:
  ```fennel
  (assert (= (-- 3) 2)
  (assert (= (-- 1) 0)
  ```"
  (- n 1))

(fn stdlib.even? [n]
  "Returns `true` if `n` is an even number, `false` otherwise.

  Arguments:
  * `n`: the number to check

  Example:
  ```fennel
  (assert (= (even? 2) true)
  (assert (= (even? 3) false)
  ```"
  (= (% n 2) 0))

(fn stdlib.odd? [n]
  "Returns `true` if `n` is an odd number, `false` otherwise.

  Arguments:
  * `n`: the number to check

  Example:
  ```fennel
  (assert (= (odd? 2) false)
  (assert (= (odd? 3) true)
  ```"
  (not (stdlib.even? n)))

(fn stdlib.vals [t]
  "Returns a list of all values in the given table.

  Arguments:
  * `t`: the table to get the values from

  Example:
  ```fennel
  (assert (= (vals {a: 1, b: 2}) {1, 2}))
  ```"
  (let [result []]
    (each [_ v (fun.iter-pairs t)]
      (table.insert result v))
    result))

(fn stdlib.kv-pairs [t]
  "Returns a list of all key-value pairs in the given table.
  
  Arguments:
  * `t`: the table to get the key-value pairs from
  Example:
  ```fennel
  (assert (= (kv-pairs {a: 1, b: 2}) {{a: 1}, {b: 2}}))
  ```"
  (let [result []]
    (when t
      (each [k v (pairs t)]
        (table.insert result [k v])))
    result))

(fn stdlib.map-indexed [f xs]
  "Returns a new list containing the result of calling the function `f` on each key-value pair in the list `xs`.

  Arguments:
  * `f`: the function to apply to each key-value pair in `xs`
  * `xs`: the list of items to apply `f` to

  Example:
  ```fennel
  (assert (= (map-indexed (fn [[k v]] [k (+ v 1)]) {a: 1, b: 2}) {{a: 2}, {b: 3}}))
  ```"
  (fun.map f (stdlib.kv-pairs xs)))

(fn stdlib.butlast [xs]
  "Returns a new list containing all items in the list `xs` except for the last item.

  Arguments:
  * `xs`: the list of items to return

  Example:
  ```fennel
  (assert (= (butlast [1, 2, 3, 4]) [1, 2, 3]))
  ```"
  (let [total (length xs)]
    (->> (stdlib.kv-pairs xs)
         (fun.filter (fn [[n v]]
                       (not= n total)))
         (fun.map nth 2))))

(fn stdlib.rest [xs]
  "Returns a new list containing all items in the list `xs` except for the first item.

  Arguments:
  * `xs`: the list of items to return

  Example:
  ```fennel
  (assert (= (rest [1, 2, 3, 4]) [2, 3, 4]))
  ```"
  (->> (stdlib.kv-pairs xs)
       (fun.filter (fn [[n v]]
                     (not= n 1)))
       (fun.map nth 2)))

(fn stdlib.select-keys [t ks]
  "Returns a new table containing the key-value pairs in the table `t` with keys in the list `ks`.

  Arguments:
  * `t`: the table to select key-value pairs from
  * `ks`: the list of keys to select

  Example:
  ```fennel
  (assert (= (select-keys {a: 1, b: 2, c: 3} {'b', 'c'}) {b: 2, c: 3}))
  ```"
  (if (and t ks)
      (fun.reduce (fn [acc k]
                    (when k
                      (tset acc k (. t k)))
                    acc) {} ks)
      {}))

(fn stdlib.get [t k d]
  "Returns the value associated with `k` in the table `t`, or `d` if `k` is not present in `t`.

  Arguments:
  * `t`: the table to get the value from
  * `k`: the key to look up in the table
  * `d`: the default value to return if `k` is not present in `t`

  Example:
  ```fennel
  (assert (= (get {a: 1, b: 2, c: 3} 'b' 0) 2))
  (assert (= (get {a: 1, b: 2, c: 3} 'd' 0) 0))
  ```"
  (let [res (when (table? t)
              (let [val (. t k)]
                (when (not (stdlib.nil? val))
                  val)))]
    (if (stdlib.nil? res)
        d
        res)))

(fn stdlib.get-in [t ks d]
  "Returns the value associated with the sequence of keys `ks` in the nested table `t`, or `d` if the sequence of keys is not present in `t`.

  Arguments:
  * `t`: the nested table to get the value from
  * `ks`: the sequence of keys to look up in the nested table
  * `d`: the default value to return if the sequence of keys is not present in `t`

  Example:
  ```fennel
  (assert (= (get-in {a: {b: {c: 1}}} {'a', 'b', 'c'} 0) 1))
  (assert (= (get-in {a: {b: {c: 1}}} {'a', 'b', 'd'} 0) 0))
  ```"
  (let [res (fun.reduce (fn [acc k]
                          (when (table? acc)
                            (stdlib.get acc k))) t ks)]
    (if (stdlib.nil? res)
        d
        res)))

(fn stdlib.assoc [t ...]
  "Returns a new table with the specified keys and values added or updated. If `t` is not provided, a new empty table is created.

  Arguments:
  * `t`: the table to add or update the specified keys and values in
  * `...`: alternating sequence of keys and values to be added or updated in the table

  Example:
  ```fennel
  (assert (= (assoc {a: 1, b: 2} 'c' 3 'd' 4) {a: 1, b: 2, c: 3, d: 4}))
  (assert (= (assoc {a: 1, b: 2} 'a' 5 'b' 6) {a: 5, b: 6}))
  ```"
  (let [[k v & xs] [...]
        rem (length xs)
        t (or t {})]
    (when (stdlib.odd? rem)
      (error "assoc expects even number of arguments after table, found odd number"))
    (when (not (stdlib.nil? k))
      (tset t k v))
    (when (> rem 0)
      (stdlib.assoc t (unpack xs)))
    t))

(fn stdlib.assoc-in [t ks v]
  "Returns a new table with a value at a nested path of keys in the original table. If any keys in the path do not exist, new tables are created as needed.

  Arguments:
  * `t`: the table to add or update the value at the nested path in
  * `ks`: a sequential table of keys representing the nested path to the value in the table
  * `v`: the value to be added or updated at the specified nested path in the table

  Example:
  ```fennel
  (assert (= (assoc-in {a: {b: {c: 1}}} {'a', 'b', 'd'} 2) {a: {b: {c: 1, d: 2}}}))
  (assert (= (assoc-in {a: {b: {c: 1}}} {'a', 'c', 'd'} 2) {a: {b: {c: 1}, c: {d: 2}}}))
  ```"
  (let [path (stdlib.butlast ks)
        final (fun.cdr ks)
        t (or t {})]
    (stdlib.assoc (fun.reduce (fn [acc k]
                                (let [step (stdlib.get acc k)]
                                  (if (nil? step)
                                      (stdlib.get (stdlib.assoc acc k {}) k)
                                      step))) t
                              path) final v)
    t))

(fn stdlib.update [t k f]
  "Returns a new table with a value at a given key in the original table transformed by a function.

  Arguments:
  * `t`: the table to update the value at the given key in
  * `k`: the key in the table to update the value at
  * `f`: the function to transform the value at the given key

  Example:
  ```fennel
  (assert (= (update {a: 1, b: 2} 'a' #(* $ 2)) {a: 2, b: 2}))
  (assert (= (update {a: 1, b: 2} 'c' #(* $ 2)) {a: 1, b: 2, c: nil}))
  ```"
  (stdlib.assoc t k (f (stdlib.get t k))))

(fn stdlib.update-in [t ks f]
  "Update a value at a given path in a table by applying a function to it.
  Arguments:
  * `t`: a table
  * `ks`: a sequence of keys representing the path in the table
  * `f`: a function that takes the current value at the path and returns a new value

  Example:
  ```fennel
  (assert (= (update-in {a: {b: 1}} {'a', 'b'} inc) {a: {b: 2}}))
  ```"
  (let [path (stdlib.butlast ks)
        final (fun.cdr ks)
        t (or t {})]
    (stdlib.assoc (fun.reduce (fn [acc k]
                                (let [step (stdlib.get acc k)]
                                  (if (stdlib.nil? step)
                                      (stdlib.get (stdlib.assoc acc k {}) k)
                                      step))) t
                              path) final
                  (f (stdlib.get-in t ks)))
    t))

stdlib
