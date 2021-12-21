local function get(setting, default)
    local key = "nano_" .. setting
    if vim.g[key] == nil then
        return default
    end
    return vim.g[key]
end

local config = {
    bg = get("transparent_background", false),
    italic = get("enable_italic", true),
    italic_comment = get("enable_italic_comment", true),
    gamma = get("color_gamma", "1.0"),
}

return config
