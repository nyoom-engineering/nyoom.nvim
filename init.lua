-- use opt-in filetype.lua instead of vimscript default
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- A function that applies passes the output of string.format to the print
-- function
---@param string string #template string
local function fprint(string, ...)
    print(string.format(string, ...))
end

-- A function that verifies if the plugin passed as a parameter is installed,
-- if it isn't it will be installed
---@param plugin string #the plugin, must follow the format `username/repository`
---@param branch string? #the branch of the plugin
local function assert_installed_plugin(plugin, branch)
    local _, _, plugin_name = string.find(plugin, [[%S+/(%S+)]])
    local plugin_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/" .. plugin_name
    if vim.fn.empty(vim.fn.glob(plugin_path)) ~= 0 then
        fprint("Couldn't find '%s', cloning new copy to %s", plugin_name, plugin_path)
        if branch ~= nil then
            vim.fn.system({
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/" .. plugin,
                "--branch",
                branch,
                plugin_path,
            })
        else
            vim.fn.system({
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/" .. plugin,
                plugin_path,
            })
        end
    end
end

-- Install essential plugins
assert_installed_plugin("folke/which-key.nvim")
assert_installed_plugin("wbthomason/packer.nvim")
assert_installed_plugin("rktjmp/hotpot.nvim", "nightly")

-- load/cache config
require [[hotpot]].setup()
require [[init]]
