(var config-opts {})

(local defaults
  {:enabled true
   :mode "smart"
   :trail_highlight true
   :trail_highlight_group :TrailHighlight
   :forceBalance false
   :commentChar ";"
   :stringDelimiters ["\""]
   :lispVlineSymbols false
   :lispBlockComments false
   :guileBlockComments false
   :schemeSexpComments false
   :janetLongStrings false})


(local ft-opts
  {:lisp {:lispVlineSymbols true
          :lispBlockComments true}
   :scheme {:lispVlineSymbols true
            :lispBlockComments true}
   :janet {:commentChar "#"
           :janetLongStrings true}
   :yuck {:stringDelimiters ["\"" "'" "`"]}})

(local scoped-opts*
  {:mode "mode"
   :enabled "enabled"
   :trail_highlight "trail_highlight"
   :trail_highlight_group "trail_highlight_group"
   :force_balance "forceBalance"
   :comment_char "commentChar"
   :string_delimiters "stringDelimiters"
   :lisp_vline_symbols "lispVlineSymbols"
   :lisp_block_comments "lispBlockComments"
   :guile_block_comments "guileBlockComments"
   :scheme_sexp_comments "schemeSexpComments"
   :janet_long_strings "janetLongStrings"})

(local scoped-opts (collect [k v (pairs scoped-opts*)]
                     (.. :parinfer_ k) v))

(fn extend [base extension ...]
  (if (= 0 (select :# ...)) (vim.tbl_extend :force base (or extension {}))
      (= nil extension) (extend base ...)
      (extend (extend base extension) ...)))

(fn resolve-value [val]
  (if (= :number (type val)) (= 1 val) val))

(fn get-global-vars []
  (collect [varname optname (pairs scoped-opts)]
    (values optname (resolve-value (. vim.g varname)))))

(fn get-buffer-vars [buf]
  (collect [varname optname (pairs scoped-opts)]
    (values optname (resolve-value (. vim.b (or buf 0) varname)))))

(fn get-configured []
  (extend defaults config-opts))

(fn get-options [config]
  (extend defaults config-opts config (get-global-vars)))

(fn get-buf-options [buf config]
  (let [ft (vim.api.nvim_buf_get_option buf :filetype)]
    (extend defaults
            config-opts
            config
            (or (. ft-opts ft) {})
            (get-global-vars)
            (get-buffer-vars buf))))

(fn setup [config]
  (set config-opts (or config {})))

(fn set-option [opt v]
  (tset config-opts opt v))

(fn update-option [opt f]
  (tset config-opts opt
        (f (. (get-configured) opt))))

{:get-options get-options
 :get_options get-options
 :get-buf-options get-buf-options
 :get_buf_options get-buf-options
 : update-option
 : setup}
