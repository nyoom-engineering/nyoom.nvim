local color_gamma = require("nano.utils").color_gamma
local gamma = require("nano.config").gamma

local colors = {
   black = "#FFFFFF",
   bg1 = "#e7e7e7",
   bg2 = "#dfdfdf",
   bg3 = "#c6c7c7",
   bg4 = "#9ca0a4",
   bg5 = "#9ca0a4",
   bg_red = "#FF6961",
   bg_green = "#028e2c",
   bg_blue = "#0098dd",
   fg = "#37474F",
   red = "#673AB7",
   yellow = "#FFaB91",
   blue = "#0098dd",
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
