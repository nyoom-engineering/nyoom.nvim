(local {: ->bool} (require :macros.types-macros))

(fn begins-with? [chars str]
  "Return whether str begins with chars."
  (->bool (str:match (.. "^" chars))))

{: begins-with?}
