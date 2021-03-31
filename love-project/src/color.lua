-- Returns a Color table with the components r, g, b, a to
-- represent the RBGA color spectrum.

local color = {}
color.__index = color

local function new(r, g, b, a)
	return setmetatable({r = r or 1, g = g or 1, b = b or 1, a = a or 1}, color)
end

return setmetatable({
	new = new
}, {
	__call = function(_, ...) return new(...) end
})