(local {: ->str : str? : nil? : tbl?} (require :macros.lib.types))
(local {: fn? : quoted? : quoted->fn : quoted->str} (require :macros.lib.compile-time))

(λ shared-command! [api-function name command ?options]
  (assert-compile (sym? api-function) "expected symbol for api-function" api-function)
  (assert-compile (sym? name) "expected symbol for name" name)
  (assert-compile (or (str? command) (sym? command) (fn? command) (quoted? command)) "expected string, symbol, function or quoted expression for command" command)
  (assert-compile (or (nil? ?options) (tbl? ?options)) "expected table for options" ?options)
  (let [name (->str name)
        options (or ?options {})
        options (if (nil? options.desc)
                  (doto options (tset :desc (if (quoted? command) (quoted->str command)
                                              (str? command) command
                                              (view command))))
                  options)
        command (if (quoted? command) (quoted->fn command) command)]
    `(,api-function ,name ,command ,options)))

(λ command! [name command ?options]
  "Create a new user command using the vim.api.nvim_create_user_command API.

  Accepts the following arguments:
  name -> must be a symbol.
  command -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (command! Salute '(print \"Hello World\")
            {:bang true :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_create_user_command \"Salute\" (fn [] (print \"Hello World\"))
                                    {:bang true
                                     :desc \"This is a description\"})
  ```"
  (shared-command! 'vim.api.nvim_create_user_command name command ?options))

(λ local-command! [name command ?options]
  "Create a new user command using the vim.api.nvim_buf_create_user_command API.

  Accepts the following arguments:
  name -> must be a symbol.
  command -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (local-command! Salute '(print \"Hello World\")
                  {:bang true :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_buf_create_user_command \"Salute\" (fn [] (print \"Hello World\"))
                                        {:bang true
                                         :desc \"This is a description\"})
  ```"
  (shared-command! 'vim.api.nvim_buf_create_user_command name command ?options))

(λ cmd! [cmd value]
  "Runs a vimscript command using the vim.api.nvim_cmd API.
  Accepts the following arguements:
  cmd -> a symbol.
  value -> a symbol.
  Example of use:
  ```fennel
  (cmd! Packadd packer.nvim)
  ```"
  (assert-compile (sym? cmd) "expected symbol for cmd" cmd)
  (assert-compile (sym? value) "expected symbol for value" value)
  (let [cmd (->str cmd)
        value (->str value)]
    `(vim.api.nvim_cmd {:cmd ,cmd :args [,value]} {})))

{: cmd!
 : command!
 : local-command!}
