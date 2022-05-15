(local md5 {:_VERSION "md5.lua 1.1.0"
            :_DESCRIPTION "MD5 computation in Lua (5.1-3, LuaJIT)"
            :_URL "https://github.com/kikito/md5.lua"
            :_LICENSE "    MIT LICENSE

    Copyright (c) 2013 Enrique García Cota + Adam Baldwin + hanzao + Equi 4 Software

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    \"Software\"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  "})
(local (char byte format rep sub)
       (values string.char string.byte string.format string.rep string.sub))
(var (bit-or bit-and bit-not bit-xor bit-rshift bit-lshift) nil)
(local (ok bit) (pcall require :bit))
(if ok (set-forcibly! (bit-or bit-and bit-not bit-xor bit-rshift bit-lshift)
                      (values bit.bor bit.band bit.bnot bit.bxor bit.rshift
                              bit.lshift))
    (do
      (set-forcibly! (ok bit) (pcall require :bit32))
      (if ok (do
               (set bit-not bit.bnot)
               (fn tobit [n]
                 (or (and (<= n 2147483647) n) (- (+ (bit-not n) 1))))

               (fn normalize [f]
                 (fn [a b]
                   (tobit (f (tobit a) (tobit b)))))

               (set-forcibly! (bit-or bit-and bit-xor)
                              (values (normalize bit.bor) (normalize bit.band)
                                      (normalize bit.bxor)))
               (set-forcibly! (bit-rshift bit-lshift)
                              (values (normalize bit.rshift)
                                      (normalize bit.lshift))))
          (do
            (fn tbl2number [tbl]
              (var result 0)
              (var power 1)
              (for [i 1 (length tbl) 1]
                (set result (+ result (* (. tbl i) power)))
                (set power (* power 2)))
              result)
            (fn expand [t1 t2]
              (let [(big small) (values t1 t2)]
                (when (< (length big) (length small))
                  (set-forcibly! (big small) (values small big)))
                (for [i (+ (length small) 1) (length big) 1]
                  (tset small i 0))))

            (var to-bits nil)
            (set bit-not (fn [n]
                           (let [tbl (to-bits n)
                                 size (math.max (length tbl) 32)]
                             (for [i 1 size 1]
                               (if (= (. tbl i) 1) (tset tbl i 0)
                                   (tset tbl i 1)))
                             (tbl2number tbl))))
            (set to-bits (fn [n]
                           (do
                             (when (< n 0)
                               (let [___antifnl_rtns_1___ [(to-bits (+ (bit-not (math.abs n))
                                                                       1))]]
                                 (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
                             (local tbl {})
                             (var cnt 1)
                             (var last nil)
                             (while (> n 0)
                               (set last (% n 2))
                               (tset tbl cnt last)
                               (set-forcibly! n (/ (- n last) 2))
                               (set cnt (+ cnt 1)))
                             tbl)))
            (set bit-or (fn [m n]
                          (let [tbl-m (to-bits m)
                                tbl-n (to-bits n)]
                            (expand tbl-m tbl-n)
                            (local tbl {})
                            (for [i 1 (length tbl-m) 1]
                              (if (and (= (. tbl-m i) 0) (= (. tbl-n i) 0))
                                  (tset tbl i 0) (tset tbl i 1)))
                            (tbl2number tbl))))
            (set bit-and (fn [m n]
                           (let [tbl-m (to-bits m)
                                 tbl-n (to-bits n)]
                             (expand tbl-m tbl-n)
                             (local tbl {})
                             (for [i 1 (length tbl-m) 1]
                               (if (or (= (. tbl-m i) 0) (= (. tbl-n i) 0))
                                   (tset tbl i 0) (tset tbl i 1)))
                             (tbl2number tbl))))
            (set bit-xor (fn [m n]
                           (let [tbl-m (to-bits m)
                                 tbl-n (to-bits n)]
                             (expand tbl-m tbl-n)
                             (local tbl {})
                             (for [i 1 (length tbl-m) 1]
                               (if (not= (. tbl-m i) (. tbl-n i))
                                   (tset tbl i 1) (tset tbl i 0)))
                             (tbl2number tbl))))
            (set bit-rshift (fn [n bits]
                              (var high-bit 0)
                              (when (< n 0)
                                (set-forcibly! n (+ (bit-not (math.abs n)) 1))
                                (set high-bit -2147483648))
                              (local floor math.floor)
                              (for [i 1 bits 1]
                                (set-forcibly! n (/ n 2))
                                (set-forcibly! n (bit-or (floor n) high-bit)))
                              (floor n)))
            (set bit-lshift (fn [n bits]
                              (when (< n 0)
                                (set-forcibly! n (+ (bit-not (math.abs n)) 1)))
                              (for [i 1 bits 1]
                                (set-forcibly! n (* n 2)))
                              (bit-and n -1)))))))
(fn lei2str [i]
  (fn f [s]
    (char (bit-and (bit-rshift i s) 255)))

  (.. (f 0) (f 8) (f 16) (f 24)))
(fn str2bei [s]
  (var v 0)
  (for [i 1 (length s) 1]
    (set v (+ (* v 256) (byte s i))))
  v)
(fn str2lei [s]
  (var v 0)
  (for [i (length s) 1 (- 1)]
    (set v (+ (* v 256) (byte s i))))
  v)
(fn cut-le-str [s ...]
  (var (o r) (values 1 {}))
  (local args {1 ...})
  (for [i 1 (length args) 1]
    (table.insert r (str2lei (sub s o (- (+ o (. args i)) 1))))
    (set o (+ o (. args i))))
  r)
(fn swap [w]
  (str2bei (lei2str w)))
(local CONSTS {1 -680876936
               2 -389564586
               3 606105819
               4 -1044525330
               5 -176418897
               6 1200080426
               7 -1473231341
               8 -45705983
               9 1770035416
               10 -1958414417
               11 -42063
               12 -1990404162
               13 1804603682
               14 -40341101
               15 -1502002290
               16 1236535329
               17 -165796510
               18 -1069501632
               19 643717713
               20 -373897302
               21 -701558691
               22 38016083
               23 -660478335
               24 -405537848
               25 568446438
               26 -1019803690
               27 -187363961
               28 1163531501
               29 -1444681467
               30 -51403784
               31 1735328473
               32 -1926607734
               33 -378558
               34 -2022574463
               35 1839030562
               36 -35309556
               37 -1530992060
               38 1272893353
               39 -155497632
               40 -1094730640
               41 681279174
               42 -358537222
               43 -722521979
               44 76029189
               45 -640364487
               46 -421815835
               47 530742520
               48 -995338651
               49 -198630844
               50 1126891415
               51 -1416354905
               52 -57434055
               53 1700485571
               54 -1894986606
               55 -1051523
               56 -2054922799
               57 1873313359
               58 -30611744
               59 -1560198380
               60 1309151649
               61 -145523070
               62 -1120210379
               63 718787259
               64 -343485551
               65 1732584193
               66 -271733879
               67 -1732584194
               68 271733878})
(fn f [x y z]
  (bit-or (bit-and x y) (bit-and (- (- x) 1) z)))
(fn g [x y z]
  (bit-or (bit-and x z) (bit-and y (- (- z) 1))))
(fn h [x y z]
  (bit-xor x (bit-xor y z)))
(fn i [x y z]
  (bit-xor y (bit-or x (- (- z) 1))))
(fn z [ff a b c d x s ac]
  (set-forcibly! a (bit-and (+ (+ (+ a (ff b c d)) x) ac) -1))
  (+ (bit-or (bit-lshift (bit-and a (bit-rshift -1 s)) s)
             (bit-rshift a (- 32 s))) b))
(fn transform [A B C D X]
  (var (a b c d) (values A B C D))
  (local t CONSTS)
  (set a (z f a b c d (. X 0) 7 (. t 1)))
  (set d (z f d a b c (. X 1) 12 (. t 2)))
  (set c (z f c d a b (. X 2) 17 (. t 3)))
  (set b (z f b c d a (. X 3) 22 (. t 4)))
  (set a (z f a b c d (. X 4) 7 (. t 5)))
  (set d (z f d a b c (. X 5) 12 (. t 6)))
  (set c (z f c d a b (. X 6) 17 (. t 7)))
  (set b (z f b c d a (. X 7) 22 (. t 8)))
  (set a (z f a b c d (. X 8) 7 (. t 9)))
  (set d (z f d a b c (. X 9) 12 (. t 10)))
  (set c (z f c d a b (. X 10) 17 (. t 11)))
  (set b (z f b c d a (. X 11) 22 (. t 12)))
  (set a (z f a b c d (. X 12) 7 (. t 13)))
  (set d (z f d a b c (. X 13) 12 (. t 14)))
  (set c (z f c d a b (. X 14) 17 (. t 15)))
  (set b (z f b c d a (. X 15) 22 (. t 16)))
  (set a (z g a b c d (. X 1) 5 (. t 17)))
  (set d (z g d a b c (. X 6) 9 (. t 18)))
  (set c (z g c d a b (. X 11) 14 (. t 19)))
  (set b (z g b c d a (. X 0) 20 (. t 20)))
  (set a (z g a b c d (. X 5) 5 (. t 21)))
  (set d (z g d a b c (. X 10) 9 (. t 22)))
  (set c (z g c d a b (. X 15) 14 (. t 23)))
  (set b (z g b c d a (. X 4) 20 (. t 24)))
  (set a (z g a b c d (. X 9) 5 (. t 25)))
  (set d (z g d a b c (. X 14) 9 (. t 26)))
  (set c (z g c d a b (. X 3) 14 (. t 27)))
  (set b (z g b c d a (. X 8) 20 (. t 28)))
  (set a (z g a b c d (. X 13) 5 (. t 29)))
  (set d (z g d a b c (. X 2) 9 (. t 30)))
  (set c (z g c d a b (. X 7) 14 (. t 31)))
  (set b (z g b c d a (. X 12) 20 (. t 32)))
  (set a (z h a b c d (. X 5) 4 (. t 33)))
  (set d (z h d a b c (. X 8) 11 (. t 34)))
  (set c (z h c d a b (. X 11) 16 (. t 35)))
  (set b (z h b c d a (. X 14) 23 (. t 36)))
  (set a (z h a b c d (. X 1) 4 (. t 37)))
  (set d (z h d a b c (. X 4) 11 (. t 38)))
  (set c (z h c d a b (. X 7) 16 (. t 39)))
  (set b (z h b c d a (. X 10) 23 (. t 40)))
  (set a (z h a b c d (. X 13) 4 (. t 41)))
  (set d (z h d a b c (. X 0) 11 (. t 42)))
  (set c (z h c d a b (. X 3) 16 (. t 43)))
  (set b (z h b c d a (. X 6) 23 (. t 44)))
  (set a (z h a b c d (. X 9) 4 (. t 45)))
  (set d (z h d a b c (. X 12) 11 (. t 46)))
  (set c (z h c d a b (. X 15) 16 (. t 47)))
  (set b (z h b c d a (. X 2) 23 (. t 48)))
  (set a (z i a b c d (. X 0) 6 (. t 49)))
  (set d (z i d a b c (. X 7) 10 (. t 50)))
  (set c (z i c d a b (. X 14) 15 (. t 51)))
  (set b (z i b c d a (. X 5) 21 (. t 52)))
  (set a (z i a b c d (. X 12) 6 (. t 53)))
  (set d (z i d a b c (. X 3) 10 (. t 54)))
  (set c (z i c d a b (. X 10) 15 (. t 55)))
  (set b (z i b c d a (. X 1) 21 (. t 56)))
  (set a (z i a b c d (. X 8) 6 (. t 57)))
  (set d (z i d a b c (. X 15) 10 (. t 58)))
  (set c (z i c d a b (. X 6) 15 (. t 59)))
  (set b (z i b c d a (. X 13) 21 (. t 60)))
  (set a (z i a b c d (. X 4) 6 (. t 61)))
  (set d (z i d a b c (. X 11) 10 (. t 62)))
  (set c (z i c d a b (. X 2) 15 (. t 63)))
  (set b (z i b c d a (. X 9) 21 (. t 64)))
  (values (bit-and (+ A a) -1) (bit-and (+ B b) -1) (bit-and (+ C c) -1)
          (bit-and (+ D d) -1)))
(fn md5-update [self s]
  (set self.pos (+ self.pos (length s)))
  (set-forcibly! s (.. self.buf s))
  (for [ii 1 (- (length s) 63) 64]
    (local X (cut-le-str (sub s ii (+ ii 63)) 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4))
    (assert (= (length X) 16))
    (tset X 0 (table.remove X 1))
    (set-forcibly! (self.a self.b self.c self.d)
                   (transform self.a self.b self.c self.d X)))
  (set self.buf (sub s (+ (* (math.floor (/ (length s) 64)) 64) 1) (length s)))
  self)
(fn md5-finish [self]
  (let [msg-len self.pos]
    (var pad-len (- 56 (% msg-len 64)))
    (when (> (% msg-len 64) 56)
      (set pad-len (+ pad-len 64)))
    (when (= pad-len 0)
      (set pad-len 64))
    (local s (.. (char 128) (rep (char 0) (- pad-len 1))
                 (lei2str (bit-and (* 8 msg-len) -1))
                 (lei2str (math.floor (/ msg-len 536870912)))))
    (md5-update self s)
    (assert (= (% self.pos 64) 0))
    (.. (lei2str self.a) (lei2str self.b) (lei2str self.c) (lei2str self.d))))
(fn md5.new []
  {:a (. CONSTS 65)
   :b (. CONSTS 66)
   :c (. CONSTS 67)
   :d (. CONSTS 68)
   :pos 0
   :buf ""
   :update md5-update
   :finish md5-finish})
(fn md5.tohex [s]
  (format "%08x%08x%08x%08x" (str2bei (sub s 1 4)) (str2bei (sub s 5 8))
          (str2bei (sub s 9 12)) (str2bei (sub s 13 16))))
(fn md5.sum [s]
  (: (: (md5.new) :update s) :finish))
(fn md5.sumhexa [s]
  (md5.tohex (md5.sum s)))
md5	
