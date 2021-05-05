local Concord = require "libs.concord"
local button = require "src.assembleges.button"

function menuButton(entity, x, y, center)
	local width = 256
	local height = 36

	if center then
		x = x - (256 / 2)
		y = y - (36 / 2)
	end 
	button(entity, x, y, width, height)
end

return menuButton