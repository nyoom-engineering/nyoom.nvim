(local {: autoload} (require :core.lib.autoload))
(local {: deep-merge} (autoload :core.lib.tables))

(fn setup [name ?config]
  "Wrapper for the common .setup() script to use the nyoom after macro.

  Accepts the following arguments:
  * `name`: the name of the plugin to set up
  * `?config`: (optional) a table of configuration options to merge with the plugin's default configuration

  Example of use:
  (setup :nvim-telescope {:config-to-merge})
  ```"
  (let [config (or ?config)]
    (local {: setup} (autoload name))
    (setup (deep-merge (?. shared.userconfigs name) config))))

(fn after [name config]
  "Recreation of the `after!` macro for Nyoom.

  Accepts the following arguments:
  * `name`: the name of the plugin to set up
  * `config`: a table of configuration options to merge with the plugin's default configuration
  
  Example of use:
  ```fennel
  (after nvim-telescope {:config-to-merge})
  ```"
  (tset shared.userconfigs name config))

{: setup : after}
