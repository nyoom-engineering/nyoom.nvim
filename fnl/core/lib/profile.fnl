;; thin wrapper around jit.p to profile and benchmark neovim

(local {: autoload} (require :core.lib.autoload))
(local p (autoload :core.lib.p))
(var pstate false)

(fn start [out opts]
  (set-forcibly! out (or out :profile.log))
  (set-forcibly! opts (or opts {}))
  (global popts "10,i1,s,m0")
  (when opts.flame
    (global popts (.. popts ",G")))
  (p.start popts out))

(fn benchmark [iterations f ...]
  (let [start-time (vim.loop.hrtime)]
    (for [_ 1 iterations]
      (f ...))
    (/ (- (vim.loop.hrtime) start-time) 1000000)))

(fn toggle []
  (local logfile :/tmp/profile.folded)
  (local graphfile :/tmp/profile.svg)
  (local speedscope? (= 1 (vim.fn.executable :speedscope)))
  (local flamegraph? (= 1 (vim.fn.executable :inferno-flamegraph)))
  (if (= pstate false)
      (do
        (set pstate true)
        (if (or speedscope? flamegraph?)
            (start logfile {:flame true})
            (start logfile)))
      (do
        (set pstate false)
        (p.stop)
        (if speedscope?
            (do
              (os.execute (.. "speedscope " logfile)))
            (if flamegraph?
                (do
                  (os.execute (.. "inferno-flamegraph " logfile " > " graphfile))
                  (if (= (vim.fn.has :mac) 1)
                      (os.execute (.. "open " graphfile))
                      (os.execute (.. "xdg-open " graphfile))))
                (vim.cmd.e logfile))))))

{: start :stop p.stop : benchmark : toggle}
