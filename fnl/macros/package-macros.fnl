(local {: format} string)
(local {: insert} table)

(global pkgs [])

(fn str? [x]
  "Check if given parameter is a string"
  (= :string (type x)))

(fn tbl? [x]
  "Check if given parameter is a table"
  (= :table (type x)))

(fn nil? [x]
  "Check if given parameter is nil"
  (= :nil x))

(fn lazy-require! [module]
  "Load a module by when it's needed"
  `(let [meta# {:__index #(. (require ,module) $2)}
         ret# {}]
     (setmetatable ret# meta#)
     ret#))

(λ pack [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element
  and options as hash-table items"
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (not (nil? ?options)) (tbl? ?options))
                  "expected nil or table for options" ?options)
  (let [options (or ?options {})
        options (collect [k v (pairs options)]
                  (if (= k :config!)
                      (values :config (format "require('pack.%s')" v))
                      (= k :init!)
                      (values :config (format "require('%s').setup()" v))
                      (values k v)))]
    (doto options
      (tset 1 identifier))))

(λ use-package! [identifier ?options]
  "Declares a plugin with its options. Saved on the global compile-time variable pkgs"
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (not (nil? ?options)) (tbl? ?options))
                  "expected nil or table for options" ?options)
  (insert pkgs (pack identifier ?options)))

(fn unpack! []
  "Initializes packer with the previously declared plugins"
  (let [packages (icollect [_ v (ipairs pkgs)]
                   `((. (require :packer) :use) ,v))]
    `((. (require :packer) :startup) #(do
                                        ,(unpack (icollect [_ v (ipairs packages)]
                                                   v))))))

{: pack
 : unpack!
 : use-package!
 : lazy-require!}
