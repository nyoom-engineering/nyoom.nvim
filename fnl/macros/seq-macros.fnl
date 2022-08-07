(local {: tbl? : nil? : num?} (require :macros.types-macros))

(λ empty? [xs]
  (= 0 (length xs)))

(λ first [xs]
  (?. xs 1))

(λ second [xs]
  (?. xs 2))

(λ last [xs]
  (?. xs (length xs)))

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
