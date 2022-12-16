;; fennel-ls: macro-file

(local {: deep-merge} (require :core.lib.tables))
(local {: djb2} (require :core.lib.crypt))
(local {: nil? : str? : tbl? : ->str : first : second : all? : begins-with?}
       (require :core.lib))

(λ expr->str [expr]
  `(macrodebug ,expr nil))

(tset _G :nyoom/pack [])
(tset _G :nyoom/rock [])
(tset _G :nyoom/modules {})

(λ fn? [x]
  "Checks if `x` is a function definition.
  Cannot check if a symbol is a function in compile time."
  (and (list? x)
       (or (= `fn (first x)) (= `hashfn (first x)) (= `lambda (first x))
           (= `partial (first x)))))

(λ quoted? [x]
  "Check if `x` is a list that begins with `quote`."
  (and (list? x) (= `quote (first x))))

(λ quoted->fn [expr]
  "Converts an expression like `(quote (+ 1 1))` into `(fn [] (+ 1 1))`."
  (assert-compile (quoted? expr) "expected quoted expression for expr" expr)
  (let [non-quoted (second expr)]
    `(fn []
       ,non-quoted)))

(λ quoted->str [expr]
  "Converts a quoted expression like `(quote (+ 1 1))` into an string with its shorthand form."
  (assert-compile (quoted? expr) "expected quoted expression for expr" expr)
  (let [non-quoted (second expr)]
    (.. "'" (view non-quoted))))

(λ expand-exprs [exprs]
  "Converts a list of expressions into either an expression - if only one
  expression is in the list - or a do-expression containing the expressions."
  (if (> (length exprs) 1)
      `(do
         ,(unpack exprs))
      (first exprs)))

(λ gensym-checksum [x ?options]
  "Generates a new symbol from the checksum of the object passed as a parameter
  after it is casted into an string using the `view` function.
  You can also pass a prefix or a suffix into the options optional table.
  This function depends on the djb2 hash function."
  (let [options (or ?options {})
        prefix (or options.prefix "")
        suffix (or options.suffix "")]
    (sym (.. prefix (djb2 (view x)) suffix))))

(λ vlua [x]
  "Return a symbol mapped to `v:lua.%s()` where `%s` is the symbol."
  (assert-compile (sym? x) "expected symbol for x" x)
  (string.format "v:lua.%s()" (->str x)))

(λ colorscheme [scheme]
  "Set a colorscheme using the vim.api.nvim_cmd API.
  Accepts the following arguements:
  scheme -> a symbol.
  Example of use:
  ```fennel
  (colorscheme carbon)
  ```"
  (assert-compile (sym? scheme) "expected symbol for name" scheme)
  (let [scheme (->str scheme)]
    `(vim.api.nvim_cmd {:cmd :colorscheme :args [,scheme]} {})))

(λ custom-set-face! [name attributes colors]
  "Sets a highlight group globally using the vim.api.nvim_set_hl API.
  Accepts the following arguments:
  name -> a string.
  attributes -> a list of boolean attributes:
    - bold
    - italic
    - reverse
    - inverse
    - standout
    - underline
    - underlineline
    - undercurl
    - underdot
    - underdash
    - strikethrough
    - default
  colors -> a table of colors:
    - fg
    - bg
    - ctermfg
    - ctermbg
  Example of use:
  ```fennel
  (custom-set-face! Error [:bold] {:fg \"#ff0000\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_set_hl 0 \"Error\" {:fg \"#ff0000\"
                                    :bold true})
  ```"
  (assert-compile (str? name) "expected string for name" name)
  (assert-compile (tbl? attributes) "expected table for attributes" attributes)
  (assert-compile (tbl? colors) "expected colors for colors" colors)
  (let [definition (collect [_ attr (ipairs attributes) &into colors]
                     (->str attr)
                     true)]
    `(vim.api.nvim_set_hl 0 ,name ,definition)))

(λ set! [name ?value]
  "Set a vim option using the vim.opt.<name> API.
  Accepts the following arguments:
  name -> must be a symbol.
          - If it ends with '+' it appends to the current value.
          - If it ends with '-' it removes from the current value.
          - If it ends with with '^' it prepends to the current value.
  value -> anything.
           - If it is not specified, whether the name begins with 'no' is used
             as a boolean value.
           - If it is a quoted expression or a function it becomes
             v:lua.<symbol>()."
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (if (nil? ?value)
                  (not (begins-with? :no name))
                  ?value)
        value (if (quoted? value)
                  (quoted->fn value)
                  value)
        name (if (and (nil? ?value) (begins-with? :no name))
                 (name:match "^no(.+)$")
                 name)
        exprs (if (fn? value) [`(tset _G
                                      ,(->str (gensym-checksum value
                                                               {:prefix "__"}))
                                      ,value)] [])
        value (if (fn? value)
                  (vlua (gensym-checksum value {:prefix "__"}))
                  value)
        exprs (doto exprs
                (table.insert (match (name:sub -1)
                                "+" `(: (. vim.opt ,(name:sub 1 -2)) :append
                                        ,value)
                                "-" `(: (. vim.opt ,(name:sub 1 -2)) :remove
                                        ,value)
                                "^" `(: (. vim.opt ,(name:sub 1 -2)) :prepend
                                        ,value)
                                _ `(tset vim.opt ,name ,value))))]
    (expand-exprs exprs)))

(λ local-set! [name ?value]
  "Set a vim option using the vim.opt_local.<name> API.
  Accepts the following arguments:
  name -> must be a symbol.
          - If it ends with '+' it appends to the current value.
          - If it ends with '-' it removes from the current value.
          - If it ends with with '^' it prepends to the current value.
  value -> anything.
           - If it is not specified, whether the name begins with 'no' is used
             as a boolean value.
           - If it is a quoted expression or a function it becomes
             v:lua.<symbol>()."
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (if (nil? ?value)
                  (not (begins-with? :no name))
                  ?value)
        value (if (quoted? value)
                  (quoted->fn value)
                  value)
        name (if (and (nil? ?value) (begins-with? :no name))
                 (name:match "^no(.+)$")
                 name)
        exprs (if (fn? value) [`(tset _G
                                      ,(->str (gensym-checksum value
                                                               {:prefix "__"}))
                                      ,value)] [])
        value (if (fn? value)
                  (vlua (gensym-checksum value {:prefix "__"}))
                  value)
        exprs (doto exprs
                (table.insert (match (name:sub -1)
                                "+" `(: (. vim.opt_local ,(name:sub 1 -2))
                                        :append ,value)
                                "-" `(: (. vim.opt_local ,(name:sub 1 -2))
                                        :remove ,value)
                                "^" `(: (. vim.opt_local ,(name:sub 1 -2))
                                        :prepend ,value)
                                _ `(tset vim.opt_local ,name ,value))))]
    (expand-exprs exprs)))

(λ shared-command! [api-function name command ?options]
  (assert-compile (sym? api-function) "expected symbol for api-function"
                  api-function)
  (assert-compile (sym? name) "expected symbol for name" name)
  (assert-compile (or (str? command) (sym? command) (fn? command)
                      (quoted? command))
                  "expected string, symbol, function or quoted expression for command"
                  command)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [name (->str name)
        options (or ?options {})
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? command) (quoted->str command)
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
  (shared-command! `vim.api.nvim_create_user_command name command ?options))

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
  (shared-command! `vim.api.nvim_buf_create_user_command name command ?options))

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
  (assert-compile (or (sym? event) (and (tbl? event) (all? #(sym? $) event))
                      "expected symbol or list of symbols for event" event))
  (assert-compile (or (sym? pattern)
                      (and (tbl? pattern) (all? #(sym? $) pattern))
                      "expected symbol or list of symbols for pattern" pattern))
  (assert-compile (or (str? command) (sym? command) (fn? command)
                      (quoted? command))
                  "expected string, symbol, function or quoted expression for command"
                  command)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [event (if (and (tbl? event) (not (sym? event)))
                  (icollect [_ v (ipairs event)]
                    (->str v))
                  (->str event))
        pattern (if (and (tbl? pattern) (not (sym? pattern)))
                    (icollect [_ v (ipairs pattern)]
                      (->str v))
                    (->str pattern))
        options (or ?options {})
        options (if (nil? options.buffer)
                    (if (= :<buffer> pattern)
                        (doto options
                          (tset :buffer 0))
                        (doto options
                          (tset :pattern pattern)))
                    options)
        options (if (str? command)
                    (doto options
                      (tset :command command))
                    (doto options
                      (tset :callback
                            (if (quoted? command)
                                (quoted->fn command)
                                command))))
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? command) (quoted->str command)
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
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (assert-compile (all? #(and (list? $)
                              (or (= `clear! (first $)) (= `autocmd! (first $))))
                        [...])
                  "expected autocmd exprs for body" ...)
  (expand-exprs (let [name (->str name)]
                  (icollect [_ expr (ipairs [...]) &into [`(vim.api.nvim_create_augroup ,name
                                                                                        {:clear false})]]
                    (if (= `autocmd! (first expr))
                        (let [[_ event pattern command ?options] expr
                              options (or ?options {})
                              options (doto options
                                        (tset :group name))]
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
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [name (->str name)
        options (or ?options {})
        options (doto options
                  (tset :group name))]
    `(vim.api.nvim_clear_autocmds ,options)))

(λ pack [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element and
  options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options.
  Additional to those options are some use-package-isms and custom keys:
  :defer to defer loading a plugin until a file is loaded 
  :call-setup to call setup for a plugin using nyoom's setup wrapper
  nyoom-module to load the config for nyoom module"
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options))
      (assert-compile (tbl? ?options) "expected table for options" ?options))
  (let [options (or ?options {})
        options (collect [k v (pairs options)]
                  (match k
                    :call-setup (values :config
                                        (string.format "require(\"core.lib.autoload\")[\"autoload\"](\"core.lib.setup\")[\"setup\"](\"%s\", {})"
                                                       (->str v)))
                    :nyoom-module (values :config
                                          (string.format "require(\"modules.%s.config\")"
                                                         (->str v)))
                    :defer (values :setup
                                   (let [package (->str v)]
                                     `(λ []
                                        (vim.api.nvim_create_autocmd [:BufRead
                                                                      :BufWinEnter
                                                                      :BufNewFile]
                                                                     {:group (vim.api.nvim_create_augroup ,package
                                                                                                          {})
                                                                      :callback (fn []
                                                                                  (if (not= vim.fn.expand
                                                                                            "%"
                                                                                            "")
                                                                                      (vim.defer_fn (fn []
                                                                                                      ((. (require :packer)
                                                                                                          :loader) ,package)
                                                                                                      (if (= ,package
                                                                                                             :nvim-lspconfig)
                                                                                                          (vim.cmd "silent! do FileType")))
                                                                                                    0)))}))))
                    _ (values k v)))]
    (doto options
      (tset 1 identifier))))

(λ rock [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element and
  options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options))
      (assert-compile (tbl? ?options) "expected table for options" ?options))
  (let [options (or ?options {})]
    (doto options
      (tset 1 identifier))))

(λ use-package! [identifier ?options]
  "Declares a plugin with its options. This macro adds it to the nyoom/pack
  global table to later be used in the `unpack!` macro.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options))
      (assert-compile (tbl? ?options) "expected table for options" ?options))
  (table.insert _G.nyoom/pack (pack identifier ?options)))

(λ rock! [identifier ?options]
  "Declares a rock with its options. This macro adds it to the nyoom/rock
  global table to later be used in the `unpack!` macro.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options))
      (assert-compile (tbl? ?options) "expected table for options" ?options))
  (table.insert _G.nyoom/rock (rock identifier ?options)))

(λ unpack! []
  "Initializes the plugin manager with the plugins previously declared and
  their respective options."
  (let [packs (icollect [_ v (ipairs _G.nyoom/pack)]
                `(use ,v))
        rocks (icollect [_ v (ipairs _G.nyoom/rock)]
                `(use_rocks ,v))
        use-sym (sym :use)]
    `((. (require :packer) :startup) (fn [,use-sym]
                                       ,(unpack (icollect [_ v (ipairs packs) &into rocks]
                                                  v))))))

(λ packadd! [package]
  "Loads a package using the vim.api.nvim_cmd API.
  Accepts the following arguements:
  package -> a symbol.
  Example of use:
  ```fennel
  (packadd! packer.nvim)
  ```"
  (assert-compile (sym? package) "expected symbol for package" package)
  (let [package (->str package)]
    `(vim.api.nvim_cmd {:cmd :packadd :args [,package]} {})))

(λ map! [[modes] lhs rhs ?options]
  "Add a new mapping using the vim.keymap.set API.

  Accepts the following arguments:
  modes -> is a sequence containing a symbol, each character of the symbol is
           a mode.
  lhs -> must be an string.
  rhs -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (map! [nv] \"<leader>lr\" vim.lsp.references
        {:silent true :buffer 0 :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.keymap.set [:n :v] \"<leader>lr\" vim.lsp.references
                  {:silent true
                   :buffer 0
                   :desc \"This is a description\"})
  ```"
  (assert-compile (sym? modes) "expected symbol for modes" modes)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (sym? rhs) (fn? rhs) (quoted? rhs))
                  "expected string, symbol, function or quoted expression for rhs"
                  rhs)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [modes (icollect [char (string.gmatch (->str modes) ".")]
                char)
        options (or ?options {})
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? rhs) (quoted->str rhs)
                                (str? rhs) rhs
                                (view rhs))))
                    options)
        rhs (if (quoted? rhs) (quoted->fn rhs) rhs)]
    `(vim.keymap.set ,modes ,lhs ,rhs ,options)))

(λ buf-map! [[modes] lhs rhs ?options]
  "Add a new mapping using the vim.keymap.set API.
  Sets by default the buffer option.

  Accepts the following arguments:
  modes -> is a sequence containing a symbol, each character of the symbol is
           a mode.
  lhs -> must be an string.
  rhs -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (map! [nv] \"<leader>lr\" vim.lsp.references
        {:silent true :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.keymap.set [:n :v] \"<leader>lr\" vim.lsp.references
                  {:silent true
                   :buffer 0
                   :desc \"This is a description\"})
  ```"
  (assert-compile (sym? modes) "expected symbol for modes" modes)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (sym? rhs) (fn? rhs) (quoted? rhs))
                  "expected string, symbol, function or quoted expression for rhs"
                  rhs)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [options (or ?options {})
        options (doto options
                  (tset :buffer 0))]
    (map! [modes] lhs rhs options)))

(λ let-with-scope! [[scope] name value]
  (assert-compile (or (str? scope) (sym? scope))
                  "expected string or symbol for scope" scope)
  (assert-compile (or (= :b (->str scope)) (= :w (->str scope))
                      (= :t (->str scope)) (= :g (->str scope)))
                  "expected scope to be either b, w, t or g" scope)
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)
        scope (->str scope)]
    `(tset ,(match scope
              :b `vim.b
              :w `vim.w
              :t `vim.t
              :g `vim.g) ,name ,value)))

(λ let-global! [name value]
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)]
    `(tset vim.g ,name ,value)))

(λ let! [...]
  "Set a vim variable using the vim.<scope>.name API.
  Accepts the following arguments:
  [scope] -> optional. Can be either [g], [w], [t] or [b]. It's either a symbol
             or a string surrounded by square brackets.
  name -> either a symbol or a string.
  value -> anything.
  Example of use:
  ```fennel
  (let! hello :world)
  (let! [w] hello :world)
  ```
  That compiles to:
  ```fennel
  (tset vim.g :hello :world)
  (tset vim.w :hello :world)
  ```"
  (match [...]
    [[scope] name value] (let-with-scope! [scope] name value)
    [name value] (let-global! name value)
    _ (error "expected let! to have at least two arguments: name value")))

(λ sh [...]
  "simple macro to run shell commands inside fennel"
  `(let [str# ,(accumulate [str# "" _ v# (ipairs [...])]
                 (if (in-scope? v#) `(.. ,str# " " ,v#)
                     (or (list? v#) (sym? v#)) (.. str# " " (tostring v#))
                     (= (type v#) :string) (.. str# " " (string.format "%q" v#))))
         fd# (io.popen str#)
         d# (fd#:read :*a)]
     (fd#:close)
     (string.sub d# 1 (- (length d#) 1))))

(λ nyoom! [...]
  "Recreation of the `doom!` macro for Nyoom
  See modules.fnl for usage
  Accepts the following arguments:
  value -> anything.
  Example of use:
  ```fennel
  (nyoom! :catagory
          module
          (module +with +flags
          :anothercatagory
          anothermodule
          (module +with +more +flags)
  ```"
  (var moduletag nil)
  (var registry {})

  (fn register-module [name]
    (if (str? name)
        (set moduletag name)
        (if (sym? name)
            (let [name (->str name)
                  include-path (.. :fnl.modules. moduletag "." name)
                  config-path (.. :modules. moduletag "." name :.config)]
              (tset registry name
                    {:include-paths [include-path] :config-paths [config-path]}))
            (let [modulename (->str (first name))
                  include-path (.. :fnl.modules. moduletag "." modulename)
                  config-path (.. :modules. moduletag "." modulename :.config)
                  [_ & flags] name]
              (var includes [include-path])
              (var configs [config-path])
              (each [_ v (ipairs flags)]
                (let [flagmodule (.. modulename "." (->str v))
                      flag-include-path (.. include-path "." (->str v))
                      flag-config-path (.. :modules. moduletag "." flagmodule
                                           :.config)]
                  (table.insert includes flag-include-path)
                  (table.insert configs flag-config-path)
                  (tset registry flagmodule {})))
              (tset registry modulename
                    {:include-paths includes :config-paths configs})))))

  (fn register-modules [...]
    (each [_ mod (ipairs [...])]
      (register-module mod))
    registry)

  (let [modules (register-modules ...)]
    (tset _G :nyoom/modules modules)
    `(do
       (tset _G :nyoom/modules ,modules)
       (. _G :nyoom/modules))))

(λ nyoom-init-modules! []
  "Initializes nyoom's module system.
  ```fennel
  (nyoom-init-modules!)
  ```"
  (fn init-module [module-name module-def]
    (icollect [_ include-path (ipairs (or module-def.include-paths []))]
      `(include ,include-path)))

  (fn init-modules [registry]
    (icollect [module-name module-def (pairs registry)]
      (init-module module-name module-def)))

  (let [inits (init-modules _G.nyoom/modules)]
    (expand-exprs inits)))

(λ nyoom-compile-modules! []
  "Compiles and caches module files.
  ```fennel
  (nyoom-compile-modules!)
  ```"
  (fn compile-module [module-name module-decl]
    (icollect [_ config-path (ipairs (or module-decl.config-paths []))]
      `,(pcall require config-path)))

  (fn compile-modules [registry]
    (icollect [module-name module-def (pairs registry)]
      (compile-module module-name module-def)))

  (let [source (compile-modules _G.nyoom/modules)]
    (expand-exprs [(unpack source)])))

(λ nyoom-module! [name]
  "By default modules should be loaded through use-package!. Of course, not every
  modules needs a package. Sometimes we just want to load `config.fnl`. In this 
  case, we can hack onto packer.nvim, give it a fake package, and ask it to load a 
  config file.
  Example of use:
  ```fennel
  (nyoom-module! tools.tree-sitter)
  ```"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)]
    (table.insert _G.nyoom/pack (pack name {:nyoom-module name}))))

(λ nyoom-module-p! [name config]
  "Checks if a module is enabled
  Accepts the following arguements:
  name -> a symbol.
  Example of use:
  ```fennel
  (nyoom-module-p! tree-sitter)
  ```"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        module-exists (not= nil (. _G.nyoom/modules name))]
    (when module-exists
      `,config)))

(λ nyoom-module-ensure! [name]
  "Ensure a module is enabled
  Accepts the following arguements:
  name -> a symbol.
  Example of use:
  ```fennel
  (nyoom-module-ensure! tools.tree-sitter)
  ```"
  (assert-compile (sym? name) "expected symbol for name" name)
  (when (not= nil (. _G.nyoom/modules name))
    (let [msg (.. "One of your installed modules depends on " (->str name)
                  ". Please enable it")]
      `(vim.notify ,msg vim.log.levels.WARN))))

;; (tset _G :nyoom/servers [])
;; (tset _G :nyoom/lintesr [])
;; (tset _G :nyoom/formatters [])
;; (tset _G :nyoom/parsers [])
;; (tset _G :nyoom/cmp [])
;; 
;; (λ nyoom-add-language-server! [server ?config]
;;   (assert-compile (sym? server) "expected symbol for server" server)
;;   (let [server (->str server)
;;         config (or ?config)]
;;     (tset _G :nyoom/servers server config)))
;; 
;; (λ nyoom-load-language-servers! []
;;   (let [servers _G.nyoom/servers]
;;     (each [server server_config (pairs servers)]
;;       ((. (. lsp server) :setup) (deep-merge defaults server_config)))))
;; 
;; (λ nyoom-add-linter! [])
;; (λ nyoom-add-formatter! [])
;; (λ nyoom-add-parsers! [])
;; (λ nyoom-add-cmp-source! [])

{: expr->str
 : vlua
 : colorscheme
 : sh
 : custom-set-face!
 : set!
 : local-set!
 : map!
 : buf-map!
 : let!
 : command!
 : local-command!
 : autocmd!
 : augroup!
 : clear!
 : pack
 : rock
 : use-package!
 : rock!
 : unpack!
 : packadd!
 : nyoom!
 : nyoom-init-modules!
 : nyoom-compile-modules!
 : nyoom-module!
 : nyoom-module-p!
 : nyoom-module-ensure!}
