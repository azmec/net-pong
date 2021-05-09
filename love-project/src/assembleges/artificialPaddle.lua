-- Creates an entity defined as an "AI Paddle."

local Concord = require "libs.concord"
local palette = require "src.palette"

function artificialPaddle(entity, difficulty, x, y, w, h)
	local width = w or 6
	local height = h or 56

	entity
	:give("position", x, y)
	:give("velocity")
	:give("physics", {x = 0, y = 5}, 20, 20)
	:give("collision", width, height, 1, 0)
	:give("sprite", width, height, palette.white)
	:give("paddle_ai", difficulty)
end

return artificialPaddle