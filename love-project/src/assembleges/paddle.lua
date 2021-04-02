-- Paddle assemblege (see Concord docs for details.)

local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local palette = require "src.palette" 

function paddle(entity, x, y, w, h)
	local width = w or 6
	local height = h or 56
	
	entity
	:give("position", x, y)
	:give("velocity")
	:give("collision", width, height)
	:give("sprite", width, height, palette.white)
	:give("input", 10, 5, 2)
end

return paddle