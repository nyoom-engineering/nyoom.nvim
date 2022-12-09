(import-macros {: command!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local io (autoload :core.lib.io))
(local str (autoload :core.lib.string))

(if (not vim.g.antifennel_executable)
    (set vim.g.antifennel_executable (.. (. (autoload :packer) :config :package_root) :/packer/start/antifennel/antifennel)))

(fn antifennel [lua-code]
  (let [compiler-path (or vim.g.antifennel_executable :antifennel)
        tmpfile (io.tmpfile lua-code)
        output (vim.fn.system (.. compiler-path " " tmpfile))]
    (print "tmpfile: " (io.slurp tmpfile))
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
        fennel-code (str.split (convert (str.join "\n" lua-code)
                                   "\n"))]
    (vim.api.nvim_buf_set_lines 0 (- s-start 1) s-end false fennel-code)))

(fn convert-clipboard []
  (let [lua-code (io.get-clipboard)
        fnl-code (convert lua-code)]
    (when fnl-code
      (vim.api.nvim_paste fnl-code true -1))
    fnl-code))

(command! Antifennel convert-selection {:range true})
(command! AntifennelClipboard convert-clipboard {:range false})

{: antifennel : convert : convert-selection : convert-clipboard}
