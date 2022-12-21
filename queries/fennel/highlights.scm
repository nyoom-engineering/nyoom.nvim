;; extends

;; _VARARG
((symbol) @constant.builtin
 (#any-of? @constant.builtin
  "_VARARG")
 (#set! priority 150))

;; Lambdas
(["lambda" "λ"] @keyword.function @conceal
  (#set! conceal "λ"))

((symbol) @keyword.function @conceal
 (#any-of? @keyword.function
  "lambda" "λ")
 (#set! conceal "λ"))

;; Functions
(("fn") @keyword.function @conceal
  (#set! conceal ""))

((symbol) @keyword.function @conceal
 (#any-of? @keyword.function
  "fn")
 (#set! conceal ""))

;; Hash Functions
((symbol) @keyword.function @conceal
 (#any-of? @keyword.function
  "hashfn" "#")
 (#set! conceal "#"))
