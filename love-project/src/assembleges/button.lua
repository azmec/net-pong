-- Creates an entity that we can define as a "button."

local Concord = require "libs.concord"
local palette = require "src.palette"

function button(entity, x, y, w, h)
	local width = w or 32
	local height = h or 18

	entity
	:give("position", x or 0, y or 0)
	:give("collision", width, height)
	:give("sprite", width, height, palette.grey)
	:give("button")
end

return button