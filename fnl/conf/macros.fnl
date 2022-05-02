(local {: format : gmatch : gsub} string)
(local {: insert : concat} table)

;; Packer plugins
(global conf/pack [])

(fn ->str [x]
  "Convert given parameter into a string"
  (tostring x))

(fn head [xs]
  "Get the first element in a list"
  (. xs 1))

(fn str? [x]
  "Check if given parameter is a string"
  (= :string (type x)))

(fn num? [x]
  "Check if given parameter is a number"
  (= :number (type x)))

(fn tbl? [x]
  "Check if given parameter is a table"
  (= :table (type x)))

(fn nil? [x]
  "Check if given parameter is nil"
  (= :nil x))

(fn empty? [xs]
  "Check if given table is empty"
  (assert-compile (tbl? xs) "expected table for xs" xs)
  (= 0 (length xs)))

(fn includes? [xs x]
  "Check if given parameter exists in given list"
  (accumulate [is? false _ v (ipairs xs) :until is?]
    (= v x)))

(fn head [xs]
  "Get the first element in a list"
  (assert-compile (tbl? xs) "expected table for xs" xs)
  (. xs 1))

(fn fn? [x]
  "Check if given parameter is a function"
  (and (list? x) (or (= `fn (head x)) (= `hashfn (head x)))))

(fn cmd [command]
  "Execute a Neovim command using the Lua API"
  `(vim.api.nvim_command ,command))

(fn lazy-require! [module]
  `(let [meta# {:__index #(. (require ,module) $2)}
         ret# {}]
     (setmetatable ret# meta#)
     ret#))

(lambda set! [name value]
  "Set a Neovim option using the Lua API"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)]
    `(tset vim.opt ,name ,value)))

(fn set!-mult [...]
  "Set one or multiple vim options using the lua API"
  (fn aux [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      (where [name value & rest] (not (sym? value)))
      [(set! name value) (unpack (aux (unpack rest)))]
      _ []))

  (let [exprs (aux ...)]
    (if (> (length exprs) 1)
        `(do
           ,(unpack exprs))
        (unpack exprs))))

(fn set-local! [name value]
  " Set a Neovim option (local to buffer) using the Lua API"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)]
    `(tset vim.opt_local ,name ,value)))

(lambda let! [name value]
  "Set a Neovim variable using the Lua API"
  (assert-compile (or (sym? name) (str? name))
                  "expected symbol or string for name" name)
  (let [name (->str name)
        scope (when (includes? [:g. :b. :w. :t. "g:" "b:" "w:" "t:"]
                               (name:sub 1 2))
                (name:sub 1 1))
        name (name:sub 3)]
    `(tset ,(match scope
              :g `vim.g
              :b `vim.b
              :w `vim.w
              :t `vim.t) ,name ,value)))

(fn let!-mult [...]
  "Set one or multiple Neovim variables using the Lua API"
  (fn aux [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      [name value & rest] [(let! name value) (unpack (aux (unpack rest)))]
      _ []))

  (let [exprs (aux ...)]
    (if (> (length exprs) 1)
        `(do
           ,(unpack exprs))
        (unpack exprs))))

(λ pack [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element
  and options as hash-table items"
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (not (nil? ?options)) (tbl? ?options))
                  "expected nil or table for options" ?options)
  (let [options (or ?options {})
        options (collect [k v (pairs options)]
                  (if (= k :config!)
                      (values :config (format "require('conf.pack.%s')" v))
                      (= k :init!)
                      (values :config (format "require('%s').setup()" v))
                      (values k v)))]
    (doto options
      (tset 1 identifier))))

(fn use-package! [identifier ?options]
  "Declares a plugin with its options. Saved on the global compile-time variable conf/pack"
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (not (nil? ?options)) (tbl? ?options))
                  "expected nil or table for options" ?options)
  (insert conf/pack (pack identifier ?options)))

(fn unpack! []
  "Initializes packer with the previously declared plugins"
  (let [packages (icollect [_ v (ipairs conf/pack)]
                   `((. (require :packer) :use) ,v))]
    `((. (require :packer) :startup) #(do
                                        ,(unpack (icollect [_ v (ipairs packages)]
                                                   v))))))


;; map/local map
(fn map! [[modes & options] lhs rhs ?desc]
  "Defines a new mapping using the Lua API"
  (assert-compile (or (sym? modes) (tbl? modes))
                  "expected symbol or table for modes" modes)
  (assert-compile (tbl? options) "expected table for options" options)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (list? rhs) (fn? rhs) (sym? rhs))
                  "expected string or list or function or symbol for rhs" rhs)
  (assert-compile (or (not (nil? ?desc)) (str? ?desc))
                  "expected string or nil for description" ?desc)
  (let [modes (icollect [char (gmatch (->str modes) ".")]
                char)
        options (collect [_ v (ipairs options)]
                  (->str v)
                  true)
        rhs (if (and (not (fn? rhs)) (list? rhs)) `#,rhs rhs)
        desc (if (and (not ?desc) (or (fn? rhs) (sym? rhs))) (view rhs) ?desc)
        options (if desc (doto options (tset :desc desc)) options)]
       `(vim.keymap.set ,modes ,lhs ,rhs ,options)))

(fn buf-map! [[modes & options] lhs rhs ?desc]
  "Defines a new buffer mapping using the Lua API"
  (let [options (doto options
                  (tset :buffer true))]
    (map! [modes (unpack options)] lhs rhs ?desc)))

{: ->str
 : nil?
 : cmd
 : lazy-require!
 : pack
 : use-package!
 : unpack!
 : set-local!
 : map!
 : buf-map!
 :set! set!-mult
 :let! let!-mult}
