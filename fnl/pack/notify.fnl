(set vim.notify (require :notify))
(local {: setup} (require :notify))
(setup {:stages :fade_in_slide_out
        :fps 60
        :icons {:ERROR ""
                :WARN ""
                :INFO ""
                :DEBUG ""
                :TRACE "✎"}})

