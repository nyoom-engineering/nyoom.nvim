;; modified from https://github.com/datwaft/nvim.conf/blob/main/fnl/conf/macro/pack.fnl
(local {: format} string)
(local {: gmatch} string)
(local {: insert} table)

;; packer
(global fnl/pack [])
(global fnl/rock [])

;; qol functions
(fn ->str [x]
  (tostring x))

(fn str? [x]
  (= :string (type x)))

(fn tbl? [x]
  (= :table (type x)))

(fn nil? [x]
  (= nil x))

(fn head [xs]
  (. xs 1))

(fn fn? [x]
  "Returns whether the parameter(s) is a function.
  A function is defined as any list with 'fn or 'hashfn as their first
  element."
  (and
    (list? x)
    (or (= 'fn (head x))
        (= 'hashfn (head x)))))

;; vlua, fnl functions in global namespace
(lambda vlua [x]
  "Return a symbol mapped to `v:lua.%s()`, where `%s` is the symbol."
  (assert-compile (sym? x) "expected symbol for x" x)
  (format "v:lua.%s()" (->str x)))

;; map/local map
(lambda map! [[modes & options] lhs rhs ?desc]
  "Defines a new mapping using the lua API.
  Supports all the options that the API supports."
  (assert-compile (sym? modes) "expected symbol for modes" modes)
  (assert-compile (tbl? options) "expected table for options" options)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (list? rhs) (fn? rhs) (sym? rhs)) "expected string or list or function or symbol for rhs" rhs)
  (assert-compile (or (nil? ?desc) (str? ?desc)) "expected string or nil for description" ?desc)
  (let [modes (icollect [char (gmatch (->str modes) ".")] char)
        options (collect [_ v (ipairs options)] (->str v) true)
        rhs (if (and (not (fn? rhs)) (list? rhs)) `#,rhs
              rhs)
        desc (if (and (not ?desc) (or (fn? rhs) (sym? rhs))) (view rhs)
               ?desc)
        options (if desc (doto options (tset :desc desc))
                  options)]
    `(vim.keymap.set ,modes ,lhs ,rhs ,options)))

(lambda buf-map! [[modes & options] lhs rhs ?description]
  "Defines a new mapping using the lua API.
  Supports all the options that the API supports.
  Automatically sets the `:buffer` option."
  (let [options (doto options
                      (insert :buffer))]
    (map! [modes (unpack options)] lhs rhs ?description)))

;; packer
(lambda pack [identifier ?options]
  "Returns a mixed table with the identifier as the first sequential element
  and options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [options (or ?options {})
        options (collect [k v (pairs options)]
                  (if (= k :config!)
                      (values :config (format "require('pack.%s')" v))
                      (= k :init)
                      (values :config (format "require('%s').setup()" v))
                      (values k v)))]
    (doto options
      (tset 1 identifier))))

(lambda use-package! [identifier ?options]
  "Declares a plugin with its options.
  This is a mixed table saved on the global compile-time variable fnl/pack.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (insert fnl/pack (pack identifier ?options)))

(lambda rock [identifier ?options]
  "Returns a mixed table with the identifier as the first sequential element
  and options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [options (or ?options {})]
    (doto options
      (tset 1 identifier))))

(lambda rock! [identifier ?options]
  "Declares a plugin with its options.
  This is a mixed table saved on the global compile-time variable fnl/rock.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (insert fnl/rock (rock identifier ?options)))

(lambda init! []
  "Initializes the plugin manager with the previously declared plugins and
  their options."
  (let [packs (icollect [_ v (ipairs fnl/pack)]
                `(use ,v))
        rocks (icollect [_ v (ipairs fnl/rock)]
                `(use_rocks ,v))]
    `((. (require :packer) :startup) #(do
                                        ,(unpack (icollect [_ v (ipairs packs) :into rocks]
                                                   v))))))

(fn cmd [string]
  `(vim.cmd ,string))

;; convert to string)
(fn sym-tostring [x]
  `,(tostring x))

;; nvim_api_command
;; for Ex commands/user commands
(fn com- [function ...]
  (let [function (sym-tostring function)
        args [...]]
    (var output function)
    (each [k v (pairs args)]
      (set output (.. output " " (sym-tostring v))))
    `(vim.api.nvim_command ,output)))

;; require configs
;; lua options really, i find the table lookup syntax to be garbage
(fn opt- [tableOrigin lookupValue ...]
  (let [tableOrigin (sym-tostring tableOrigin)
        lookupValue (sym-tostring lookupValue)
        output [...]]
    `(do
       ((. (require ,tableOrigin) ,lookupValue) ,...))))

;; get the scope of an option (global, window, or buffer)
(fn get-scope [opt]
  (if (pcall vim.api.nvim_get_option_info opt)
      (. (vim.api.nvim_get_option_info opt) :scope)
      false))

;; passed function used to actually set options
(fn set-option [option value scope]
  (match scope
    :global `(vim.api.nvim_set_option ,option ,value)
    :win `(vim.api.nvim_win_set_option 0 ,option ,value)
    :buf `(vim.api.nvim_buf_set_option 0 ,option ,value)))

;; set global
(fn setg- [option value]
  (let [option (sym-tostring option)
        value value
        scope :buf]
    `(tset vim.opt_global ,option ,value)))

;; set local
(fn setl- [option value]
  (let [option (sym-tostring option)
        value value
        scope :buf]
    `(tset vim.opt_local ,option ,value)))

;; set general
(fn set- [option value]
  (let [option (sym-tostring option)
        value value
        scope (get-scope option)]
    (set-option option value scope)))

;; set append
(fn seta- [option value]
  (let [option (sym-tostring option)
        value (sym-tostring value)]
    `(tset vim.opt ,option (+ (. vim.opt ,option) ,value))))

;; set prepend
(fn setp- [option value]
  (let [option (sym-tostring option)
        value value]
    `(tset vim.opt ,option (^ (. vim.opt ,option) ,value))))

;; set remove
(fn setr- [option value]
  (let [option (sym-tostring option)
        value value]
    `(tset vim.opt ,option (- (. vim.opt ,option) ,value))))

;; set colorscheme
(fn col- [scheme]
  (let [scheme (.. "colorscheme " (sym-tostring scheme))]
    (cmd scheme)))

;; augroup
(fn aug- [group ...]
  ;; set up augroup group autocmd!
  (let [group (.. "augroup " (sym-tostring group) "\nautocmd!")]
    `(do
       (cmd ,group)
       ;; do the autocmd
       (do
         ,...)
       ;; close the autocmd group
       (cmd "augroup END"))))

;; autocmd
(fn auc- [event filetype command]
  (let [event (sym-tostring event)
        command command]
    ;; check if the filetype is a regex
    ;; set to string first so its parsed as such
    ;; else just set to value of the filetype arg
    (var ftOut (sym-tostring filetype))
    (if (= ftOut "*")
        (set ftOut "*")
        (set ftOut filetype))
    `(do
       (cmd (.. "autocmd " ,event " " ,ftOut " " ,command)))))

;; let
(fn let- [scope obj ...]
  (let [scope (sym-tostring scope)
        obj (sym-tostring obj)
        output []
        value []]
    (var output [...])
    (var value [])
    ;; if number of operands is 1
    (if (= (length output) 1 (each [key val (pairs output)]
                               ;; set the output to just the value of the operands
                               (set value val)))
        (> (length output) 1 ;; else set the output to the whole table
           (do
             (set value output))))
    (match scope
      :g `(tset vim.g ,obj ,value)
      :b `(tset vim.b ,obj ,value)
      :w `(tset vim.w ,obj ,value)
      :t `(tset vim.t ,obj ,value)
      :v `(tset vim.v ,obj ,value)
      :env `(tset vim.env ,obj ,value))))

{: map!
 : buf-map!
 : let-
 : set-
 : setl-
 : setg-
 : seta-
 : setp-
 : setr-
 : col-
 : cmd
 : aug-
 : auc-
 : opt-
 : com-
 : pack
 : use-package!
 : rock
 : rock!
 : init!
 : vlua}
