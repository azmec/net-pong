-- Ball assemblege (see Concord docs for details.)

local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local palette = require "src.palette"

function ball(entity, x, y)
	entity
	:give("position", x, y)
	:give("velocity")
	:give("sprite", 10, 10, palette.white)
end

return ball