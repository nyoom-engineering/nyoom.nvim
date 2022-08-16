(import-macros {: ieach^} :macros)
(local {: merge : sriapi} (require :utils.parinfer.sriapi))

(local (t/ins t/cat) (values table.insert table.concat))

(local sub string.sub)
(local max math.max)
(local diff vim.diff)
(local split vim.split)

(local buf-set-text vim.api.nvim_buf_set_text)
(local buf-get-lines vim.api.nvim_buf_get_lines)
(local buf-set-lines vim.api.nvim_buf_set_lines)
(local create-buf vim.api.nvim_create_buf)

(local d-line-opts {:result_type "indices" :ignore_cr_at_eol true})
(local d-opts {:result_type "indices"})


(fn set-line-text [buf line cs ce replacement]
  (buf-set-text buf line cs line ce [replacement]))

;; @params (A B) strings to compare. Must not be multi-line strings (no '\n')
;; @returns [[i j u v]] where (i j) and (u v) are (start, count) ranges
;;        corresponding to strings A and B, respectively
(fn diff-line [a b]
  (let [inputA (t/cat (split a "") "\n")
        inputB (t/cat (split b "") "\n")]
    (diff inputA inputB d-line-opts)))

;; @params (i j) single-line-diff style range
;; @returns (start_col end_col)
(fn transform-range [i j]
  (if (= 0 j) (values i i)
      (values (- i 1) (+ i j -1))))

;; the j=0: -1 condition is either never true or by a miraculous
;; coincidence is actually the *correct* return value.
(fn hunk2lines [i j]
  (if (= 0 j) [-1]
      (let [range []]
        (for [x i (+ i j -1)]
          (t/ins range x)) range)))

(fn dl2bst-multi [strA strB]
  (icollect [_ [i j u v] (sriapi (diff-line strA strB))]
    (let [(cs ce) (transform-range i j)]
      [cs ce (sub strB u (max (+ u v -1) 0))])))

;; needs to be able to handle cases where one line is replaced with two
;; or two lines replaced with one, etc. (actually maybe it doesn't need
;; to be able to handle that)
(fn buf-apply-diff [buf prev prevLines text textLines]
  (ieach^ [[hl hn hle hne] (diff prev text d-opts)
           l (hunk2lines hl hn)
           [cs ce replacement] (dl2bst-multi (. prevLines l) (. textLines l))]
    (set-line-text buf (- l 1) cs ce replacement)))


{: buf-apply-diff}
