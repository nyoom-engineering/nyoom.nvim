(local {: tbl? : nil? : num?} (require :macros.types-macros))

(λ empty? [xs]
  "Check if given table is empty"
  (assert-compile (tbl? xs) "expected table for xs" xs)
  (= 0 (length xs)))

(λ first [xs]
  "Get the first element in a list"
  (assert-compile (tbl? xs) "expected table for xs" xs)
  (. xs 1))

(λ second [xs]
  "Get the second element in a list"
  (assert-compile (tbl? xs) "expected table for xs" xs)
  (. xs 2))

(λ last [xs]
  "Get the last element in a list"
  (assert-compile (tbl? xs) "expected table for xs" xs)
  (. xs (length xs)))

(λ any? [pred xs]
  (accumulate [any? false
               _ v (ipairs xs)
               :until any?]
    (pred v)))

(λ all? [pred xs]
  (not (any? #(not (pred $)) xs)))

(λ contains? [xs x]
  (any? #(= $ x) xs))

(λ flatten [x ?levels]
  (assert (tbl? x) "expected tbl for x")
  (assert (or (nil? ?levels) (num? ?levels)) "expected number or nil for levels")
  (if (or (nil? ?levels) (> ?levels 0))
    (accumulate [output []
                 _ v (ipairs x)]
      (if (tbl? v)
        (icollect [_ v (ipairs (flatten v (if (nil? ?levels) nil (- ?levels 1)))) :into output] v)
        (doto output (table.insert v))))
    x))

{: empty?
 : first
 : second
 : last
 : any?
 : all?
 : contains?
 : flatten}
