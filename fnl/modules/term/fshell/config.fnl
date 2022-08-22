(macro sh [...]
  "simple macro to run shell commands inside fennel"
  `(let [str# 
         ,(accumulate 
            [str# ""  _ v# (ipairs [...])]
            (if 
              (in-scope? v#) `(.. ,str# " " ,v#)
              (or (list? v#) (sym? v#)) (.. str# " " (tostring v#))
              (= (type v#) "string") (.. str# " " (string.format "%q" v#))))
         fd# (io.popen str#)
         d# (fd#:read "*a")]
     (fd#:close)
     (string.sub d# 1 (- (length d#) 1))))
