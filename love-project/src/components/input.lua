local Concord = require "libs.concord"

local component = Concord.component("input", function(component, maxSpeed, acceleration, decceleration)
	component.processing = true

	component.move_up = 'w'
	component.move_down = 's'

	component.maxSpeed = maxSpeed or 1
	component.acceleration = acceleration or 1 
	component.decceleration = decceleration or 1 
end)