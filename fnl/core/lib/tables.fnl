(fn deep-copy [x]
  "Creates a deep copy of the given value.
  
  Arguments:
  * `x`: the value to copy
  
  Returns:
  * the deep copy of the value
  
  Example:
  ```fennel
  (let [t {a: {b: 1}}]
    (assert (not (= t (deep-copy t))))
    (assert (not (= (. t \"a\") (deep-copy (. t \"a\")))))
    (assert (= (deep-copy \"hello\") \"hello\")))
  ```"
  (if (= :table (type x))
      (collect [k v (pairs x)]
        (values (deep-copy k) (deep-copy v)))
      x))

(fn deep-merge [x1 x2]
  "Merges two tables recursively.
  
  Arguments:
  * `x1`: the first table to merge
  * `x2`: the second table to merge
  
  Returns:
  * a new table containing the merged values
  
  Example:
  ```fennel
  (assert (= (deep-merge {a: 1, b: {c: 2, d: 3}} {b: {d: 4, e: 5}}) {a: 1, b: {c: 2, d: 4, e: 5}}))
  ```"
  (match [x1 x2]
    [nil nil] nil
    [nil _] (deep-copy x2)
    [_ nil] (deep-copy x1)
    (where _ (or (not (= :table (type x1))) (not (= :table (type x2)))))
    (deep-copy x1)
    _ (accumulate [acc (deep-copy x1) k v (pairs x2)]
        (doto acc
          (tset k (deep-merge v (?. acc k)))))))

{: deep-copy : deep-merge}
