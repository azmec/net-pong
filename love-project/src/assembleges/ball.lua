-- Ball assemblege (see Concord docs for details.)

local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local palette = require "src.palette"

function ball(entity, x, y, w, h)
	local width = w or 5
	local height = h or 5 

	entity
	:give("position", x, y)
	:give("velocity")
	:give("physics", {x = 10, y = 10})
	:give("collision", width, height, 2, 1)
	:give("sprite", width, height, palette.white)
end

return ball