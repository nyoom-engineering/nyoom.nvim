(import-macros {: command!} :macros)

(fn split [s pat]
  "Split the given string into a sequential table using the pattern."
  (var done? false)
  (var acc [])
  (var index 1)
  (while (not done?)
    (let [(start end) (string.find s pat index)]
      (if (= :nil (type start))
          (do
            (table.insert acc (string.sub s index))
            (set done? true))
          (do
            (table.insert acc (string.sub s index (- start 1)))
            (set index (+ end 1))))))
  acc)

(fn antifennel [lua-code]
  (let [tmpfile (tmpfile lua-code)
        output (vim.fn.system (.. :antifennel " " tmpfile))]
    (print "tmpfile: " (slurp tmpfile))
    (if (= 0 vim.v.shell_error)
        (values output true)
        (values (.. "[nvim-antifennel] " output) false))))

(fn get-selection []
  (let [[_ s-start-line s-start-col] (vim.fn.getpos "'<")
        [_ s-end-line s-end-col] (vim.fn.getpos "'>")
        n-lines (+ 1 (math.abs (- s-end-line s-start-line)))
        lines (vim.api.nvim_buf_get_lines 0 (- s-start-line 1) s-end-line false)]
    (tset lines 1 (string.sub (. lines 1) s-start-col -1))
    (if (= 1 n-lines)
        (tset lines n-lines
              (string.sub (. lines n-lines) 1 (+ 1 (- s-end-col s-start-col))))
        (tset lines n-lines (string.sub (. lines n-lines) 1 s-end-col)))
    (values s-start-line s-end-line lines)))

(fn convert [text]
  (let [(output ok) (antifennel text)]
    (if ok
        output
        (vim.api.nvim_err_write (.. output "\n")))))

(fn convert-selection []
  (let [(s-start s-end lua-code) (get-selection)
        fennel-code (split (convert (.. "\n" lua-code) "\n"))]
    (vim.api.nvim_buf_set_lines 0 (- s-start 1) s-end false fennel-code)))

(fn convert-clipboard []
  (let [lua-code (get-clipboard)
        fnl-code (convert lua-code)]
    (when fnl-code
      (vim.api.nvim_paste fnl-code true -1))
    fnl-code))

(command! Antifennel convert-selection {:range true})
(command! AntifennelClipboard convert-clipboard {:range false})

{: antifennel : convert : convert-selection : convert-clipboard}
