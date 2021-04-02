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
	:give("collision", width, height, "bounce")
	:give("sprite", width, height, palette.white)
end

return ball