(local {: autoload} (require :core.lib.autoload))

(fn nil? [x]
  (= nil x))

(fn str? [x]
  (= :string (type x)))

(fn num? [x]
  (= :number (type x)))

(fn bool? [x]
  (= :boolean (type x)))

(fn fn? [x]
  (= :function (type x)))

(fn tbl? [x]
  (= :table (type x)))

(fn ->str [x]
  (tostring x))

(fn ->bool [x]
  (if x true false))

(fn keys [t]
  (let [result []]
    (when t
      (each [k _ (pairs t)]
        (table.insert result k)))
    result))

(fn empty? [xs]
  "Check if given table is empty"
  (= 0 (length xs)))

(fn first [xs]
  "Get the first element in a list"
  (. xs 1))

(fn second [xs]
  "Get the second element in a list"
  (. xs 2))

(fn last [xs]
  "Get the last element in a list"
  (. xs (length xs)))

(fn count [xs]
  "Count the number of items in a table"
  (if (tbl? xs)
      (let [maxn (table.maxn xs)]
        (if (= 0 maxn)
            (table.maxn (keys xs))
            maxn))
      (not xs)
      0
      (length xs)))

(fn any? [pred xs]
  (accumulate [any? false _ v (ipairs xs) &until any?]
    (pred v)))

(fn all? [pred xs]
  (not (any? #(not (pred $)) xs)))

(fn contains? [xs x]
  (any? #(= $ x) xs))

(fn flatten [x ?levels]
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
            (doto output (table.insert v))))
      x))

(fn begins-with? [chars str]
  "Return whether str begins with chars."
  (->bool (str:match (.. "^" chars))))

(fn rand [n]
  "Draw a random floating point number between 0 and `n`, where `n` is 1.0 if omitted."
  (* (math.random) (or n 1)))

(fn ++ [n]
  "Increment n by 1."
  (+ n 1))

(fn -- [n]
  "Decrement n by 1."
  (- n 1))

(fn even? [n]
  (= (% n 2) 0))

(fn odd? [n]
  (not (even? n)))

(fn vals [t]
  "Get all values of a table."
  (let [result []]
    (when t
      (each [_ v (pairs t)]
        (table.insert result v)))
    result))

(fn kv-pairs [t]
  "Get all keys and values of a table zipped up in pairs."
  (let [result []]
    (when t
      (each [k v (pairs t)]
        (table.insert result [k v])))
    result))

(fn run! [f xs]
  "Execute the function (for side effects) for every xs."
  (when xs
    (let [nxs (count xs)]
      (when (> nxs 0)
        (for [i 1 nxs]
          (f (. xs i)))))))

(fn filter [f xs]
  "Filter xs down to a new sequential table containing every value that (f x) returned true for."
  (let [result []]
    (run! (fn [x]
            (when (f x)
              (table.insert result x))) xs)
    result))

(fn map [f xs]
  "p xs to a new sequential table by calling (f x) on each item."
  (let [result []]
    (run! (fn [x]
            (let [mapped (f x)]
              (table.insert result
                            (if (= 0 (select "#" mapped))
                                nil
                                mapped)))) xs)
    result))

(fn map-indexed [f xs]
  "p xs to a new sequential table by calling (f [k v]) on each item. "
  (map f (kv-pairs xs)))

(fn identity [x]
  "Returns what you pass it."
  x)

(fn reduce [f init xs]
  "Reduce xs into a result by passing each subsequent value into the fn with
  the previous value as the first arg. Starting with init."
  (var result init)
  (run! (fn [x]
          (set result (f result x))) xs)
  result)

(fn some [f xs]
  "Return the first truthy result from (f x) or nil."
  (var result nil)
  (var n 1)
  (while (and (nil? result) (<= n (count xs)))
    (let [candidate (f (. xs n))]
      (when candidate
        (set result candidate))
      (set n (++ n))))
  result)

(fn butlast [xs]
  (let [total (count xs)]
    (->> (kv-pairs xs)
         (filter (fn [[n v]]
                   (not= n total)))
         (map second))))

(fn rest [xs]
  (->> (kv-pairs xs)
       (filter (fn [[n v]]
                 (not= n 1)))
       (map second)))

(fn select-keys [t ks]
  (if (and t ks)
      (reduce (fn [acc k]
                (when k
                  (tset acc k (. t k)))
                acc) {} ks)
      {}))

(fn get [t k d]
  (let [res (when (tbl? t)
              (let [val (. t k)]
                (when (not (nil? val))
                  val)))]
    (if (nil? res)
        d
        res)))

(fn get-in [t ks d]
  (let [res (reduce (fn [acc k]
                      (when (tbl? acc)
                        (get acc k))) t ks)]
    (if (nil? res)
        d
        res)))

(fn assoc [t ...]
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
  (assoc t k (f (get t k))))

(fn update-in [t ks f]
  (assoc-in t ks (f (get-in t ks))))

{: nil?
 : str?
 : num?
 : bool?
 : fn?
 : tbl?
 : ->str
 : ->bool
 : keys
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
 : identity
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
