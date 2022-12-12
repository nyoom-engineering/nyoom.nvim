(fn djb2 [str]
  "Implementation of the hash function djb2.
  This implementation is extracted from https://theartincode.stanis.me/008-djb2/.
  
  Arguments:
  * `str`: the string to hash

  Returns:
  * `str` hashed with djb2

  Example:
  ```fennel
  (assert (= (djb2 \"hello\") \"5d41402abc4b2a76b9719d911017c592\"))
  ```"
  (let [bytes (icollect [char (str:gmatch ".")]
                (string.byte char))
        hash (accumulate [hash 5381 _ byte (ipairs bytes)]
               (+ byte hash (bit.lshift hash 5)))]
    (bit.tohex hash)))

{: djb2}
