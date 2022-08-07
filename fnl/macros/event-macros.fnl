(local {: all? : first} (require :macros.seq-macros))
(local {: ->str : nil? : tbl? : str?} (require :macros.types-macros))
(local {: fn? : quoted? : quoted->fn : quoted->str : expand-exprs} (require :macros.compile-time-macros))

(λ autocmd! [event pattern command ?options]
  "Create an autocommand using the nvim_create_autocmd API.

  Accepts the following arguments:
  event -> can be either a symbol or a list of symbols.
  pattern -> can be either a symbol or a list of symbols. If it's <buffer> the
             buffer option is set to 0. If the buffer option is set this value
             is ignored.
  command -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (autocmd! VimEnter *.py '(print \"Hello World\")
            {:once true :group \"custom\" :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_create_autocmd :VimEnter
                               {:pattern \"*.py\"
                                :callback (fn [] (print \"Hello World\"))
                                :once true
                                :group \"custom\"
                                :desc \"This is a description\"})
  ```"
  (assert-compile (or (sym? event) (and (tbl? event) (all? #(sym? $) event)) "expected symbol or list of symbols for event" event))
  (assert-compile (or (sym? pattern) (and (tbl? pattern) (all? #(sym? $) pattern)) "expected symbol or list of symbols for pattern" pattern))
  (assert-compile (or (str? command) (sym? command) (fn? command) (quoted? command)) "expected string, symbol, function or quoted expression for command" command)
  (assert-compile (or (nil? ?options) (tbl? ?options)) "expected table for options" ?options)
  (let [event (if (and (tbl? event) (not (sym? event)))
                (icollect [_ v (ipairs event)] (->str v))
                (->str event))
        pattern (if (and (tbl? pattern) (not (sym? pattern)))
                  (icollect [_ v (ipairs pattern)] (->str v))
                  (->str pattern))
        options (or ?options {})
        options (if (nil? options.buffer)
                  (if (= "<buffer>" pattern)
                    (doto options (tset :buffer 0))
                    (doto options (tset :pattern pattern)))
                  options)
        options (if (str? command)
                  (doto options (tset :command command))
                  (doto options (tset :callback (if (quoted? command)
                                                  (quoted->fn command)
                                                  command))))
        options (if (nil? options.desc)
                  (doto options (tset :desc (if (quoted? command) (quoted->str command)
                                              (str? command) command
                                              (view command))))
                  options)]
    `(vim.api.nvim_create_autocmd ,event ,options)))

(λ augroup! [name ...]
  "Create an augroup using the nvim_create_augroup API.
  Accepts either a name or a name and a list of autocmd statements.

  Example of use:
  ```fennel
  (augroup! a-nice-group
    (autocmd! Filetype *.py '(print \"Hello World\"))
    (autocmd! Filetype *.sh '(print \"Hello World\")))
  ```
  That compiles to:
  ```fennel
  (do
    (vim.api.nvim_create_augroup \"a-nice-group\" {:clear false})
    (autocmd! Filetype *.py '(print \"Hello World\") {:group \"a-nice-group\"})
    (autocmd! Filetype *.sh '(print \"Hello World\") {:group \"a-nice-group\"}))
  ```"
  (assert-compile (or (str? name) (sym? name)) "expected string or symbol for name" name)
  (assert-compile (all? #(and (list? $) (or (= 'clear! (first $))
                                            (= 'autocmd! (first $)))) [...]) "expected autocmd exprs for body" ...)
  (expand-exprs
    (let [name (->str name)]
      (icollect [_ expr (ipairs [...])
                 :into [`(vim.api.nvim_create_augroup ,name {:clear false})]]
        (if (= 'autocmd! (first expr))
          (let [[_ event pattern command ?options] expr
                options (or ?options {})
                options (doto options (tset :group name))]
            `(autocmd! ,event ,pattern ,command ,options))
          (let [[_ ?options] expr]
            `(clear! ,name ,?options)))))))

(λ clear! [name ?options]
  "Clears an augroup using the nvim_clear_autocmds API.

  Example of use:
  ```fennel
  (clear! some-group)
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_clear_autocmds {:group \"some-group\"})
  ```"
  (assert-compile (or (str? name) (sym? name)) "expected string or symbol for name" name)
  (assert-compile (or (nil? ?options) (tbl? ?options)) "expected table for options" ?options)
  (let [name (->str name)
        options (or ?options {})
        options (doto options (tset :group name))]
    `(vim.api.nvim_clear_autocmds ,options)))

{: autocmd!
 : augroup!
 : clear!}
