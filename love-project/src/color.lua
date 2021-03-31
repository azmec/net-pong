-- Returns a Color table with the components r, g, b, a to
-- represent the RBGA color spectrum.

local color = {}
color.__index = color

-- We're always creating a new color with 0-255 values
-- as a matter of convenience, but LOVE only takes 0-1.
-- So, we convert them at creation.
local function new(r, g, b)
	return setmetatable({r = r / 255 or 1, 
						g = g / 255 or 1, 
						b = b / 255 or 1}, color)
end

return setmetatable({
	new = new
}, {
	__call = function(_, ...) return new(...) end
})