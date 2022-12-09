(fn autoload [name]
  "Similar to autoload from VimScript, replacement for require 
  (for table modules) that loads the module when you first use it"
  (let [res {:nyoom/autoload-enabled? true :nyoom/autoload-module false}]
    (fn ensure []
      (if (. res :nyoom/autoload-module)
          (. res :nyoom/autoload-module)
          (let [m (require name)]
            (tset res :nyoom/autoload-module m)
            m)))

    (setmetatable res
                  {:__call (fn [t ...]
                             ((ensure) ...))
                   :__index (fn [t k]
                              (. (ensure) k))
                   :__newindex (fn [t k v]
                                 (tset (ensure) k v))})))

{: autoload}
