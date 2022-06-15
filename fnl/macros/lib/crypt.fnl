(fn djb2 [str]
  "Implementation of the hash function djb2.
  Extracted the implementation from <https://theartincode.stanis.me/008-djb2/>."
  (let [bytes (icollect [char (str:gmatch ".")] (string.byte char))]
    (accumulate [hash 5381
                 _ byte (ipairs bytes)]
      (+ byte (* hash 33)))))

{: djb2}
