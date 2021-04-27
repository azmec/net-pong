local Concord = require "libs.concord"

local component = Concord.component("physics", function(component, max_speed, acceleration, decceleration))
	component.max_speed = {
		x = max_speed.x or 1,
		y = max_speed.y or 1
	}
	component.acceleration = acceleration or 1
	component.decceleration = decceleration or 1  
return component