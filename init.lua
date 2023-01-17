-- disable default vimscript bundled plugins, these load very early

local default_plugins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
}

for _, plugin in pairs(default_plugins) do
	vim.g["loaded_" .. plugin] = 1
end

local default_providers = {
	"node",
	"perl",
	"ruby",
}

for _, provider in ipairs(default_providers) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- load hotpot

if pcall(require, "hotpot") then
	-- Setup hotpot.nvim
	require("hotpot").setup({
		provide_require_fennel = true,
		enable_hotpot_diagnostics = false,
		compiler = {
			modules = {
				-- not default but recommended, align lua lines with fnl source
				-- for more debuggable errors, but less readable lua.
				correlate = true,
			},
			macros = {
				-- allow macros to access vim global, needed for nyoom modules
				env = "_COMPILER",
				compilerEnv = _G,
				allowGlobals = true,
				-- plugins = { "core.patch" },
			},
		},
	})
	-- Load profilers if nyoom is started in profile mode
	if os.getenv("NYOOM_PROFILE") then
		require("core.lib.profile").toggle()
	end
	local stdlib = require("core.lib")
	for k, v in pairs(stdlib) do
		rawset(_G, k, v)
	end
	require("core")
else
	print("Unable to require hotpot")
end
