local color_gamma = require("nano.utils").color_gamma
local gamma = require("nano.config").gamma

local colors = {
   white = "#FFFFFF",
   bg1 = "#ECEFF1",
   bg2 = "#B0BEC5",
   bg_red = "#FF6961",
   bg_green = "#028e2c",
   bg_blue = "#0098dd",
   modeline_fg = "#263238",
   fg = "#37474F",
   yellow = "#FFaB91",
   blue = "#0098dd",
   purple = "#673AB7",
   slightwhite = "#FAFAFA",
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
