local Concord = require "libs.concord"

local component = Concord.component("input", function(component, move_up, move_down)
	component.processing = true

	component.move_up = move_up or 'w'
	component.move_down = move_down or 's'
end)