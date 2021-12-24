local U = {}

function U.tprint(tbl, indent)
   if not indent then
      indent = 0
   end
   for k, v in pairs(tbl) do
      local formatting = string.rep("  ", indent) .. k .. ": "
      if type(v) == "table" then
         print(formatting)
         U.tprint(v, indent + 1)
      elseif type(v) == "boolean" then
         print(formatting .. tostring(v))
      else
         print(formatting .. v)
      end
   end
end

function U.hex2rgb(hex)
   hex = hex:gsub("#", "")
   return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

function U.gamma_corrector(value, gamma)
   value = ((value / 255) ^ (1 / gamma)) * 255
   return math.min(math.max(math.floor(value), 0), 255)
end

function U.color_gamma(hex, gamma)
   if hex:find "#" == nil then
      return hex
   end
   local r, g, b = U.hex2rgb(hex)
   r = U.gamma_corrector(r, gamma)
   g = U.gamma_corrector(g, gamma)
   b = U.gamma_corrector(b, gamma)
   return string.format("#%02x%02x%02x", r, g, b)
end

return U
