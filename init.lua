--[[
Entrypoint for the neovim configuration
We simply bootstrap packer and hotpot/aniseed
It's then up to hotpot or aniseed to compile and load fnl/conf/init.fnl
--]]

-- use opt-in filetype.lua instead of vimscript default
-- EXPERIMENTAL: https://github.com/neovim/neovim/pull/16600
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

function ensure(user, repo)
    local install_path = string.format("%s/packer/start/%s", vim.fn.stdpath("data") .. "/site/pack", repo, repo)
        if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.api.nvim_command(string.format("!git clone https://github.com/%s/%s %s", user, repo, install_path))
        vim.api.nvim_command(string.format("packadd %s", repo))
    end
end

-- Bootstrap essential plugins
ensure("wbthomason", "packer.nvim")
ensure("lewis6991", "impatient.nvim")

-- impatient optimization
require("impatient")

--[[
change this to hotpot if you want to use hotpot, and aniseed for aniseed

aniseed: Aniseed bridges the gap between Fennel (a Lisp that compiles to Lua) and Neovim. Allowing you to easily write plugins or configuration in a Clojure-like Lisp with great runtime performance. As opposed to hotpot, aniseed provides macros, is slightly faster and more featureful, compiles fennel files to lua/ directory, andhas better integration with conjure. It aims to provide a more clojure-like experience, and behaves as a superset of fennel.

hotpot: Hotpot will transparently compile your Fennel code into Lua and then return the compiled module. Future calls to `require` (including in future Neovim sessions) will skip the compile step unless it's stale. Only compiles and caches fennel files, providing a more native experience for the user. On the other hand, it is slightly slower and less developed. Users looking for macros can use the builtin macros defined in macros.fnl, or the zest.nvim library.
--]]

fennel_compiler = "hotpot"

if fennel_compiler == "aniseed" then
    ensure("Olical", "aniseed")
    vim.g["aniseed#env"] = {module = "conf.init"}
elseif fennel_compiler == "hotpot" then
    ensure("rktjmp", "hotpot.nvim")
    require("hotpot").setup({
      provide_require_fennel = true,
    })
    require("conf")
else
    error("Unknown compiler")
end

