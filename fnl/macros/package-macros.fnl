(local {: format} string)
(local {: insert} table)

;; local to keep packages together to send to packer
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

;; emacs-isms
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

;; make life easier
(fn load-file [name]
  "To config a plugin: load a file from pack/ folder."
  `#(require ,(.. "pack." name)))

(fn call-setup [name config]
  "To config a plugin: call the setup function."
  `(λ []
      ((. (require ,name) :setup)
       ,config)))

(fn defer! [name timer]
  "To load a plugin after vim has started"
  `(λ []
      (vim.defer_fn (fn []
                      ((. (require :packer) :loader) ,name))
                    ,timer)
      (vim.defer_fn (fn []
                      (vim.cmd "if &ft == \"packer\" | echo \"\" | else | silent! e %"))
                    ,timer)))

;; pack it all up
(λ unpack! []
  "Initializes the plugin manager with the previously declared plugins and
  their options."
  (let [packs (icollect [_ v (ipairs pkgs)]
                `(use ,v))]
    `((. (require :packer) :startup)
      (fn [,(sym :use)]
          ,(unpack (icollect [_ v (ipairs packs)] v))))))

{: pack
 : defer!
 : unpack!
 : load-file
 : call-setup
 : use-package!}
