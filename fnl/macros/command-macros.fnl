(local {: args->tbl} (require :macros.lib.helpers))
(local {: ->str : str? : nil?} (require :macros.lib.types))
(local {: fn? : quoted? : quoted->fn : quoted->str} (require :macros.lib.compile-time))

(λ command! [name command ...]
  "Create a new user command using the vim.api.nvim_create_user_command API.
  Accepts the following arguments:
  name -> must be a symbol.
  command -> can be an string, a symbol, a function or a quoted expression.
  ... -> a list of options. The valid boolean options are the following:
         - force
         - bang
         - bar
         - register
         - keepscript
         These options can be prepended by 'no' to set them to false.
         The last option that doesn't have a pair and is not boolean will become the description.
  Example of use:
  ```fennel
  (command! Salute '(print \"Hello World\")
            :bang \"This is a description\")
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_create_user_command \"Salute\" (fn [] (print \"Hello World\"))
                                    {:bang true
                                     :desc \"This is a description\"})
  ```"
  (assert-compile (sym? name) "expected symbol for name" name)
  (assert-compile (or (str? command) (sym? command) (fn? command) (quoted? command)) "expected string, symbol, function or quoted expression for command" command)
  (let [name (->str name)
        options (args->tbl [...] {:booleans [:force :bang :bar :register :keepscript]
                                  :last :desc})
        options (if (nil? options.desc)
                  (doto options (tset :desc (if (quoted? command) (quoted->str command)
                                              (str? command) command
                                              (view command))))
                  options)
        command (if (quoted? command) (quoted->fn command) command)]
    `(vim.api.nvim_create_user_command ,name ,command ,options)))

(λ local-command! [name command ...]
  "Create a new user command using the vim.api.nvim_buf_create_user_command API.
  Accepts the following arguments:
  name -> must be a symbol.
  command -> can be an string, a symbol, a function or a quoted expression.
  ... -> a list of options. The valid boolean options are the following:
         - force
         - bang
         - bar
         - register
         - keepscript
         These options can be prepended by 'no' to set them to false.
         The last option that doesn't have a pair and is not boolean will become the description.
  Example of use:
  ```fennel
  (local-command! Salute '(print \"Hello World\")
            :bang \"This is a description\")
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_buf_create_user_command \"Salute\" (fn [] (print \"Hello World\"))
                                    {:bang true
                                     :desc \"This is a description\"})
  ```"
  (assert-compile (sym? name) "expected symbol for name" name)
  (assert-compile (or (str? command) (sym? command) (fn? command) (quoted? command)) "expected string, symbol, function or quoted expression for command" command)
  (let [name (->str name)
        options (args->tbl [...] {:booleans [:force :bang :bar :register :keepscript]
                                  :last :desc})
        options (if (nil? options.desc)
                  (doto options (tset :desc (if (quoted? command) (quoted->str command)
                                              (str? command) command
                                              (view command))))
                  options)
        command (if (quoted? command) (quoted->fn command) command)]
    `(vim.api.nvim_buf_create_user_command ,name ,command ,options)))

{: command!
 : local-command!}
