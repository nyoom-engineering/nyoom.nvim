(local {: str? : nil? : tbl? : ->str} (require :macros.types-macros))

(tset _G :nyoom/pack [])
(tset _G :nyoom/rock [])

(λ pack [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element and
  options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options)) (assert-compile (tbl? ?options) "expected table for options" ?options))
  (let [options (or ?options {})]
    (doto options (tset 1 identifier))))

(λ rock [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element and
  options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options)) (assert-compile (tbl? ?options) "expected table for options" ?options))
  (let [options (or ?options {})]
    (doto options (tset 1 identifier))))

(λ use-package! [identifier ?options]
  "Declares a plugin with its options. This macro adds it to the nyoom/pack
  global table to later be used in the `unpack!` macro.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options)) (assert-compile (tbl? ?options) "expected table for options" ?options))
  (table.insert _G.nyoom/pack (pack identifier ?options)))

(λ rock! [identifier ?options]
  "Declares a rock with its options. This macro adds it to the nyoom/rock
  global table to later be used in the `unpack!` macro.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options)) (assert-compile (tbl? ?options) "expected table for options" ?options))
  (table.insert _G.nyoom/rock (rock identifier ?options)))

(λ load-module [module]
  "Configure a module by loading its config file 
  Accepts the following arguements:
  module -> a symbol.
  Example of use:
  ```fennel
  (use-package! :anuvyklack/hydra.nvim {:config (load-module tool.hydras)})
  ```"
  (assert-compile (sym? module) "expected symbol for module" module)
  (let [module (->str module)]
    `#(require (.. "modules." ,module ".config"))))

(λ call-setup [name]
 "Configures a plugin by calling its setup function
  name -> a symbol.
  Example of use:
  ```fennel
  (use-package! :j-hui/fidget.nvim {:config (call-setup :fidget)})
  ```"
  (assert-compile (sym? name) "expected symbol for lang" name)
  (let [strname (->str name)]
    `(λ []
        (import ,strname (fn [,name]
                           (. (,name) :setup))))))

(λ unpack! []
  "Initializes the plugin manager with the plugins previously declared and
  their respective options."
  (let [packs (icollect [_ v (ipairs _G.nyoom/pack)] `(use ,v))
        rocks (icollect [_ v (ipairs _G.nyoom/rock)] `(use_rocks ,v))]
    (tset _G :nyoom/pack [])
    (tset _G :nyoom/rock [])
    `((. (require :packer) :startup)
      (fn []
        ,(unpack (icollect [_ v (ipairs packs) :into rocks] v))))))

(λ packadd! [package]
  "Loads a package using the vim.api.nvim_cmd API.
  Accepts the following arguements:
  package -> a symbol.
  Example of use:
  ```fennel
  (packadd! packer.nvim)
  ```"
  (assert-compile (sym? package) "expected symbol for package" package)
  (let [package (->str package)]
    `(vim.api.nvim_cmd {:cmd :packadd :args [,package]} {})))

(λ load-on-file-open! [name]
 "loads a plugin when a file is opened
  name -> a symbol.
  Example of use:
  ```fennel
  (use-package! :j-hui/fidget.nvim {:setup (load-on-file-open! fidget.nvim)})
  ```"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)]
    `(λ []
       (vim.api.nvim_create_autocmd [:BufRead :BufWinEnter :BufNewFile]
               {:group (vim.api.nvim_create_augroup (.. :BeLazyOnFileOpen ,name) {})
                :callback (fn []
                            (when (fn []
                                     (local file (vim.fn.expand "%"))
                                     (and (and (not= file :NvimTree_1)
                                               (not= file "[packer]"))
                                          (not= file "")))
                              (vim.api.nvim_del_augroup_by_name (.. :BeLazyOnFileOpen ,name))
                              (if (not= ,name :nvim-treesitter)
                                  (vim.defer_fn (fn []
                                                  ((. (require :packer)
                                                      :loader) ,name)
                                                  (when (= ,name 
                                                           :nvim-lspconfig)
                                                    (vim.cmd "silent! e %")))
                                                0)
                                  ((. (require :packer) :loader) ,name))))}))))

{: rock
 : pack
 : rock!
 : use-package!
 : packadd!
 : load-module
 : call-setup
 : load-on-file-open!
 : unpack!}



