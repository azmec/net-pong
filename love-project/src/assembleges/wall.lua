-- Wall assemblege. Rather, this is meant to constitute
-- the border walls surrounding the visible screen to 
-- keep the ball from escaping into the void.

local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local palette = require "src.palette"

function wall(entity, x, y, w, h)
	entity
	:give("position", x, y)
	:give("collision", w, h)
	:give("sprite", w, h, palette.white)
end

return wall