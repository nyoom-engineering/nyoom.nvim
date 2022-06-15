(local {: nil? : tbl? : str? : bool?} (require :macros.lib.types))
(local {: begins-with?} (require :macros.lib.string))
(local {: contains? : flatten} (require :macros.lib.seq))

(fn args->tbl [args options]
  "Converts a list of arguments to a table of key/value pairs.
  Example of use:
  ```fennel
  (args->tbl [:once :group \"something\" :buffer 0 \"this is the description\"]
             {:booleans [:once]
              :last :desc})
  ```
  That returns:
  ```fennel
  {:once true
   :group \"something\"
   :buffer 0
   :desc \"this is the description\"}
  ```"
  (assert (tbl? args) "expected table for args")
  (let [options (or options {})
        booleans (or options.booleans [])
        last options.last]
    (var output {})
    (var to-process nil)
    (each [i v (ipairs args)]
      (if (nil? to-process)
        (if (str? v)
          (let [begins-with-no? (begins-with? :no v)
                v-with-no (if begins-with-no? v (.. :no v))
                v-without-no (if begins-with-no? (v:match "^no(.+)$") v)]
            (if begins-with-no?
              (if (contains? booleans v-without-no) (doto output (tset v-without-no false))
                (contains? booleans v-with-no) (doto output (tset v-with-no true))
                (set to-process v))
              (if (contains? booleans v-without-no) (doto output (tset v-without-no true))
                (contains? booleans v-with-no) (doto output (tset v-with-no false))
                (set to-process v))))
          (set to-process v))
        (do
          (tset output to-process v)
          (set to-process nil))))
    (when (and (not (nil? to-process))
               (not (nil? last)))
      (tset output last to-process))
    output))

(fn tbl->args [tbl options]
  "Converts a table of key/value pairs to a list of arguments.
  Example of use:
  ```fennel
  (tbl->args {:once true
              :group \"something\"
              :buffer 0
              :desc \"this is the description\"}
             {:last :desc})
  ```
  That returns:
  ```fennel
  [:once :group \"something\" :buffer 0 \"this is the description\"]
  ```"
  (assert (tbl? tbl) "expected table for tbl")
  (let [options (or options {})
        last options.last
        output (icollect [k v (pairs tbl)]
                 (when (not= k last)
                   (if (bool? v) k [k v])))
        output (if (not (nil? last))
                 (doto output (table.insert (. tbl last)))
                 output)]
    (flatten output 1)))

{: args->tbl
 : tbl->args}
