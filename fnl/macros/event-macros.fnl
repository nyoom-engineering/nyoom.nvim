(local {: args->tbl : tbl->args} (require :macros.lib.helpers))
(local {: all? : first} (require :macros.lib.seq))
(local {: ->str : nil? : tbl? : str?} (require :macros.lib.types))
(local {: fn? : quoted? : quoted->fn : quoted->str : expand-exprs} (require :macros.lib.compile-time))

(λ autocmd! [event pattern command ...]
  "Create an autocommand using the nvim_create_autocmd API.
  Accepts the following arguments:
  event -> can be either a symbol or a list of symbols.
  pattern -> can be either a symbol or a list of symbols. If it's <buffer> the
             buffer option is set to 0. If the buffer option is set this value is ignored.
  command -> can be an string, a symbol, a function or a quoted expression.
  ... -> a list of options. The valid boolean options are the following:
         - once
         - nested
         These options can be prepended by 'no' to set them to false.
         The last option that doesn't have a pair and is not boolean will become the description.
  Example of use:
  ```fennel
  (autocmd! VimEnter *.py '(print \"Hello World\")
            :once :group \"custom\"
            \"This is a description\")
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
  (assert-compile (or (sym? event) (all? #(sym? $) event)) "expected symbol or list of symbols for event" event)
  (assert-compile (or (sym? pattern) (all? #(sym? $) pattern)) "expected symbol or list of symbols for pattern" pattern)
  (assert-compile (or (str? command) (sym? command) (fn? command) (quoted? command)) "expected string, symbol, function or quoted expression for command" command)
  (let [options (args->tbl [...] {:booleans [:once :nested]
                                  :last :desc})
        event (if (and (tbl? event) (not (sym? event)))
                (icollect [_ v (ipairs event)] (->str v))
                (->str event))
        pattern (if (and (tbl? pattern) (not (sym? pattern)))
                  (icollect [_ v (ipairs pattern)] (->str v))
                  (->str pattern))
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
    (vim.api.nvim_create_augroup \"a-nice-group\" {})
    (autocmd! Filetype *.py '(print \"Hello World\") :group \"a-nice-group\")
    (autocmd! Filetype *.sh '(print \"Hello World\") :group \"a-nice-group\"))
  ```"
  (assert-compile (or (str? name) (sym? name)) "expected string or symbol for name" name)
  (assert-compile (all? #(and (list? $) (or (= 'clear! (first $))
                                            (= 'autocmd! (first $)))) [...]) "expected autocmd exprs for body" ...)
  (expand-exprs
    (let [name (->str name)]
      (icollect [_ expr (ipairs [...])
                 :into [`(vim.api.nvim_create_augroup ,name {:clear false})]]
        (if (= 'autocmd! (first expr))
          (let [[_ event pattern command & args] expr
                tbl (args->tbl args {:booleans [:once :nested]
                                     :last :desc})
                tbl (doto tbl (tset :group name))
                args (tbl->args tbl {:last :desc})]
            `(autocmd! ,event ,pattern ,command ,(unpack args)))
          (let [[_ & args] expr]
            `(clear! ,name ,(unpack args))))))))

(λ clear! [name ...]
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
  (let [name (->str name)
        args (icollect [_ v (ipairs [...])]
               (if (= '<buffer> v) (->str v) v))
        options (args->tbl args {:booleans ["<buffer>"]})
        options (if options.<buffer>
                  (doto options
                    (tset "<buffer>" nil)
                    (tset :buffer 0))
                  options)
        options (doto options (tset :group name))]
    `(vim.api.nvim_clear_autocmds ,options)))

{: autocmd!
 : augroup!
 : clear!}
