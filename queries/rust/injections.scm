;; extends

(
  (string_literal) @glsl
  (#lua-match? @glsl "^\"%s*#version %d%d%d")
  (#offset! @glsl 0 1 0 -1)
)

(
  (raw_string_literal) @glsl
  (#lua-match? @glsl "^r\"%s*#version %d%d%d")
  (#offset! @glsl 0 2 0 -2)
)

(
  (raw_string_literal) @glsl
  (#lua-match? @glsl "^r#\"%s*#version %d%d%d")
  (#offset! @glsl 0 3 0 -2)
)
