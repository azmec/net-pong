local Concord = require "libs.concord"

local component = Concord.component("input", function(component)
	component.processing = true

	component.move_up = 'w'
	component.move_down = 's' 
end)