(fn nil? [x]
  (= nil x))

(fn str? [x]
  (= :string (type x)))

(fn num? [x]
  (= :number (type x)))

(fn bool? [x]
  (= :boolean (type x)))

(fn fn? [x]
  (= :function (type x)))

(fn tbl? [x]
  (= :table (type x)))

(fn ->str [x]
  (tostring x))

(fn ->bool [x]
  (if x true false))

{: nil?
 : str?
 : num?
 : bool?
 : fn?
 : tbl?
 : ->str
 : ->bool}
