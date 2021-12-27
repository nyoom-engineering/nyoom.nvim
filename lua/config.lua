--[[
#+begin_rant
There are many neovim configurations that exist (i.e. NvChad, Lunar Vim, etc.). However, many of these configurations suffer from a host of problems:

Some configurations (like NvChad), have very abstracted and complex codebases.
Others rely on having as much overall functionality as possible (like LunarVim).

While none of this is bad, there are some problems that can arise from these choices:

1. Complex codebases lead to less freedom for end-user extensiblity and configuration, as there is more reliance on the maintainer of said code.
2. Users may not use half of what is made avalible to them simply because they don't need all of that functionality, so all of it may not be necessary.

nyoom.nvim provides a solution to these problems by providing only the necessary code in order to make a functioning configuration. The end goal of nyoom.nvim is to be used as a base config for users to extend and add upon, leading to a more unique editing experience. 

The issue is that instead of building thier own configuration, users often want to fork or clone someone elses. 
Of course there is no inherent issue with this, why do the work when someones already done it for you? However, this configuration is opinionated. The configuration is meant to serve /my/ needs and function how /I/ want it to. Obviously not everyone agree's with these choices, so something has to be done. 

In a perfect world, any user could just `git pull` this repo and keep the best of both worlds, my latest updates and their own configurations. However, this method causes merge conflicts and will cause issues down the line. You could of course rebase, but not every user knows how to, and users who change core functionality (e.g. LSP setup) will not recieve updates on lines they changed. 

NVChad and Doom-nvim's solution to this is to create a userconfig, i.e. a file with the lua table that the user can edit to their liking. 
However, this adds more issues, mainly "Core" Configuration files have to reflect the users choices, meaning that others can no longer copy code from a configuration verbatim and put it into their own config, which goes against the spirit of this projects

Doom-emacs has a wise solution to this. While Doom-emacs itself is opinionated, it is broken up into opinionated modules the user can enable/disable, as well as a `config.el` file the user can write their own elisp configurations too. In that spirit, what I have below is a `config.lua`. It follows the same idea, the user can override and add their own configuration. In its current state, its just personal snippets of mine, but soon it will become a file the user can use to modify core features and add their own 

TODO 
- add (after!)/method to override lazy loaded configs
- add way for user to add thier own plugins/configs
#+end_rant
]]

-- Give neovide a pixiedust effect on its trail
vim.g.neovide_cursor_vfx_mode = "pixiedust"

-- Using autocmd and CursorMoved/CursorMovedI events, zz is applied to every keystroke that would change the cursor position. Minorly optimized by only applying zz to vertical line movement. Will update to lua once autocmd is natively supported, vimscript is currently more performant
vim.api.nvim_exec(
  [[
    :function StayCenteredI()
    :  let line = line(".")
    :  if line != get(b:, 'last_line', 0)
    :    let col = getcurpos()[4]
    :    normal! zz
    :    call cursor(line, col)
    :    let b:last_line = line
    :  endif
    :endfunction
    :function StayCentered()
    :  let line = line(".")
    :  if line != get(b:, 'last_line', 0)
    :    normal! zz
    :    let b:last_line = line
    :  endif
    :endfunction
    augroup StayCentered
      autocmd!
      autocmd CursorMovedI * :call StayCenteredI()
      autocmd CursorMoved * :call StayCentered()
    augroup END
  ]], true
)

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- I want to defer lsp by a bit, and some other utilities 
local M = {}
M.packer_lazy_load = function(plugin, timer)
   if plugin then
      timer = timer or 0
      vim.defer_fn(function()
         require("packer").loader(plugin)
      end, timer)
   end
end
return M


