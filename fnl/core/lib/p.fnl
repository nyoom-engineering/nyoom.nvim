;; LuaJIT profiler, adapted from `jit.p` in upstream LuaJIT

(local {: autoload} (require :core.lib.autoload))

(local profile (autoload :jit.profile))
(local ffnames [:Lua
                :C
                :assert
                :type
                :next
                :pairs
                :ipairs_aux
                :ipairs
                :getmetatable
                :setmetatable
                :getfenv
                :setfenv
                :rawget
                :rawset
                :rawequal
                :rawlen
                :unpack
                :select
                :tonumber
                :tostring
                :error
                :pcall
                :xpcall
                :loadfile
                :load
                :loadstring
                :dofile
                :gcinfo
                :collectgarbage
                :newproxy
                :print
                :coroutine.status
                :coroutine.running
                :coroutine.isyieldable
                :coroutine.create
                :coroutine.yield
                :coroutine.resume
                :coroutine.wrap_aux
                :coroutine.wrap
                :thread.exdata
                :math.abs
                :math.floor
                :math.ceil
                :math.sqrt
                :math.log10
                :math.exp
                :math.sin
                :math.cos
                :math.tan
                :math.asin
                :math.acos
                :math.atan
                :math.sinh
                :math.cosh
                :math.tanh
                :math.frexp
                :math.modf
                :math.log
                :math.atan2
                :math.pow
                :math.fmod
                :math.ldexp
                :math.min
                :math.max
                :math.random
                :math.randomseed
                :bit.tobit
                :bit.bnot
                :bit.bswap
                :bit.lshift
                :bit.rshift
                :bit.arshift
                :bit.rol
                :bit.ror
                :bit.band
                :bit.bor
                :bit.bxor
                :bit.tohex
                :string.byte
                :string.char
                :string.sub
                :string.rep
                :string.reverse
                :string.lower
                :string.upper
                :string.dump
                :string.find
                :string.match
                :string.gmatch_aux
                :string.gmatch
                :string.gsub
                :string.format
                :table.maxn
                :table.insert
                :table.concat
                :table.clone
                :table.isarray
                :table.nkeys
                :table.isempty
                :table.sort
                :table.pack
                :table.new
                :table.clear
                :io.method.close
                :io.method.read
                :io.method.write
                :io.method.flush
                :io.method.seek
                :io.method.setvbuf
                :io.method.lines
                :io.method.__gc
                :io.method.__tostring
                :io.open
                :io.popen
                :io.tmpfile
                :io.close
                :io.read
                :io.write
                :io.flush
                :io.input
                :io.output
                :io.lines
                :io.type
                :os.execute
                :os.remove
                :os.rename
                :os.tmpname
                :os.getenv
                :os.exit
                :os.clock
                :os.date
                :os.time
                :os.difftime
                :os.setlocale
                :debug.getregistry
                :debug.getmetatable
                :debug.setmetatable
                :debug.getfenv
                :debug.setfenv
                :debug.getinfo
                :debug.getlocal
                :debug.setlocal
                :debug.getupvalue
                :debug.setupvalue
                :debug.upvalueid
                :debug.upvaluejoin
                :debug.getuservalue
                :debug.setuservalue
                :debug.sethook
                :debug.gethook
                :debug.debug
                :debug.traceback
                :jit.on
                :jit.off
                :jit.flush
                :jit.status
                :jit.attach
                :jit.prngstate
                :jit.util.funcinfo
                :jit.util.funcbc
                :jit.util.funck
                :jit.util.funcuvname
                :jit.util.traceinfo
                :jit.util.traceir
                :jit.util.tracek
                :jit.util.tracesnap
                :jit.util.tracemc
                :jit.util.traceexitstub
                :jit.util.ircalladdr
                :jit.opt.start
                :jit.profile.start
                :jit.profile.stop
                :jit.profile.dumpstack
                :ffi.meta.__index
                :ffi.meta.__newindex
                :ffi.meta.__eq
                :ffi.meta.__len
                :ffi.meta.__lt
                :ffi.meta.__le
                :ffi.meta.__concat
                :ffi.meta.__call
                :ffi.meta.__add
                :ffi.meta.__sub
                :ffi.meta.__mul
                :ffi.meta.__div
                :ffi.meta.__mod
                :ffi.meta.__pow
                :ffi.meta.__unm
                :ffi.meta.__tostring
                :ffi.meta.__pairs
                :ffi.meta.__ipairs
                :ffi.clib.__index
                :ffi.clib.__newindex
                :ffi.clib.__gc
                :ffi.callback.free
                :ffi.callback.set
                :ffi.cdef
                :ffi.new
                :ffi.cast
                :ffi.typeof
                :ffi.typeinfo
                :ffi.istype
                :ffi.sizeof
                :ffi.alignof
                :ffi.offsetof
                :ffi.errno
                :ffi.string
                :ffi.copy
                :ffi.fill
                :ffi.abi
                :ffi.metatype
                :ffi.gc
                :ffi.load])

(var zone nil)
(var out nil)
(var prof-ud nil)
(var (prof-states prof-split prof-min prof-raw prof-fmt prof-depth) nil)
(var (prof-ann prof-count1 prof-count2 prof-samples) nil)

(local map-vmmode {:C "C code"
                   :G "Garbage Collector"
                   :I :Interpreted
                   :J "JIT Compiler"
                   :N :Compiled})

(fn prof-cb [th samples vmmode]
  (set prof-samples (+ prof-samples samples))
  (var (key-stack key-stack2 key-state) nil)
  (when prof-states
    (if (= prof-states :v) (set key-state (or (. map-vmmode vmmode) vmmode))
        (set key-state (or (zone:get) "(none)"))))
  (when prof-fmt
    (set key-stack (profile.dumpstack th prof-fmt prof-depth))
    (set key-stack
         (key-stack:gsub "%[builtin#(%d+)%]"
                         (fn [x]
                           (. ffnames (tonumber x)))))
    (if (= prof-split 2)
        (let [(k1 k2) (key-stack:match "(.-) [<>] (.*)")]
          (when k2
            (set (key-stack key-stack2) (values k1 k2))))
        (= prof-split 3)
        (set key-stack2 (profile.dumpstack th :l 1))))
  (var (k1 k2) nil)
  (if (= prof-split 1) (when key-state
                         (set k1 key-state)
                         (when key-stack
                           (set k2 key-stack)))
      key-stack (do
                 (set k1 key-stack)
                 (if key-stack2 (set k2 key-stack2)
                     key-state (set k2 key-state))))
  (when k1
    (local t1 prof-count1)
    (tset t1 k1 (+ (or (. t1 k1) 0) samples))
    (when k2
      (local t2 prof-count2)
      (var t3 (. t2 k1))
      (when (not t3)
        (set t3 {})
        (tset t2 k1 t3))
      (tset t3 k2 (+ (or (. t3 k2) 0) samples)))))

(fn prof-top [count1 count2 samples indent]
  (var (t n) (values {} 0))
  (each [k (pairs count1)]
    (set n (+ n 1))
    (tset t n k))
  (table.sort t (fn [a b]
                  (> (. count1 a) (. count1 b))))
  (for [i 1 n]
    (local k (. t i))
    (local v (. count1 k))
    (local pct (math.floor (+ (/ (* v 100) samples) 0.5)))
    (when (< pct prof-min)
      (lua :break))
    (if (not prof-raw) (out:write (string.format "%s%2d%%  %s\n" indent pct k))
        (= prof-raw :r) (out:write (string.format "%s%5d  %s\n" indent v k))
        (out:write (string.format "%s %d\n" k v)))
    (when count2
      (local r (. count2 k))
      (when r
        (prof-top r nil v
                  (or (and (or (= prof-split 3) (= prof-split 1)) "  -- ")
                      (or (and (< prof-depth 0) "  -> ") "  <- ")))))))

(fn prof-annotate [count1 samples]
  (let [files {}]
    (var ms 0)
    (each [k v (pairs count1)]
      (local pct (math.floor (+ (/ (* v 100) samples) 0.5)))
      (set ms (math.max ms v))
      (when (>= pct prof-min)
        (var (file line) (k:match "^(.*):(%d+)$"))
        (when (not file)
          (set file k)
          (set line 0))
        (var fl (. files file))
        (when (not fl)
          (set fl {})
          (tset files file fl)
          (tset files (+ (length files) 1) file))
        (set line (tonumber line))
        (tset fl line (or (and prof-raw v) pct))))
    (table.sort files)
    (var (fmtv fmtn) (values " %3d%% | %s\n" "      | %s\n"))
    (when prof-raw
      (local n (math.max 5 (math.ceil (math.log10 ms))))
      (set fmtv (.. "%" n "d | %s\n"))
      (set fmtn (.. (: " " :rep n) " | %s\n")))
    (local ann prof-ann)
    (each [_ file (ipairs files)]
      (local f0 (file:byte))
      (when (or (= f0 40) (= f0 91))
        (out:write (string.format "\n====== %s ======\n[Cannot annotate non-file]\n"
                                  file))
        (lua :break))
      (local (fp err) (io.open file))
      (when (not fp)
        (out:write (string.format "====== ERROR: %s: %s\n" file err))
        (lua :break))
      (out:write (string.format "\n====== %s ======\n" file))
      (local fl (. files file))
      (var (n show) (values 1 false))
      (when (not= ann 0)
        (for [i 1 ann]
          (when (. fl i)
            (set show true)
            (out:write "@@ 1 @@\n")
            (lua :break))))
      (each [line (fp:lines)]
        (when (= (line:byte) 27)
          (out:write "[Cannot annotate bytecode file]\n")
          (lua :break))
        (local v (. fl n))
        (when (not= ann 0)
          (local v2 (. fl (+ n ann)))
          (if show (if v2 (set show (+ n ann))
                       v (set show n)
                       (< (+ show ann) n) (set show false))
              v2 (do
                  (set show (+ n ann))
                  (out:write (string.format "@@ %d @@\n" n))))
          (when (not show)
            (set n (+ n 1))))
        (if v (out:write (string.format fmtv v line))
            (out:write (string.format fmtn line))))
      (fp:close))))

(fn prof-finish []
  (when prof-ud
    (profile.stop)
    (local samples prof-samples)
    (when (= samples 0)
      (when (not= prof-raw true)
        (out:write "[No samples collected]\n"))
      (lua "return "))
    (if prof-ann (prof-annotate prof-count1 samples)
        (prof-top prof-count1 prof-count2 samples ""))
    (set prof-count1 nil)
    (set prof-count2 nil)
    (set prof-ud nil)
    (when (not= out io.stdout)
      (out:close))))

(fn prof-start [mode]
  (var interval "")
  (set-forcibly! mode (mode:gsub "i%d*"
                                 (fn [s]
                                   (set interval s)
                                   "")))
  (set prof-min 3)
  (set-forcibly! mode (mode:gsub "m(%d+)"
                                 (fn [s]
                                   (set prof-min (tonumber s))
                                   "")))
  (set prof-depth 1)
  (set-forcibly! mode (mode:gsub "%-?%d+"
                                 (fn [s]
                                   (set prof-depth (tonumber s))
                                   "")))
  (local m {})
  (each [c (mode:gmatch ".")]
    (tset m c c))
  (set prof-states (or m.z m.v))
  (when (= prof-states :z)
    (set zone (autoload :jit.zone)))
  (var scope (or (or (or m.l m.f) m.F) (or (and prof-states "") :f)))
  (local flags (or m.p ""))
  (set prof-raw m.r)
  (if m.s (do
            (set prof-split 2)
            (if (or (= prof-depth (- 1)) (. m "-")) (set prof-depth (- 2))
                (= prof-depth 1) (set prof-depth 2)))
      (mode:find "[fF].*l") (do
                             (set scope :l)
                             (set prof-split 3))
      (set prof-split
           (or (and (or (= scope "") (mode:find "[zv].*[lfF]")) 1) 0)))
  (set prof-ann (or (and m.A 0) (and m.a 3)))
  (if prof-ann (do
                 (set scope :l)
                 (set prof-fmt :pl)
                 (set prof-split 0)
                 (set prof-depth 1)) (and m.G (not= scope ""))
      (do
        (set prof-fmt (.. flags scope "Z;"))
        (set prof-depth (- 100))
        (set prof-raw true)
        (set prof-min 0)) (= scope "") (set prof-fmt false)
      (let [sc (or (or (and (= prof-split 3) m.f) m.F) scope)]
        (set prof-fmt (.. flags sc (or (and (>= prof-depth 0) "Z < ") "Z > ")))))
  (set prof-count1 {})
  (set prof-count2 {})
  (set prof-samples 0)
  (profile.start (.. (scope:lower) interval) prof-cb)
  (set prof-ud (newproxy true))
  (tset (getmetatable prof-ud) :__gc prof-finish))

(fn start [mode outfile]
  (when (not outfile)
    (set-forcibly! outfile (os.getenv :NYOOM_PROFILEFILE)))
  (if outfile (set out
                   (or (and (= outfile "-") io.stdout)
                       (assert (io.open outfile :w))))
      (set out io.stdout))
  (prof-start (or mode :f)))

{: start :stop prof-finish}
