(import-macros {: map! : nyoom-module-p!} :macros)

(local should-profile (os.getenv :NVIM_PROFILE))

(when should-profile
  ((. (require :profile) :instrument_autocmds))
  (if (: (should-profile:lower) :match :^start)
      ((. (require :profile) :start) "*")
      ((. (require :profile) :instrument) "*")))

(fn toggle-profile []
  (let [prof (require :profile)]
    (if (prof.is_recording)
        (do
          (prof.stop)
          (vim.ui.input {:prompt "Save profile to:"
                         :completion :file
                         :default :profile.json}
                        (fn [filename]
                          (when filename
                            (prof.export filename)
                            (vim.notify (string.format "Wrote %s" filename))))))
        (prof.start "*"))))

(nyoom-module-p! config.bindings
  (map! [n] :<f1> toggle-profile))
