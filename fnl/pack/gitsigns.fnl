(local {: lazy-require!} (require :utils.lazy-require))
(local {: setup } (lazy-require! :gitsigns))

(setup {:signs {:add {:text "│"}
                :change {:text "│"}
                :delete {:text ""}
                :topdelete {:text "‾"}
                :changedelete {:text "~"}}})
