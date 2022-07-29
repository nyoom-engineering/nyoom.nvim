(local {: setup} (require :gitsigns))

;; basic gitsigns setup
(setup {:signs {:add {:text "│"}
                :change {:text "│"}
                :delete {:text ""}
                :topdelete {:text "‾"}
                :changedelete {:text "~"}
                :current_line_blame_opts {:virt_text true}
                :preview_config {:border :solid
                                 :style :minimal
                                 :relative :cursor}}})
