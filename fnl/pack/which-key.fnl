(local {: setup} (require :which-key))
(local misc (require :which-key.plugins.presets.misc))

(tset misc :<c-w> nil)
(setup {:plugins {:presets {:windows false :operators false :motions false :text_objects false :nav false :z false :g false}}})
