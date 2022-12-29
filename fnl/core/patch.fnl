;; WIP: use fennel compiler plugins to patch in our macros everywhere

;; (local {: colorscheme} (require :macros))

(fn map-seq-fn [seq f]
  `(icollect [_# v# (ipairs ,seq)]
     (,f v#)))

(fn call [ast scope ...]
  (match ast
    ;; match against symbol and capture arguments
    [[:map-seq] & other]
    ;; written as do for comment clarity
    (do
      ;; expand our macro as compiler would do, passing in capture arguments
      (local macro-ast (map-seq-fn (unpack other)))
      ;; now expand that ast again (this expands icollect etc, *other* macros)
      (local true-ast (macroexpand macro-ast))
      ;; change ast to match macro ast, note that we must
      ;; **modifiy** the ast, not return a new one, as we're
      ;; actually modifying the ast back in the compiler call-site.
      (each [i ex-ast (ipairs true-ast)]
        (tset ast i ex-ast))))
  ;; nil to continue other plugins
  (values nil))

{:name :nyoom : call :versions [:1.2.1]}
