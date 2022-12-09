(local {: tbl?} (require :core.lib))

(fn tset-default [table key default]
  (when (= nil (. table key))
    (tset table key default))
  (. table key))

(fn deep-copy [x]
  (if (tbl? x) (collect [k v (pairs x)]
                 (values (deep-copy k) (deep-copy v))) x))

(fn deep-merge [x1 x2]
  (match [x1 x2]
    [nil nil] nil
    [nil _] (deep-copy x2)
    [_ nil] (deep-copy x1)
    (where _ (or (not (tbl? x1)) (not (tbl? x2)))) (deep-copy x1)
    _ (accumulate [acc (deep-copy x1) k v (pairs x2)]
        (doto acc
          (tset k (deep-merge v (?. acc k)))))))

(fn tbl-clone [t]
  (let [clone {}]
    (each [k v (pairs t)]
      (tset clone k v))
    clone))

(fn tbl-set [t table-path value]
  (let [keys (or (and (= (type table-path) :table) table-path)
                 (vim.split table-path "." {:plain true}))]
    (var cur t)
    (for [i 1 (- (length keys) 1)]
      (local k (. keys i))
      (when (not (. cur k))
        (tset cur k {}))
      (set cur (. cur k)))
    (tset cur (. keys (length keys)) value)))

(fn tbl-path-access [t table-path]
  (let [keys (or (and (= (type table-path) :table) table-path)
                 (vim.split table-path "." {:plain true}))]
    (var cur t)
    (each [_ k (ipairs keys)]
      (set cur (. cur k))
      (when (not cur)
        (lua "return nil")))
    cur))

(fn tbl-path-ensure [t table-path]
  (let [keys (or (and (= (type table-path) :table) table-path)
                 (vim.split table-path "." {:plain true}))]
    (when (not (tbl-path-access t keys))
      (tbl-set t keys {}))))

(fn vec-join [...]
  (let [result {}
        args [...]]
    (var c 0)
    (for [i 1 (select "#" ...)]
      (when (not= (type (. args i)) :nil)
        (if (not= (type (. args i)) :table)
            (do
              (tset result (+ c 1) (. args i))
              (set c (+ c 1)))
            (do
              (each [j v (ipairs (. args i))]
                (tset result (+ c j) v))
              (set c (+ c (length (. args i))))))))
    result))

(fn vec-union [...]
  (let [result {}
        args [...]
        seen {}]
    (for [i 1 (select "#" ...)]
      (when (not= (type (. args i)) :nil)
        (if (and (not= (type (. args i)) :table) (not (. seen (. args i))))
            (do
              (tset seen (. args i) true)
              (tset result (+ (length result) 1) (. args i)))
            (each [_ v (ipairs (. args i))]
              (when (not (. seen v))
                (tset seen v true)
                (tset result (+ (length result) 1) v))))))
    result))

(fn vec-diff [...]
  (let [args [...]
        seen {}]
    (for [i 1 (select "#" ...)]
      (when (not= (type (. args i)) :nil)
        (if (not= (type (. args i)) :table)
            (if (= i 1) (tset seen (. args i) true)
                (. seen (. args i)) (tset seen (. args i) nil))
            (each [_ v (ipairs (. args i))]
              (if (= i 1) (tset seen v true)
                  (. seen v) (tset seen v nil))))))
    (vim.tbl_keys seen)))

(fn tbl-union-extend [t ...]
  (var res (tbl-clone t))

  (fn recurse [ours theirs]
    (let [sub (vec-union ours theirs)]
      (each [k v (pairs ours)]
        (when (not= (type k) :number)
          (tset sub k v)))
      (each [k v (pairs theirs)]
        (when (not= (type k) :number)
          (if (= (type v) :table) (tset sub k (recurse (or (. sub k) {}) v))
              (tset sub k v))))
      sub))

  (each [_ theirs (ipairs [...])]
    (set res (recurse res theirs)))
  res)

{: tset-default
 : deep-copy
 : deep-merge
 : tbl-clone
 : tbl-set
 : tbl-path-access
 : tbl-path-ensure
 : vec-join
 : vec-union
 : vec-diff
 : tbl-union-extend}
