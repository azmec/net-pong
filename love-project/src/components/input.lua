local Concord = require "libs.concord"

local component = Concord.component("input", function(component, speed)
	component.processing = true

	component.speed = speed or 1
	component.move_up = 'w'
	component.move_down = 's'
end)