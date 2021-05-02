local Concord = require "libs.concord"
local Signal = require "libs.hump.signal"

local component = Concord.component("step", function(component, step, up, down)
	component.step = step or 1
	component.value = 0
	component.previous_value = 0

	component.maximum_value = 100
	component.minimum_value = 0 
	
	component.signal = Signal.new()
end)

return component