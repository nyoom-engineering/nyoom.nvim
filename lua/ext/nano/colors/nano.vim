" lua << EOF
"     for k in pairs(package.loaded) do
"         if k:match(".*nano.*") then package.loaded[k] = nil end
"     end
" EOF

lua require('nano').colorscheme()

