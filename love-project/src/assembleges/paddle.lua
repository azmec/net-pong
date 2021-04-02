-- Paddle assemblege (see Concord docs for details.)

local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local palette = require "src.palette" 

function paddle(entity, x, y)
	entity
	:give("position", x, y)
	:give("velocity")
	:give("sprite", 10, 50, palette.white)
	:give("input")
end

return paddle