(local os-path-sep
       (let [os (string.lower jit.os)]
         (if (or (= :linux os) (= :osx os) (= :bsd os)) "/" "\\")))

(fn echo! [msg]
  "Print a vim message without any format.
  
  Arguments:
  * `msg`: the message to print
  
  Example:
  ```fennel
  (echo! \"Hello world\")
  ```"
  (vim.notify msg vim.log.levels.INFO))

(fn warn! [msg]
  "Print a vim message with a warning format.
  
  Arguments:
  * `msg`: the message to print
  
  Example:
  ```fennel
  (warn! \"This is a warning\")
  ```"
  (vim.notify msg vim.log.levels.WARN))

(fn err! [msg]
  "Print a vim message with an error format.
  
  Arguments:
  * `msg`: the message to print
  
  Example:
  ```fennel
  (err! \"This is an error\")
  ```"
  (vim.notify msg vim.log.levels.ERROR))

(fn spit [path content]
  "Spit the string into the file.
  
  Arguments:
  * `path`: the path to the file
  * `content`: the string to write to the file
  
  Example:
  ```fennel
  (spit \"file.txt\" \"Hello world\")
  ```"
  (match (io.open path :w)
    (nil msg) (error (.. "Could not open file: " msg))
    f (do
        (f:write content)
        (f:flush)
        (f:close)
        nil)))

(fn slurp [path silent?]
  "Read the file into a string.
  
  Arguments:
  * `path`: the path to the file
  * `silent?`: whether to silence errors (defaults to `false`)
  
  Example:
  ```fennel
  (assert (= (slurp \"file.txt\") \"Hello world\"))
  ```"
  (match (io.open path :r)
    (nil msg) (when (not silent?)
                (error (.. "Could not open file: " msg)))
    f (let [content (f:read :*all)]
        (f:close)
        content)))

(fn tmpfile [contents]
  "Creates a temporary file with the given contents.
  If `contents` is a table, the elements are joined with a newline.
  
  Arguments:
  * `contents`: the contents to write to the file
  
  Returns:
  * the path to the temporary file
  
  Example:
  ```fennel
  (assert (string.match (tmpfile \"Hello world\") \"^/tmp/vim\"
  (assert (string.match (tmpfile {\"Hello\", \"world\"}) \"^/tmp/vim\"))
  ```"
  (let [tmp (vim.fn.tempname)]
    (if (= :table (type contents))
        (spit tmp (.. "\n" contents))
        (spit tmp (or contents "")))
    tmp))

(fn exists? [p]
  "Checks if the given path exists.
  
  Arguments:
  * `p`: the path to check
  
  Returns:
  * `true` if the path exists, `false` otherwise
  
  Example:
  ```fennel
  (assert (exists? \"file.txt\"))
  (assert (not (exists? \"invalid-file.txt\")))
  ```"
  (let [(ok err) (vim.loop.fs_stat p)]
    ok))

(fn directory? [p]
  "Checks if the given path is a directory.
  
  Arguments:
  * `p`: the path to check
  
  Returns:
  * `true` if the path is a directory, `false` otherwise
  
  Example:
  ```fennel
  (assert (directory? \"./\"))
  (assert (not (directory? \"file.txt\")))
  ```"
  (vim.fn.isdirectory p))

(fn file? [p]
  "Checks if the given path is a file.
  
  Arguments:
  * `p`: the path to check
  
  Returns:
  * `true` if the path is a file, `false` otherwise
  
  Example:
  ```fennel
  (assert (file? \"file.txt\"))
  (assert (not (file? \"./\")))
  ```"
  (and (exists? p) (not (directory? p))))

(fn readable? [p]
  "Checks if the given file is readable.
  
  Arguments:
  * `p`: the path to the file
  
  Returns:
  * `true` if the file is readable, `false` otherwise
  
  Example:
  ```fennel
  (assert (readable? \"file.txt\"))
  (assert (not (readable? \"invalid-file.txt\")))
  ```"
  (vim.fn.filereadable p))

(fn normalize-path [p]
  "Normalizes a path to a standard format.
  
  - A tilde (~) character at the beginning of the path is expanded to the user's home directory
  - Backslash (\\) characters are converted to forward slashes (/).
  - Environment variables are also expanded.
  
  Arguments:
  * `p`: the path to normalize
  
  Returns:
  * the normalized path
  
  Example:
  ```fennel
  (assert (= (normalize-path \"~/file.txt\") \"/home/user/file.txt\"))
  (assert (= (normalize-path \"file.txt\") \"file.txt\"))
  ```"
  (vim.fs.normalize p))

(fn absolute-path [p]
  "Returns the absolute path of the given path, relative to the current working directory.
  
  Arguments:
  * `p`: the path to convert to an absolute path
  
  Returns:
  * the absolute path
  
  Example:
  ```fennel
  (assert (= (absolute-path \"file.txt\") (absolute-path \"./file.txt\")))
  ```"
  (vim.fn.fnamemodify p ":p"))

(fn parent-path [p]
  "Returns the parent path of the given path, with the last path component removed.
  
  Arguments:
  * `p`: the path to get the parent path from
  
  Returns:
  * the parent path
  
  Example:
  ```fennel
  (assert (= (parent-path \"./file.txt\") \"./\"))
  (assert (= (parent-path \"/home/user/file.txt\") \"/home/user\"))
  ```"
  (vim.fn.fnamemodify p ":h"))

(fn last-path [p]
  "Returns the last path component of the given path.
  
  Arguments:
  * `p`: the path to get the last component from
  
  Returns:
  * the last path component
  
  Example:
  ```fennel
  (assert (= (last-path \"./file.txt\") \"file.txt\"))
  (assert (= (last-path \"/home/user/file.txt\") \"file.txt\"))
  ```"
  (vim.fn.fnamemodify p ":t"))

(fn strip-ext [p]
  "Returns the given path with one file extension removed.
  
  Arguments:
  * `p`: the path to strip the extension from
  
  Returns:
  * the path with one extension removed
  
  Example:
  ```fennel
  (assert (= (strip-ext \"file.txt.bak\") \"file.txt\"))
  (assert (= (strip-ext \"file.txt\") \"file\"
  ```"
  (vim.fn.fnamemodify p ":r"))

(fn path-extension [p]
  "Returns the file extension of the given path.
  
  Arguments:
  * `p`: the path to get the extension from
  
  Returns:
  * the file extension
  
  Example:
  ```fennel
  (assert (= (path-extension \"file.txt\") \"txt\"))
  (assert (= (path-extension \"file.txt.bak\") \"bak\"))
  ```"
  (vim.fn.fnamemodify p ":e"))

(fn has-extension [p any-of]
  "Checks if the given path has any of the specified extensions.
  
  Arguments:
  * `p`: the path to check the extension of
  * `any-of`: a list of possible extensions
  
  Returns:
  * `true` if the path has any of the specified extensions, `false` otherwise
  
  Example:
  ```fennel
  (assert (= (has-extension \"file.txt\" {\"txt\", \"bak\"}) true))
  (assert (= (has-extension \"file.txt\" {\"exe\", \"dll\"}) false))
  ```"
  (var ext (path-extension p))
  (vim.tbl_contains any-of ext))

(fn path-components [s]
  "Split a path into components.
  
  Arguments:
  * `s`: the path to split into components
  
  Returns:
  * a list of path components
  
  Example:
  ```fennel
  (assert (= (path-components \"./file.txt\") {\"./\", \"file.txt\"}))
  (assert (= (path-components \"/home/user/file.txt\") {\"/\", \"home\", \"user\", \"file.txt\"}))
  ```"
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
  "Removes a path prefix if it exists.
  
  Arguments:
  * `p`: the path to strip the prefix from
  * `prefix`: the prefix to strip
  
  Returns:
  * the path with the prefix stripped
  
  Example:
  ```fennel
  (assert (= (strip-prefix \"/home/user/file.txt\" \"/home\") \"/user/file.txt\"))
  (assert (= (strip-prefix \"/home/user/file.txt\" \"/\") \"/home/user/file.txt\"))
  ```"
  (var prefix-literal (escape-pattern (strip-suffix prefix os-path-sep)))
  (let [(stripped _) (string.gsub p
                                  (.. "^" prefix-literal os-path-sep "+" "(.-)")
                                  "%1")]
    stripped))

(fn strip-suffix [p suffix]
  "Removes a path suffix if it exists.
  
  Arguments:
  * `p`: the path to strip the suffix from
  * `suffix`: the suffix to strip
  
  Returns:
  * the path with the suffix stripped
  
  Example:
  ```fennel
  (assert (= (strip-suffix \"/home/user/file.txt\" \".txt\") \"/home/user/file\"))
  (assert (= (strip-suffix \"/home/user/file.txt\" \"file.txt\") \"/home/user/\"))
  ```"
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
  "Recursively create a directory.
  
  Arguments:
  * `dir`: the directory path to create
  
  Example:
  ```fennel
  (assert (= (mkdirp \"/tmp/dir1/dir2\") true))
  ```"
  (vim.fn.mkdir dir :p))

(fn expand [...]
  "Expand environment variables in a path.
  
  Arguments:
  * `...`: the path to expand
  
  Returns:
  * the expanded path
  
  Example:
  ```fennel
  (assert (= (expand \"$HOME/file.txt\") \"/home/user/file.txt\"))
  ```"
  (vim.fn.expand ...))

(fn concat [...]
  "Join multiple paths together using the platform-specific path separator.
  
  Arguments:
  * `...`: the paths to concatenate
  
  Returns:
  * the concatenated path
  
  Example:
  ```fennel
  (assert (= (concat \"/tmp\" \"file.txt\") \"/tmp/file.txt\"))
  ```"
  (table.concat [...] os-path-sep))

(fn get-clipboard []
  "Get the contents of the clipboard.
  
  Returns:
  * the clipboard contents
  
  Example:
  ```fennel
  (assert (= (get-clipboard) \"hello world\"))
  ```"
  (vim.fn.getreg "+" nil))

(fn set-clipboard [contents]
  "Set the contents of the clipboard.
  
  Arguments:
  * `contents`: the string to set as the clipboard contents
  
  Example:
  ```fennel
  (assert (= (set-clipboard \"hello world\") true))
  ```"
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
