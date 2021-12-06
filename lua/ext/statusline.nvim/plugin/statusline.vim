augroup Inits
    autocmd!
    autocmd WinEnter,BufEnter * lua require'statusline'.activeLine()
    autocmd WinLeave,BufLeave * lua require'statusline'.inActiveLine()
    autocmd WinEnter,BufEnter,WinLeave,BufLeave NvimTree lua require'statusline'.simpleLine()
augroup END

function! Scrollbar() abort
    let width = 9
    let perc = (line('.') - 1.0) / (max([line('$'), 2]) - 1.0)
    let before = float2nr(round(perc * (width - 3)))
    let after = width - 3 - before
    return '[' . repeat(' ',  before) . '=' . repeat(' ', after) . ']'
endfunction
