(fn table? [x]
  (= :table (type x)))

(fn deep-copy [x]
  (if (table? x) (collect [k v (pairs x)]
                   (values (deep-copy k) (deep-copy v)))
    x))

(fn deep-merge [x1 x2]
  (match [x1 x2]
    [nil nil] nil
    [nil _] (deep-copy x2)
    [_ nil] (deep-copy x1)
    (where _ (or (not (table? x1))
                 (not (table? x2)))) (deep-copy x1)
    _ (accumulate [acc (deep-copy x1)
                   k v (pairs x2)]
        (doto acc
              (tset k (deep-merge v (?. acc k)))))))

{: deep-copy
 : deep-merge}
