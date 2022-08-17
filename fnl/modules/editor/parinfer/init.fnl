(import-macros {: use-package!} :macros)

(use-package! :eraserhd/parinfer-rust {:opt true 
                                       :run "cargo build --release"})
(use-package! :harrygallagher4/nvim-parinfer-rust {:call-setup parinfer
                                                   :event :InsertEnter})
