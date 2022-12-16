(fn nil? [x]
  "Returns true if the given value is nil, false otherwise.
  Arguments:
  * `x`: a value
  
  Example:
  ```fennel
  (assert (= (nil? nil) true))
  (assert (= (nil? 1) false))
  ```"
  (= nil x))

(fn str? [x]
  "Returns true if the given value is a string, false otherwise.
  Arguments:
  * `x`: a value
  
  Example:
  ```fennel
  (assert (= (str? \"hello world\") true))
  (assert (= (str? 1) false))
  ```"
  (= :string (type x)))

(fn num? [x]
  "Returns true if the given value is a number, false otherwise.
  Arguments:
  * `x`: a value
  
  Example:
  ```fennel
  (assert (= (num? 1) true))
  (assert (= (num? \"hello world\") false))
  ```"
  (= :number (type x)))

(fn bool? [x]
  "Returns true if the given value is a boolean, false otherwise.
  Arguments:
  * `x`: a value
  
  Example:
  ```fennel
  (assert (= (bool? true) true))
  (assert (= (bool? \"hello\") false))
  ```"
  (= :boolean (type x)))

(fn fn? [x]
  "Returns true if the given value is a function, false otherwise.
  Arguments:
  * `x`: a value
  
  Example:
  ```fennel
  (assert (= (fn? (fn [])) true))
  (assert (= (fn? \"hello world\") false))
  ```"
  (= :function (type x)))

(fn tbl? [x]
  "Returns `true` if `x` is a table, `false` otherwise.
  Arguments:
  * `x`: the value to check

  Example:
  ```fennel
  (assert (= (tbl? {a: 1, b: 2}) true))
  (assert (= (tbl? 'hello') false))
  ```"
  (= :table (type x)))
  
(fn executable? [...]
  "Returns true if the input is executable, false otherwise.
  Arguments:
  * `...`: a string
  
  Example:
  ```fennel
  (assert (= (executable? :python3) true))
  (assert (= (executable? :python3) false))
  ```"
  (= 1 (vim.fn.executable ...)))

(fn nightly? []
  "Returns true if the given neovim is of version 0.9, false otherwise.
  
  Example:
  ```fennel
  (assert (= (nightly?) true))
  (assert (= (nightly?) false))
  ```"
  (let [nightly (vim.fn.has :nvim-0.9.0)]
    (= nightly 1))) 

(fn ->str [x]
  "Converts `x` to a string.

  Arguments:
  * `x`: the value to convert to a string

  Example:
  ```fennel
  (assert (= (->str {a: 1, b: 2}) \"{a: 1, b: 2}\"))
  (assert (= (->str 123) \"123\"))
  ```"
  (tostring x))

(fn ->bool [x]
  (if x true false))

(fn ->bool [x]
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

(fn empty? [xs]
  "Returns true if the given list is empty, false otherwise.
  Arguments:
  * `xs`: a list
  
  Example:
  ```fennel
  (assert (= (empty? []) true))
  (assert (= (empty? [1, 2, 3]) false))
  ```"
  (= 0 (length xs)))

(fn first [xs]
  "Returns the first element in the given list.
  Arguments:
  * `xs`: a list
  
  Example:
  ```fennel
  (assert (= (first [1, 2, 3]) 1))
  ```"
  (. xs 1))

(fn second [xs]
  "Returns the second element in the given list.
  Arguments:
  * `xs`: a list
  
  Example:
  ```fennel
  (assert (= (second [1, 2, 3]) 2))
  ```"
  (. xs 2))

(fn last [xs]
  "Returns the last element in the given list.
  Arguments:
  * `xs`: a list
  
  Example:
  ```fennel
  (assert (= (last [1, 2, 3]) 3))
  ```"
  (. xs (length xs)))

(fn any? [pred xs]
  "Returns `true` if `pred` returns `true` for any value in `xs`, `false` otherwise.
  
  Arguments:
  * `pred`: the predicate function to apply to each value in `xs`
  * `xs`: the list or table to check

  Example:
  ```fennel
  (assert (= (any? (fn [x] (= x 3)) [1, 2, 3, 4, 5]) true))
  (assert (= (any? (fn [x] (= x 6)) [1, 2, 3, 4, 5]) false))
  ```"
  (accumulate [any? false _ v (ipairs xs) &until any?]
    (pred v)))

(fn all? [pred xs]
  "Returns `true` if `pred` returns `true` for all values in `xs`, `false` otherwise.
  
  Arguments:
  * `pred`: the predicate function to apply to each value in `xs`
  * `xs`: the list or table to check

  Example:
  ```fennel
  (assert (= (all? (fn [x] (> x 0)) [1, 2, 3, 4, 5]) true))
  (assert (= (all? (fn [x] (> x 3)) [1, 2, 3, 4, 5]) false))
  ```"
  (not (any? #(not (pred $)) xs)))

(fn contains? [xs x]
  "Returns `true` if `xs` contains the value `x`, `false` otherwise.
  
  Arguments:
  * `xs`: the list or table to check
  * `x`: the value to search for

  Example:
  ```fennel
  (assert (= (contains? [1, 2, 3, 4, 5] 3) true))
  (assert (= (contains? [1, 2, 3, 4, 5] 6) false))
  ```"
  (any? #(= $ x) xs))

(fn flatten [x ?levels]
  "Flattens a nested table into a single-dimensional table.
  
  Arguments:
  * `x`: the table to flatten
  * `levels`: optional, the number of levels of nested tables to flatten. If not provided or `nil`, all levels will be flattened.

  Example:
  ```fennel
  (assert (= (flatten {{a: 1}, {b: 2, c: 3}}) {a: 1, b: 2, c: 3}))
  (assert (= (flatten {{{a: 1}, {b: 2}}, {{c: 3}, {d: 4}}}) {a: 1, b: 2, c: 3, d: 4}))
  (assert (= (flatten {{{a: 1}, {b: 2}}, {{c: 3}, {d: 4}}}, 1) {{a: 1}, {b: 2}, {c: 3}, {d: 4}}))
  ```"
  (assert (tbl? x) "expected tbl for x")
  (assert (or (nil? ?levels) (num? ?levels))
          "expected number or nil for levels")
  (if (or (nil? ?levels) (> ?levels 0))
      (accumulate [output [] _ v (ipairs x)]
        (if (tbl? v)
            (icollect [_ v (ipairs (flatten v
                                            (if (nil? ?levels) nil
                                                (- ?levels 1)))) &into output]
              v)
            (doto output
              (table.insert v))))
      x))

(fn begins-with? [chars str]
  "Returns `true` if the string `str` begins with the characters in `chars`, `false` otherwise.
  
  Arguments:
  * `chars`: the characters to check for at the beginning of `str`
  * `str`: the string to check

  Example:
  ```fennel
  (assert (= (begins-with? \"hello\" \"hello, world!\") true)
  (assert (= (begins-with? \"hey\" \"hello, world!\") false)
  ```"
  (->bool (str:match (.. "^" chars))))

(fn rand [n]
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

(fn ++ [n]
  "Increments `n` by 1 and returns the result.
  
  Arguments:
  * `n`: the number to increment

  Example:
  ```fennel
  (assert (= (++ 3) 4)
  (assert (= (++ 1) 2)
  ```"
  (+ n 1))

(fn -- [n]
  "Decrements `n` by 1 and returns the result.
  
  Arguments:
  * `n`: the number to decrement

  Example:
  ```fennel
  (assert (= (-- 3) 2)
  (assert (= (-- 1) 0)
  ```"
  (- n 1))

(fn even? [n]
  "Returns `true` if `n` is an even number, `false` otherwise.
  
  Arguments:
  * `n`: the number to check

  Example:
  ```fennel
  (assert (= (even? 2) true)
  (assert (= (even? 3) false)
  ```"
  (= (% n 2) 0))

(fn odd? [n]
  "Returns `true` if `n` is an odd number, `false` otherwise.
  
  Arguments:
  * `n`: the number to check

  Example:
  ```fennel
  (assert (= (odd? 2) false)
  (assert (= (odd? 3) true)
  ```"
  (not (even? n)))

(fn vals [t]
  "Returns a list of all values in the given table.
  
  Arguments:
  * `t`: the table to get the values from

  Example:
  ```fennel
  (assert (= (vals {a: 1, b: 2}) {1, 2}))
  ```"
  (let [result []]
    (when t
      (each [_ v (pairs t)]
        (table.insert result v)))
    result))

(fn kv-pairs [t]
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

(fn count [xs]
  "Counts the number of items in a table. If `xs` is not a table, returns the length of the given value.
  Arguments:
  * `xs`: the value to count items in

  Example:
  ```fennel
  (assert (= (count {a: 1, b: 2, c: 3}) 3))
  (assert (= (count 'hello') 5))
  ```"
  (if (tbl? xs)
      (let [maxn (table.maxn xs)]
        (if (= 0 maxn)
            (table.maxn (kv-pairs xs))
            maxn))
      (if (not xs) 0 (length xs))))

(fn run! [f xs]
  "Executes the function `f` for every item in the list `xs`. This function is intended for side effects only and does not return any value.
  
  Arguments:
  * `f`: the function to execute for each item in `xs`
  * `xs`: the list of items to execute `f` on

  Example:
  ```fennel
  (let [items [1, 2, 3]]
    (run! print items))
  ```"
  (when xs
    (let [nxs (count xs)]
      (when (> nxs 0)
        (for [i 1 nxs]
          (f (. xs i)))))))

(fn filter [f xs]
  "Returns a new list containing only the items from `xs` for which the function `f` returns `true`.
  
  Arguments:
  * `f`: the function to use for filtering the items in `xs`
  * `xs`: the list of items to filter

  Example:
  ```fennel
  (assert (= (filter even? [1, 2, 3, 4, 5, 6]) {2, 4, 6}))
  ```"
  (let [result []]
    (run! (fn [x]
            (when (f x)
              (table.insert result x))) xs)
    result))

(fn map [f xs]
  "Returns a new list containing the result of calling the function `f` on each item in the list `xs`.
  
  Arguments:
  * `f`: the function to apply to each item in `xs`
  * `xs`: the list of items to apply `f` to

  Example:
  ```fennel
  (assert (= (map (fn [x] (+ x 1)) [1, 2, 3]) {2, 3, 4}))
  ```"
  (let [result []]
    (run! (fn [x]
            (let [mapped (f x)]
              (table.insert result
                            (if (= 0 (select "#" mapped))
                                nil
                                mapped)))) xs)
    result))

(fn map-indexed [f xs]
  "Returns a new list containing the result of calling the function `f` on each key-value pair in the list `xs`.
  
  Arguments:
  * `f`: the function to apply to each key-value pair in `xs`
  * `xs`: the list of items to apply `f` to

  Example:
  ```fennel
  (assert (= (map-indexed (fn [[k v]] [k (+ v 1)]) {a: 1, b: 2}) {{a: 2}, {b: 3}}))
  ```"
  (map f (kv-pairs xs)))

(fn reduce [f init xs]
  "Reduces the list `xs` into a single value by applying the function `f` to each item in the list, starting with the initial value `init`.
  
  Arguments:
  * `f`: the function to apply to each item in `xs`
  * `init`: the initial value to use for the reduction
  * `xs`: the list of items to reduce

  Example:
  ```fennel
  (assert (= (reduce (fn [acc x] (+ acc x)) 0 [1, 2, 3, 4]) 10))
  ```"
  (var result init)
  (run! (fn [x]
          (set result (f result x))) xs)
  result)

(fn some [f xs]
  "Returns the first truthy result from calling the function `f` on each item in the list `xs`, or `nil` if there are no truthy results.
  
  Arguments:
  * `f`: the function to apply to each item in `xs`
  * `xs`: the list of items to apply `f` to

  Example:
  ```fennel
  (assert (= (some (fn [x] (if (= x 2) x)) [1, 2, 3]) 2))
  ```"
  (var result nil)
  (var n 1)
  (while (and (nil? result) (<= n (count xs)))
    (let [candidate (f (. xs n))]
      (when candidate
        (set result candidate))
      (set n (++ n))))
  result)

(fn butlast [xs]
  "Returns a new list containing all items in the list `xs` except for the last item.
  
  Arguments:
  * `xs`: the list of items to return

  Example:
  ```fennel
  (assert (= (butlast [1, 2, 3, 4]) [1, 2, 3]))
  ```"
  (let [total (count xs)]
    (->> (kv-pairs xs)
         (filter (fn [[n v]]
                   (not= n total)))
         (map second))))

(fn rest [xs]
  "Returns a new list containing all items in the list `xs` except for the first item.
  
  Arguments:
  * `xs`: the list of items to return

  Example:
  ```fennel
  (assert (= (rest [1, 2, 3, 4]) [2, 3, 4]))
  ```"
  (->> (kv-pairs xs)
       (filter (fn [[n v]]
                 (not= n 1)))
       (map second)))

(fn select-keys [t ks]
  "Returns a new table containing the key-value pairs in the table `t` with keys in the list `ks`.
  
  Arguments:
  * `t`: the table to select key-value pairs from
  * `ks`: the list of keys to select

  Example:
  ```fennel
  (assert (= (select-keys {a: 1, b: 2, c: 3} {'b', 'c'}) {b: 2, c: 3}))
  ```"
  (if (and t ks)
      (reduce (fn [acc k]
                (when k
                  (tset acc k (. t k)))
                acc) {} ks)
      {}))

(fn get [t k d]
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
  (let [res (when (tbl? t)
              (let [val (. t k)]
                (when (not (nil? val))
                  val)))]
    (if (nil? res)
        d
        res)))

(fn get-in [t ks d]
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
  (let [res (reduce (fn [acc k]
                      (when (tbl? acc)
                        (get acc k))) t ks)]
    (if (nil? res)
        d
        res)))

(fn assoc [t ...]
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
        rem (count xs)
        t (or t {})]
    (when (odd? rem)
      (error "assoc expects even number of arguments after table, found odd number"))
    (when (not (nil? k))
      (tset t k v))
    (when (> rem 0)
      (assoc t (unpack xs)))
    t))

(fn assoc-in [t ks v]
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
  (let [path (butlast ks)
        final (last ks)
        t (or t {})]
    (assoc (reduce (fn [acc k]
                     (let [step (get acc k)]
                       (if (nil? step)
                           (get (assoc acc k {}) k)
                           step))) t path) final v)
    t))

(fn update [t k f]
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
  (assoc t k (f (get t k))))

(fn update-in [t ks f]
  "Update a value at a given path in a table by applying a function to it.
  Arguments:
  * `t`: a table
  * `ks`: a sequence of keys representing the path in the table
  * `f`: a function that takes the current value at the path and returns a new value

  Example:
  ```fennel
  (assert (= (update-in {a: {b: 1}} {'a', 'b'} inc) {a: {b: 2}}))
  ```"
  (let [path (butlast ks)
        final (last ks)
        t (or t {})]
    (assoc (reduce (fn [acc k]
                     (let [step (get acc k)]
                       (if (nil? step)
                           (get (assoc acc k {}) k)
                           step))) t path) final (f (get-in t ks)))
    t))    

{: nil?
 : str?
 : num?
 : bool?
 : fn?
 : tbl?
 : executable?
 : nightly?
 : ->str
 : ->bool
 : empty?
 : first
 : second
 : last
 : count
 : any?
 : all?
 : contains?
 : flatten
 : begins-with?
 : rand
 : ++
 : --
 : even?
 : odd?
 : vals
 : kv-pairs
 : run!
 : filter
 : map
 : map-indexed
 : reduce
 : some
 : butlast
 : rest
 : select-keys
 : get
 : get-in
 : assoc
 : assoc-in
 : update
 : update-in}
