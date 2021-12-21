((tag ((name) @text.note))
 (#any-of? @text.note "TODO"))

("text" @text.note
 (#any-of? @text.note "TODO"))

((tag ((name) @text.danger))
 (#any-of? @text.danger "FIX"))

("text" @text.danger
 (#any-of? @text.danger "FIX"))
