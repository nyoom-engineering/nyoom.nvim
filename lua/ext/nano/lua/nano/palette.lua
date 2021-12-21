local color_gamma = require("nano.utils").color_gamma
local gamma = require("nano.config").gamma

local colors = {
    black = "#FFFFFF",
    bg0 = "#FFFFFF",
    bg1 = "#e7e7e7",
    bg2 = "#dfdfdf",
    bg3 = "#c6c7c7",
    bg4 = "#9ca0a4",
    bg5 = "#9ca0a4",
    bg_red = "#FF6961",
    bg_green = "#028e2c",
    bg_blue = "#0098dd",
    diff_red = "#673AB7",
    diff_green = "#028e2c",
    diff_blue = "#0098dd",
    diff_add = "#1E2326",
    diff_change = "#262b3d",
    diff_delete = "#281B27",
    fg = "#37474F",
    red = "#673AB7",
    orange = "#37474F",
    yellow = "#FFaB91",
    green = "#673AB7",
    blue = "#0098dd",
    cyan = "#673AB7",
    purple = "#673AB7",
    grey = "#4A5057",
    none = "NONE",
}

local function gamma_correction(colors)
    local colors_corrected = {}
    for k, v in pairs(colors) do
        colors_corrected[k] = color_gamma(v, gamma)
    end
    return colors_corrected
end

return gamma_correction(colors)
