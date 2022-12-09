(local {: autoload} (require :core.lib.autoload))
(local {: deep-merge} (autoload :core.lib.tables))
(local {: userconfigs} (autoload :core.shared))

(fn setup [name ?config]
  "Wrapper for the common `.setup()` script to use the nyoom `after` macro
  Accepts the following arguements:
  Example of use:
  ```fennel
  (setup :nvim-telescope {:config-to-merge})
  ```"
  (let [config (or ?config)]
    (local {: setup} (autoload name))
    (setup (deep-merge (?. userconfigs name) config))))

(fn after [name config]
  "Recreation of the `after!` macro for Nyoom
  Example of use:
  ```fennel
  (after nvim-telescope {:config-to-merge})
  ```"
  (tset userconfigs name config))

{: setup : after}
