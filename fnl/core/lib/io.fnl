(local {: autoload} (require :core.lib.autoload))
(local {: join : escape-pattern : strip-prefix : strip-suffix}
       (autoload :core.lib.string))

(local plenary-path (autoload :plenary.path))

(local os-path-sep
       ;; https://github.com/nvim-lua/plenary.nvim/blob/8bae2c1fadc9ed5bfcfb5ecbd0c0c4d7d40cb974/lua/plenary/path.lua#L20-L31
       (let [os (string.lower jit.os)]
         (if (or (= :linux os) (= :osx os) (= :bsd os)) "/" "\\")))

(λ echo! [msg]
  "Print a vim message without any format."
  (vim.notify msg vim.log.levels.INFO))

(λ warn! [msg]
  "Print a vim message with a warning format."
  (vim.notify msg vim.log.levels.WARN))

(λ err! [msg]
  "Print a vim message with an error format."
  (vim.notify msg vim.log.levels.ERROR))

(fn spit [path content]
  "Spit the string into the file."
  (match (io.open path :w)
    (nil msg) (error (.. "Could not open file: " msg))
    f (do
        (f:write content)
        (f:flush)
        (f:close)
        nil)))

(fn slurp [path silent?]
  "Read the file into a string."
  (match (io.open path :r)
    (nil msg) nil
    f (let [content (f:read :*all)]
        (f:close)
        content)))

(fn tmpfile [contents]
  (let [tmp (vim.fn.tempname)]
    (if (= :table (type contents))
        (spit tmp (string.join "\n" contents))
        (spit tmp (or contents "")))
    tmp))

(fn exists? [p]
  (let [(ok err) (vim.loop.fs_stat p)]
    ok))

(fn directory? [p]
  (vim.fn.isdirectory p))

(fn file? [p]
  (and (exists? p) (not (directory? p))))

(fn readable? [p]
  (vim.fn.filereadable p))

(fn plenary-path-init [...]
  ((. plenary-path "Path::new") ...))

(fn normalize-path [p]
  "Normalize a path to a standard format. A tilde (~) character at the beginning of
  the path is expanded to the user's home directory and any backslash (\\) characters
  are converted to forward slashes (/). Environment variables are also expanded."
  (vim.fs.normalize p))

(fn absolute-path [p]
  "absolute path (relative to cwd)"
  (vim.fn.fnamemodify p ":p"))

(fn parent-path [p]
  "last path component removed (\"head\")"
  (vim.fn.fnamemodify p ":h"))

(fn last-path [p]
  "last path component only (\"tail\")"
  (vim.fn.fnamemodify p ":t"))

(fn strip-ext [p]
  "one extension removed"
  (vim.fn.fnamemodify p ":r"))

(fn path-extension [p]
  "extension only (e.g. `\"fnl\"`)"
  (vim.fn.fnamemodify p ":e"))

(fn has-extension [p any-of]
  (var ext (path-extension p))
  (vim.tbl_contains any-of ext))

(fn path-components [s]
  "Split a path into components"
  (var done? false)
  (var acc [])
  (var index 1)
  (while (not done?)
    (let [(start end) (string.find s os-path-sep index)]
      (if (= :nil (type start))
          (do
            (let [component (string.sub s index)]
              (when (not (string.blank? component))
                (table.insert acc)))
            (set done? true))
          (do
            (let [component (string.sub s index (- start 1))]
              (when (not (string.blank? component))
                (table.insert acc)))
            (set index (+ end 1))))))
  acc)

(fn strip-prefix [p prefix]
  "Removes a path prefix if it exists"
  (var prefix-literal (escape-pattern (strip-suffix prefix os-path-sep)))
  (let [(stripped _) (string.gsub p
                                  (.. "^" prefix-literal os-path-sep "+" "(.-)")
                                  "%1")]
    stripped))

(fn strip-suffix [p suffix]
  "Removes a path suffix if it exists"
  (if (= nil suffix)
      (strip-suffix p os-path-sep)
      (do
        (var suffix-literal (escape-pattern (strip-prefix suffix os-path-sep)))
        (let [(stripped _) (string.gsub p
                                        (.. "(.-)" os-path-sep "+"
                                            suffix-literal)
                                        "%1")]
          stripped))))

(fn mkdirp [dir]
  (vim.fn.mkdir dir :p))

(fn expand [...]
  (vim.fn.expand ...))

(fn concat [...]
  (table.concat [...] os-path-sep))

(fn get-clipboard []
  (vim.fn.getreg "+" nil))

(fn set-clipboard [contents]
  (assert (= :string (type contents)))
  (vim.fn.setreg "+" contents nil))

{: echo!
 : warn!
 : err!
 : spit
 : slurp
 : tmpfile
 : exists?
 : directory?
 : file?
 : readable?
 : plenary-path-init
 : normalize-path
 : absolute-path
 : parent-path
 : last-path
 : strip-ext
 : path-extension
 : path-components
 : strip-prefix
 : strip-suffix
 : mkdirp
 : expand
 : concat
 : get-clipboard
 : set-clipboard}
