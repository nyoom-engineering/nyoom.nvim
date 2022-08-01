(fn ieach-rec [i levels body]
  (if (> i (length levels)) body
      `(each [,(gensym) ,(. levels i 1) (ipairs ,(. levels i 2))]
         ,(ieach-rec (+ 1 i) levels body))))

(fn ieach [bindings body]
  (local levels [])
  (each [i form (ipairs bindings)]
    (if (= 1 (% i 2))
        (table.insert levels [form])
        (table.insert (. levels (/ i 2)) form)))
  (ieach-rec 1 levels body))

{:ieach^ ieach}

