(local {: setup} (require :compleet))

(setup {:sources {:lipsum {:enable true}}
        :ui {:menu {:border {:enable true 
                             :style :single}}
             :details {:border {:enable true
                                :style [" "
                                        " "
                                        " "
                                        [" "
                                         :CompleetDetails]]}}}})

