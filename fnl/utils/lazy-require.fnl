(fn lazy-require! [module]
  "Load a module when it accessed."
   (let [meta# {:__index #(. (require module) $2)}
         ret# {}]
     (setmetatable ret# meta#)
     ret#))

{: lazy-require!}
