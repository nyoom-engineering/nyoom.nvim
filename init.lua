if pcall(require, "hotpot") then
    -- Setup hotpot.nvim
    require("hotpot").setup({
        enable_hotpot_diagnostics = true,
        provide_require_fennel = true,
    })
    -- Import neovim configuration
    require("core")
else
    print("Unable to require hotpot")
end
