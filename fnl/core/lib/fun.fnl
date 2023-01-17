;; Functional library for LuaJIT based off of LuaFun. Written with the LuaJIT 
;; tracing compiler and its optimizations in mind. Differs from luafun in that 
;; it uses neovim-specific functions and sprinkles some extra stuff in 
;; see https://luafun.github.io/under_the_hood.html for more

(local exports {})
(local methods {})

(fn clone-function [x]
  (let [dumped (string.dump x)
        cloned (loadstring dumped)]
    (var i 1)
    (while true
      (local name (debug.getupvalue x i))
      (when (not name)
        (lua :break))
      (debug.upvaluejoin cloned i x i)
      (set i (+ i 1)))
    cloned))

(fn return-if-not-empty [state-x ...]
  (when (= state-x nil)
    (lua "return nil"))
  ...)

(fn call-if-not-empty [fun state-x ...]
  (when (= state-x nil)
    (lua "return nil"))
  (values state-x (fun ...)))

(fn deepcopy [orig]
  (let [orig-type (type orig)]
    (var copy nil)
    (if (= orig-type :table)
        (do
          (set copy {})
          (each [orig-key orig-value next orig nil]
            (tset copy (deepcopy orig-key) (deepcopy orig-value))))
        (set copy orig))
    copy))

(local iterator-mt {:__call (fn [self param state]
                              (self.gen param state))
                    :__tostring (fn [self]
                                  :<generator>)
                    :__index methods})

(fn wrap [gen param state]
  (values (setmetatable {: gen : param : state} iterator-mt) param state))

(set exports.wrap wrap)

(fn unwrap [self]
  (values self.gen self.param self.state))

(set methods.unwrap unwrap)

(fn nil-gen [_param _state]
  nil)

(fn string-gen [param state]
  (let [state (+ state 1)]
    (when (> state (length param))
      (lua "return nil"))
    (local r (string.sub param state state))
    (values state r)))

(local ipairs-gen (ipairs {}))
(local pairs-gen (pairs {:a 0}))

(fn kv-iter-gen [tab key]
  (let [value nil
        (key value) (pairs-gen tab key)]
    (values key key value)))

(fn rawiter [obj param state]
  (assert (not= obj nil) "invalid iterator")
  (if (= (type obj) :table)
      (let [mt (getmetatable obj)]
        (when (not= mt nil)
          (if (= mt iterator-mt)
              (let [earlyrtn_1 obj.gen
                    earlyrtn_2 obj.param
                    earlyrtn_3 obj.state]
                (lua "return earlyrtn_1, earlyrtn_2, earlyrtn_3"))
              (not= mt.__ipairs nil)
              (let [earlyrtns_1 [(mt.__ipairs obj)]]
                (lua "return (table.unpack or _G.unpack)(earlyrtns_1)"))
              (not= mt.__pairs nil)
              (let [earlyrtns_1 [(mt.__pairs obj)]]
                (lua "return (table.unpack or _G.unpack)(earlyrtns_1)"))))
        (if (> (length obj) 0)
            (let [earlyrtns_1 [(ipairs obj)]]
              (lua "return (table.unpack or _G.unpack)(earlyrtns_1)"))
            (let [earlyrtn_1 kv-iter-gen
                  earlyrtn_2 obj
                  earlyrtn_3 nil]
              (lua "return earlyrtn_1, earlyrtn_2, earlyrtn_3"))))
      (= (type obj) :function)
      (lua "return obj, param, state")
      (= (type obj) :string)
      (do
        (when (= (length obj) 0)
          (let [earlyrtn_1 nil-gen
                earlyrtn_2 nil
                earlyrtn_3 nil]
            (lua "return earlyrtn_1, earlyrtn_2, earlyrtn_3")))
        (let [earlyrtn_1 string-gen
              earlyrtn_2 obj
              earlyrtn_3 0]
          (lua "return earlyrtn_1, earlyrtn_2, earlyrtn_3"))))
  (error (string.format "object %s of type \"%s\" is not iterable" obj
                        (type obj))))

(fn iter [obj param state]
  (wrap (rawiter obj param state)))

(set exports.iter iter)

(fn iter-pairs [obj]
  (wrap (pairs obj)))

(set exports.iter-pairs iter-pairs)

(fn iter-map-pairs [obj]
  (wrap kv-iter-gen obj nil))

(set exports.iter-map-pairs iter-map-pairs)

(fn method0 [fun]
  (fn [self]
    (fun self.gen self.param self.state)))

(fn method1 [fun]
  (fn [self arg1]
    (fun arg1 self.gen self.param self.state)))

(fn method2 [fun]
  (fn [self arg1 arg2]
    (fun arg1 arg2 self.gen self.param self.state)))

(fn export0 [fun]
  (fn [gen param state]
    (fun (rawiter gen param state))))

(fn export1 [fun]
  (fn [arg1 gen param state]
    (fun arg1 (rawiter gen param state))))

(fn export2 [fun]
  (fn [arg1 arg2 gen param state]
    (fun arg1 arg2 (rawiter gen param state))))

(fn for-each [fun gen param state]
  (while true
    (set-forcibly! state (call-if-not-empty fun (gen param state)))
    (when (= state nil)
      (lua :break))))

(set methods.for-each (method1 for-each))
(set exports.for-each (export1 for-each))

(fn range-gen [param state]
  (let [(stop step) (values (. param 1) (. param 2))
        state (+ state step)]
    (when (> state stop)
      (lua "return nil"))
    (values state state)))

(fn range-rev-gen [param state]
  (let [(stop step) (values (. param 1) (. param 2))
        state (+ state step)]
    (when (< state stop)
      (lua "return nil"))
    (values state state)))

(fn range [start stop step]
  (when (= step nil)
    (when (= stop nil)
      (when (= start 0)
        (let [earlyrtn_1 nil-gen
              earlyrtn_2 nil
              earlyrtn_3 nil]
          (lua "return earlyrtn_1, earlyrtn_2, earlyrtn_3")))
      (set-forcibly! stop start)
      (set-forcibly! start (or (and (> stop 0) 1) (- 1))))
    (set-forcibly! step (or (and (<= start stop) 1) (- 1))))
  (assert (= (type start) :number) "start must be a number")
  (assert (= (type stop) :number) "stop must be a number")
  (assert (= (type step) :number) "step must be a number")
  (assert (not= step 0) "step must not be zero")
  (if (> step 0) (wrap range-gen [stop step] (- start step))
      (< step 0) (wrap range-rev-gen [stop step] (- start step))))

(set exports.range range)

(fn duplicate-table-gen [param-x state-x]
  (values (+ state-x 1) (unpack param-x)))

(fn duplicate-fun-gen [param-x state-x]
  (values (+ state-x 1) (param-x state-x)))

(fn duplicate-gen [param-x state-x]
  (values (+ state-x 1) param-x))

(fn duplicate [...]
  (if (<= (select "#" ...) 1) (wrap duplicate-gen (select 1 ...) 0)
      (wrap duplicate-table-gen [...] 0)))

(set exports.duplicate duplicate)

(fn tabulate [fun]
  (assert (= (type fun) :function))
  (wrap duplicate-fun-gen fun 0))

(set exports.tabulate tabulate)

(fn zeros []
  (wrap duplicate-gen 0 0))

(set exports.zeros zeros)

(fn ones []
  (wrap duplicate-gen 1 0))

(set exports.ones ones)

(fn rands-gen [param-x _state-x]
  (values 0 (math.random (. param-x 1) (. param-x 2))))

(fn rands-nil-gen [_param-x _state-x]
  (values 0 (math.random)))

(fn rands [n m]
  (when (and (= n nil) (= m nil))
    (let [earlyrtns_1 [(wrap rands-nil-gen 0 0)]]
      (lua "return (table.unpack or _G.unpack)(earlyrtns_1)")))
  (assert (= (type n) :number) "invalid first arg to rands")
  (if (= m nil) (do
                  (set-forcibly! m n)
                  (set-forcibly! n 0))
      (assert (= (type m) :number) "invalid second arg to rands"))
  (assert (< n m) "empty interval")
  (wrap rands-gen [n (- m 1)] 0))

(set exports.rands rands)

(fn nth [n gen-x param-x state-x]
  (assert (> n 0) "invalid first argument to nth")
  (if (= gen-x ipairs-gen)
      (let [antifnl_rtn_1 (. param-x (+ state-x n))]
        (lua "return antifnl_rtn_1"))
      (= gen-x string-gen)
      (if (<= (+ state-x n) (length param-x))
          (let [earlyrtn_1 [(string.sub param-x (+ state-x n (+ state-x n)))]]
            (lua "return (table.unpack or _G.unpack)(earlyrtn_1)"))
          (lua "return nil")))
  (for [i 1 (- n 1)]
    (set-forcibly! state-x (gen-x param-x state-x))
    (when (= state-x nil)
      (lua "return nil")))
  (return-if-not-empty (gen-x param-x state-x)))

(set methods.nth (method1 nth))
(set exports.nth (export1 nth))

(fn car-call [state ...]
  (when (= state nil)
    (error "head: iterator is empty"))
  ...)

(fn car [gen param state]
  (car-call (gen param state)))

(set methods.car car)
(set exports.car (export0 car))

(fn cdr [gen param state]
  (set-forcibly! state (gen param state))
  (when (= state nil)
    (let [earlyrtns_1 [(wrap nil-gen nil nil)]]
      (lua "return (table.unpack or _G.unpack)(earlyrtns_1)")))
  (wrap gen param state))

(set methods.cdr (method0 cdr))
(set exports.cdr (export0 cdr))

(fn take-n-gen-x [i state-x ...]
  (when (= state-x nil)
    (lua "return nil"))
  (values [i state-x] ...))

(fn take-n-gen [param state]
  (let [(n gen-x param-x) (values (. param 1) (. param 2) (. param 3))
        (i state-x) (values (. state 1) (. state 2))]
    (when (>= i n)
      (lua "return nil"))
    (take-n-gen-x (+ i 1) (gen-x param-x state-x))))

(fn take-n [n gen param state]
  (assert (>= n 0) "invalid first argument to take_n")
  (wrap take-n-gen [n gen param] [0 state]))

(set methods.take-n (method1 take-n))
(set exports.take-n (export1 take-n))

(fn take-while-gen-x [fun state-x ...]
  (when (or (= state-x nil) (not (fun ...)))
    (lua "return nil"))
  (values state-x ...))

(fn take-while-gen [param state-x]
  (let [(fun gen-x param-x) (values (. param 1) (. param 2) (. param 3))]
    (take-while-gen-x fun (gen-x param-x state-x))))

(fn take-while [fun gen param state]
  (assert (= (type fun) :function) "invalid first argument to take_while")
  (wrap take-while-gen [fun gen param] state))

(set methods.take-while (method1 take-while))
(set exports.take-while (export1 take-while))

(fn take [n-or-fun gen param state]
  (if (= (type n-or-fun) :number) (take-n n-or-fun gen param state)
      (take-while n-or-fun gen param state)))

(set methods.take (method1 take))
(set exports.take (export1 take))

(fn drop-n [n gen param state]
  (assert (>= n 0) "invalid first argument to drop_n")
  (local i nil)
  (for [i 1 n]
    (set-forcibly! state (gen param state))
    (when (= state nil)
      (let [earlyrtns_1 [(wrap nil-gen nil nil)]]
        (lua "return (table.unpack or _G.unpack)(earlyrtns_1)"))))
  (wrap gen param state))

(set methods.drop_n (method1 drop-n))
(set exports.drop_n (export1 drop-n))

(fn drop-while-x [fun state-x ...]
  (when (or (= state-x nil) (not (fun ...)))
    (let [earlyrtn_1 state-x
          earlyrtn_2 false]
      (lua "return earlyrtn_1, earlyrtn_2")))
  (values state-x true ...))

(fn drop-while [fun gen-x param-x state-x]
  (assert (= (type fun) :function) "invalid first argument to drop_while")
  (var (cont state-x-prev) nil)
  (while true
    (set state-x-prev (deepcopy state-x))
    (set-forcibly! (state-x cont) (drop-while-x fun (gen-x param-x state-x)))
    (when (not cont)
      (lua :break)))
  (when (= state-x nil)
    (let [earlyrtns_1 [(wrap nil-gen nil nil)]]
      (lua "return (table.unpack or _G.unpack)(earlyrtns_1)")))
  (wrap gen-x param-x state-x-prev))

(set methods.drop-while (method1 drop-while))
(set exports.drop-while (export1 drop-while))

(fn drop [n-or-fun gen-x param-x state-x]
  (if (= (type n-or-fun) :number) (drop-n n-or-fun gen-x param-x state-x)
      (drop-while n-or-fun gen-x param-x state-x)))

(set methods.drop (method1 drop))
(set exports.drop (export1 drop))

(fn split [n-or-fun gen-x param-x state-x]
  (values (take n-or-fun gen-x param-x state-x)
          (drop n-or-fun gen-x param-x state-x)))

(set methods.split (method1 split))
(set exports.split (export1 split))

(fn index [x gen param state]
  (var i 1)
  (each [_k r gen param state]
    (when (= r x)
      (lua "return i"))
    (set i (+ i 1)))
  nil)

(set methods.index (method1 index))
(set exports.index (export1 index))

(fn indexes-gen [param state]
  (let [(x gen-x param-x) (values (. param 1) (. param 2) (. param 3))]
    (var (i state-x) (values (. state 1) (. state 2)))
    (var r nil)
    (while true
      (set (state-x r) (gen-x param-x state-x))
      (when (= state-x nil)
        (lua "return nil"))
      (set i (+ i 1))
      (when (= r x)
        (let [earlyrtn_1 [i state-x]
              earlyrtn_2 i]
          (lua "return earlyrtn_1, earlyrtn_2"))))))

(fn indexes [x gen param state]
  (wrap indexes-gen [x gen param] [0 state]))

(set methods.indexes (method1 indexes))
(set exports.indexes (export1 indexes))

(fn filter1-gen [fun gen-x param-x state-x a]
  (while true
    (when (or (= state-x nil) (fun a))
      (lua :break))
    (set-forcibly! (state-x a) (gen-x param-x state-x)))
  (values state-x a))

(var filterm-gen nil)

(fn filterm-gen-shrink [fun gen-x param-x state-x]
  (filterm-gen fun gen-x param-x (gen-x param-x state-x)))

(set filterm-gen
     (fn [fun gen-x param-x state-x ...]
       (when (= state-x nil)
         (lua "return nil"))
       (when (fun ...)
         (let [earlyrtn_1 state-x
               earlyrtn_2 ...]
           (lua "return earlyrtn_1, earlyrtn_2")))
       (filterm-gen-shrink fun gen-x param-x state-x)))

(fn filter-detect [fun gen-x param-x state-x ...]
  (if (< (select "#" ...) 2) (filter1-gen fun gen-x param-x state-x ...)
      (filterm-gen fun gen-x param-x state-x ...)))

(fn filter-gen [param state-x]
  (let [(fun gen-x param-x) (values (. param 1) (. param 2) (. param 3))]
    (filter-detect fun gen-x param-x (gen-x param-x state-x))))

(fn filter [fun gen param state]
  (wrap filter-gen [fun gen param] state))

(set methods.filter (method1 filter))
(set exports.filter (export1 filter))

(fn grep [fun-or-regexp gen param state]
  (var fun fun-or-regexp)
  (when (= (type fun-or-regexp) :string)
    (set fun (fn [x]
               (not= (string.find x fun-or-regexp) nil))))
  (filter fun gen param state))

(set methods.grep (method1 grep))
(set exports.grep (export1 grep))

(fn partition [fun gen param state]
  (fn neg-fun [...]
    (not (fun ...)))

  (values (filter fun gen param state) (filter neg-fun gen param state)))

(set methods.partition (method1 partition))
(set exports.partition (export1 partition))

(local reduce-clones {})
(local funcinfo (. (require :jit.util) :funcinfo))

(fn reduce-impl [fun start gen-x param-x state-x]
  (while true
    (set-forcibly! (state-x start)
                   (reduce-call fun start (gen-x param-x state-x)))
    (when (= state-x nil)
      (lua :break)))
  start)

(fn reduce [fun start gen-x param-x state-x]
  (let [pt (. (funcinfo (. (debug.getinfo 2 :f) :func)) :proto)]
    (when (= (. reduce-clones pt) nil)
      (tset reduce-clones pt (clone-function reduce-impl)))
    ((. reduce-clones pt) fun start gen-x param-x state-x)))

(set methods.reduce (method2 reduce))
(set exports.reduce (export2 reduce))

(fn nlength [gen param state]
  (when (or (= gen ipairs-gen) (= gen string-gen))
    (let [earlyrtn_1 (length param)]
      (lua "return earlyrtn_1")))
  (var len 0)
  (while true
    (set-forcibly! state (gen param state))
    (set len (+ len 1))
    (when (= state nil)
      (lua :break)))
  (- len 1))

(set methods.nlength (method0 nlength))
(set exports.nlength (export0 nlength))

(fn is-null [gen param state]
  (= (gen param (deepcopy state)) nil))

(set methods.is_null (method0 is-null))
(set exports.is_null (export0 is-null))

(fn is-prefix-of [iter-x iter-y]
  (var (gen-x param-x state-x) (iter iter-x))
  (var (gen-y param-y state-y) (iter iter-y))
  (var (r-x r-y) nil)
  (for [i 1 10]
    (set (state-x r-x) (gen-x param-x state-x))
    (set (state-y r-y) (gen-y param-y state-y))
    (when (= state-x nil)
      (lua "return true"))
    (when (or (= state-y nil) (not= r-x r-y))
      (lua "return false"))))

(set methods.is_prefix_of is-prefix-of)
(set exports.is_prefix_of is-prefix-of)

(fn all [fun gen-x param-x state-x]
  (let [r nil]
    (while true
      (set-forcibly! (state-x r)
                     (call-if-not-empty fun (gen-x param-x state-x)))
      (when (or (= state-x nil) (not r))
        (lua :break)))
    (= state-x nil)))

(set methods.all (method1 all))
(set exports.all (export1 all))

(fn any [fun gen-x param-x state-x]
  (let [r nil]
    (while true
      (set-forcibly! (state-x r)
                     (call-if-not-empty fun (gen-x param-x state-x)))
      (when (or (= state-x nil) r)
        (lua :break)))
    (not (not r))))

(set methods.any (method1 any))
(set exports.any (export1 any))

(fn sum [gen param state]
  (var s 0)
  (local r 0)
  (while true
    (set s (+ s r))
    (set-forcibly! (state r) (gen param state))
    (when (= state nil)
      (lua :break)))
  s)

(set methods.sum (method0 sum))
(set exports.sum (export0 sum))

(fn product [gen param state]
  (var p 1)
  (local r 1)
  (while true
    (set p (* p r))
    (set-forcibly! (state r) (gen param state))
    (when (= state nil)
      (lua :break)))
  p)

(set methods.product (method0 product))
(set exports.product (export0 product))

(fn min-cmp [m n]
  (if (< n m) n m))

(fn max-cmp [m n]
  (if (> n m) n m))

(fn min [gen param state]
  (var (state m) (gen param state))
  (when (= state nil)
    (error "min: iterator is empty"))
  (var cmp nil)
  (if (= (type m) :number) (set cmp math.min) (set cmp min-cmp))
  (each [_ r gen param state]
    (set m (cmp m r)))
  m)

(set methods.min (method0 min))
(set exports.min (export0 min))

(fn min-by [cmp gen-x param-x state-x]
  (var (state-x m) (gen-x param-x state-x))
  (when (= state-x nil)
    (error "min: iterator is empty"))
  (each [_ r gen-x param-x state-x]
    (set m (cmp m r)))
  m)

(set methods.min_by (method1 min-by))
(set exports.min_by (export1 min-by))

(fn max [gen-x param-x state-x]
  (var (state-x m) (gen-x param-x state-x))
  (when (= state-x nil)
    (error "max: iterator is empty"))
  (var cmp nil)
  (if (= (type m) :number) (set cmp math.max) (set cmp max-cmp))
  (each [_ r gen-x param-x state-x]
    (set m (cmp m r)))
  m)

(set methods.max (method0 max))
(set exports.max (export0 max))

(fn max-by [cmp gen-x param-x state-x]
  (var (state-x m) (gen-x param-x state-x))
  (when (= state-x nil)
    (error "max: iterator is empty"))
  (each [_ r gen-x param-x state-x]
    (set m (cmp m r)))
  m)

(set methods.max_by (method1 max-by))
(set exports.max_by (export1 max-by))

(fn totable [gen-x param-x state-x]
  (let [(tab key val) {}]
    (while true
      (set-forcibly! (state-x val) (gen-x param-x state-x))
      (when (= state-x nil)
        (lua :break))
      (table.insert tab val))
    tab))

(set methods.totable (method0 totable))
(set exports.totable (export0 totable))

(fn tomap [gen-x param-x state-x]
  (let [(tab key val) {}]
    (while true
      (set-forcibly! (state-x key val) (gen-x param-x state-x))
      (when (= state-x nil)
        (lua :break))
      (tset tab key val))
    tab))

(set methods.tomap (method0 tomap))
(set exports.tomap (export0 tomap))

(fn map-gen [param state]
  (let [(gen-x param-x fun) (values (. param 1) (. param 2) (. param 3))]
    (call-if-not-empty fun (gen-x param-x state))))

(fn map [fun gen param state]
  (wrap map-gen [gen param fun] state))

(set methods.map (method1 map))
(set exports.map (export1 map))

(fn flatten-gen-call [state i state-x ...]
  (when (= state-x nil)
    (lua "return nil"))
  (values [(+ i 1) state-x] i ...))

(fn flatten-gen [param state]
  (let [(gen-x param-x) (values (. param 1) (. param 2))
        (i state-x) (values (. state 1) (. state 2))]
    (flatten-gen-call state i (gen-x param-x state-x))))

(fn flatten [gen param state]
  (wrap flatten-gen [gen param] [1 state]))

(set methods.flatten (method0 flatten))
(set exports.flatten (export0 flatten))

(fn with-key-gen-call [new-state ...]
  (when (= new-state nil)
    (lua "return nil"))
  (values new-state new-state ...))

(fn with-key-gen [param state]
  (let [(gen-x param-x) (values (. param 1) (. param 2))]
    (with-key-gen-call (gen-x param-x state))))

(fn with-key [gen param state]
  (wrap with-key-gen [gen param] state))

(set methods.with_key (method0 with-key))
(set exports.with_key (export0 with-key))

(fn index-by-gen-call [_fn new-state ...]
  (when (= new-state nil)
    (lua "return nil"))
  (local key (_fn ...))
  (values new-state key ...))

(fn index-by-gen [param state]
  (let [(_fn gen-x param-x) (values (. param 1) (. param 2) (. param 3))]
    (index-by-gen-call _fn (gen-x param-x state))))

(fn index-by [_fn gen param state]
  (wrap index-by-gen [_fn gen param] state))

(set methods.index_by (method1 index-by))
(set exports.index_by (export1 index-by))

(fn intersperse-call [i state-x ...]
  (when (= state-x nil)
    (lua "return nil"))
  (values [(+ i 1) state-x] ...))

(fn intersperse-gen [param state]
  (let [(x gen-x param-x) (values (. param 1) (. param 2) (. param 3))
        (i state-x) (values (. state 1) (. state 2))]
    (if (= (% i 2) 1) (values [(+ i 1) state-x] x)
        (intersperse-call i (gen-x param-x state-x)))))

(fn intersperse [x gen param state]
  (wrap intersperse-gen [x gen param] [0 state]))

(set methods.intersperse (method1 intersperse))
(set exports.intersperse (export1 intersperse))

(fn zip-gen-r [param state state-new ...]
  (when (= (length state-new) (/ (length param) 2))
    (let [earlyrtn_1 state-new
          earlyrtn_2 ...]
      (lua "return earlyrtn_1, earlyrtn_2")))
  (local i (+ (length state-new) 1))
  (local (gen-x param-x) (values (. param (- (* 2 i) 1)) (. param (* 2 i))))
  (local (state-x r) (gen-x param-x (. state i)))
  (when (= state-x nil)
    (lua "return nil"))
  (table.insert state-new state-x)
  (zip-gen-r param state state-new r ...))

(fn zip-gen [param state]
  (zip-gen-r param state {}))

(fn numargs [...]
  (let [n (select "#" ...)]
    (when (>= n 3)
      (local it (select (- n 2) ...))
      (when (and (and (and (= (type it) :table)
                           (= (getmetatable it) iterator-mt))
                      (= it.param (select (- n 1) ...)))
                 (= it.state (select n ...)))
        (let [earlyrtn_1 (- n 2)]
          (lua "return earlyrtn_1"))))
    n))

(fn zip [...]
  (let [n (numargs ...)]
    (when (= n 0)
      (let [earlyrtns_1 [(wrap nil-gen nil nil)]]
        (lua "return (table.unpack or _G.unpack)(earlyrtns_1)")))
    (local param {(* 2 n) 0})
    (local state {n 0})
    (var (i gen-x param-x state-x) nil)
    (for [i 1 n]
      (local it (select (+ (- n i) 1) ...))
      (set (gen-x param-x state-x) (rawiter it))
      (tset param (- (* 2 i) 1) gen-x)
      (tset param (* 2 i) param-x)
      (tset state i state-x))
    (wrap zip-gen param state)))

(set methods.zip zip)
(set exports.zip zip)

(fn cycle-gen-call [param state-x ...]
  (when (= state-x nil)
    (local (gen-x param-x state-x0)
           (values (. param 1) (. param 2) (. param 3)))
    (let [earlyrtns_1 [(gen-x param-x (deepcopy state-x0))]]
      (lua "return (table.unpack or _G.unpack)(earlyrtns_1)")))
  (values state-x ...))

(fn cycle-gen [param state-x]
  (let [(gen-x param-x state-x0) (values (. param 1) (. param 2) (. param 3))]
    (cycle-gen-call param (gen-x param-x state-x))))

(fn cycle [gen param state]
  (wrap cycle-gen [gen param state] (deepcopy state)))

(set methods.cycle (method0 cycle))
(set exports.cycle (export0 cycle))

(var chain-gen-r1 nil)

(fn chain-gen-r2 [param state state-x ...]
  (when (= state-x nil)
    (var i (. state 1))
    (set i (+ i 1))
    (when (= (. param (- (* 3 i) 1)) nil)
      (lua "return nil"))
    (local state-x (. param (* 3 i)))
    (let [earlyrtns_1 [(chain-gen-r1 param [i state-x])]]
      (lua "return (table.unpack or _G.unpack)(earlyrtns_1)")))
  (values [(. state 1) state-x] ...))

(set chain-gen-r1
     (fn [param state]
       (let [(i state-x) (values (. state 1) (. state 2))
             (gen-x param-x) (values (. param (- (* 3 i) 2))
                                     (. param (- (* 3 i) 1)))]
         (chain-gen-r2 param state (gen-x param-x (. state 2))))))

(fn chain [...]
  (let [n (numargs ...)]
    (when (= n 0)
      (let [earlyrtns_1 [(wrap nil-gen nil nil)]]
        (lua "return (table.unpack or _G.unpack)(earlyrtns_1)")))
    (local param {(* 3 n) 0})
    (var (i gen-x param-x state-x) nil)
    (for [i 1 n]
      (local elem (select i ...))
      (set (gen-x param-x state-x) (iter elem))
      (tset param (- (* 3 i) 2) gen-x)
      (tset param (- (* 3 i) 1) param-x)
      (tset param (* 3 i) state-x))
    (wrap chain-gen-r1 param [1 (. param 3)])))

(set methods.chain chain)
(set exports.chain chain)

exports
