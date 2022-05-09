(local (tbl_extend) (values vim.tbl_extend))

(fn sriapi-it* [t i]
  (set-forcibly! i (- i 1))
  (when (not= 0 i)
    (values i (. t i))))

(fn sriapi [t]
  (values sriapi-it* t (+ 1 (length t))))

(fn extend [base t2 ...]
  (match (values t2 (select :# ...))
    (nil 0) base
    (nil _) (extend base ...)
    (ext 0) (tbl_extend :force base ext)
    (ext _) (extend (extend base ext) ...)))

(fn extend-keep [base t2 ...]
  (match (values t2 (select :# ...))
    (nil 0) base
    (nil _) (extend-keep base ...)
    (ext 0) (tbl_extend :keep base ext)
    (ext _) (extend-keep (extend-keep base ext) ...)))

{: sriapi
 : extend
 : extend-keep
 :reverse-ipairs sriapi
 :extend-force extend}
