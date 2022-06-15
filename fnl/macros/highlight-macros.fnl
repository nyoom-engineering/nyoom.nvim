(local {: ->str : tbl?} (require :macros.lib.types))

(λ custom-set-face! [name attributes colors]
  "Sets a highlight group globally using the vim.api.nvim_set_hl API.
  Accepts the following arguments:
  name -> a symbol.
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
  (assert-compile (sym? name) "expected symbol for name" name)
  (assert-compile (tbl? attributes) "expected table for attributes" attributes)
  (assert-compile (tbl? colors) "expected colors for colors" colors)
  (let [name (->str name)
        definition (collect [_ attr (ipairs attributes)
                             :into colors]
                     (->str attr) true)]
    `(vim.api.nvim_set_hl 0 ,name ,definition)))

(λ link! [new to old]
  "Defines a highlight group using the vim API.
  e.g. (link! new => old)"
  (assert-compile (sym? new) "expected symbol for new" new)
  (assert-compile (= `=> to) "expected => for to" to)
  (assert-compile (sym? old) "expected symbol for old" old)
  (let [new (->str new)
        old (->str old)]
    `(vim.api.nvim_set_hl 0 ,new {:link ,old})))

{: custom-set-face!
 : link!}
