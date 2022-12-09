(local {: map : map-indexed : nil? : reduce : str? : first : count : empty?}
       (require :core.lib))

(local {: autoload} (require :core.lib.autoload))
(local fennel (autoload :fennel))

(fn pr-str [...]
  (let [s (table.concat (map (fn [x]
                               (fennel.view.serialise x {:one-line true}))
                             [...]) " ")]
    (if (or (nil? s) (= "" s)) :nil s)))

(fn str [...]
  (->> [...]
       (map (fn [s]
              (if (str? s)
                  s
                  (pr-str s))))
       (reduce (fn [acc s]
                 (.. acc s)) "")))

(fn println [...]
  (->> [...]
       (map (fn [s]
              (if (str? s)
                  s
                  (pr-str s))))
       (map-indexed (fn [[i s]]
                      (if (= 1 i)
                          s
                          (.. " " s))))
       (reduce (fn [acc s]
                 (.. acc s)) "")
       print))

(fn pr [...]
  (println (pr-str ...)))

(fn join [...]
  "(join xs) (join sep xs)
  Joins all items of a table together with an optional separator.
  Separator defaults to an empty string.
  Values that aren't a string or nil will go through aniseed.core/pr-str."
  (let [args [...]
        [sep xs] (if (= 2 (count args))
                     args
                     ["" (first args)])
        len (count xs)]
    (var result [])
    (when (> len 0)
      (for [i 1 len]
        (let [x (. xs i)]
          (-?>> (if (= :string (type x)) x
                    (= nil x) x
                    (pr-str x))
                (table.insert result)))))
    (table.concat result sep)))

(fn split [s pat]
  "Split the given string into a sequential table using the pattern."
  (var done? false)
  (var acc [])
  (var index 1)
  (while (not done?)
    (let [(start end) (string.find s pat index)]
      (if (= :nil (type start))
          (do
            (table.insert acc (string.sub s index))
            (set done? true))
          (do
            (table.insert acc (string.sub s index (- start 1)))
            (set index (+ end 1))))))
  acc)

(fn blank? [s]
  "Check if the string is nil, empty or only whitespace."
  (or (empty? s) (not (string.find s "[^%s]"))))

(fn escape-pattern [s]
  "creates a lua pattern matching a literal s"
  (let [(escaped _) (string.gsub s "([().%%%+%-*?%[^$%]])" "%%%1")]
    escaped))

(fn strip-suffix [s suffix]
  (string.gsub s (.. (escape-pattern suffix) "$") ""))

(fn strip-prefix [s prefix]
  (string.gsub s (.. (escape-pattern prefix) "$") ""))

(fn triml [s]
  "Removes whitespace from the left side of string."
  (string.gsub s "^%s*(.-)" "%1"))

(fn trimr [s]
  "Removes whitespace from the right side of string."
  (string.gsub s "(.-)%s*$" "%1"))

(fn trim [s]
  "Removes whitespace from both ends of string."
  (string.gsub s "^%s*(.-)%s*$" "%1"))

{: join
 : split
 : blank?
 : escape-pattern
 : strip-suffix
 : strip-prefix
 : triml
 : trimr
 : trim}
