(local {: format} string)
(local {: insert} table)

(local pkgs [])

(fn str? [x]
  "Check if given parameter is a string"
  (= :string (type x)))

(fn tbl? [x]
  "Check if given parameter is a table"
  (= :table (type x)))

(fn nil? [x]
  "Check if given parameter is nil"
  (= :nil x))

(λ pack [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element
  and options as hash-table items"
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (not (nil? ?options)) (tbl? ?options)) "expected nil or table for options" ?options)
  (doto (or ?options {})
    (tset 1 identifier)))

(λ use-package! [identifier ?options]
  "Declares a plugin with its options. Saved on the global compile-time variable pkgs"
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (not (nil? ?options)) (tbl? ?options))
                  "expected nil or table for options" ?options)
  (insert pkgs (pack identifier ?options)))


(λ unpack! []
  "Initializes the plugin manager with the previously declared plugins and
  their options."
  (let [packs (icollect [_ v (ipairs pkgs)]
                `(use ,v))]
    `((. (require :packer) :startup)
      (fn [,(sym :use)]
          ,(unpack (icollect [_ v (ipairs packs)] v))))))

(fn call-setup [name config]
  "To config a plugin: call the setup function."
  `(λ []
      ((. (require ,name) :setup)
       ,config)))

(fn load-file [name]
  "To config a plugin: load a file from pack/ folder."
  `#(require ,(.. "pack." name)))

{: pack
 : unpack!
 : load-file
 : call-setup
 : use-package!}
