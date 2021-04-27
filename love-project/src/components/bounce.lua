local Concord = require "libs.concord"

local component = Concord.component("bounce", function(component)
	component.can_bounce_vertical = true
	component.can_bounce_horizontal = true

	component.y_bounce = 0.5
	component.x_bounce = 0.5 
end)