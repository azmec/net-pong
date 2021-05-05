local Concord = require "libs.concord"
local Signal = require "libs.hump.signal"

local component = Concord.component("step", function(component, step, minimum_value, maximum_value)
	component.step = step or 1
	component.value = minimum_value or 0
	component.previous_value = minimum_value or 0

	component.minimum_value = minimum_value or 0 
	component.maximum_value = maximum_value or 100
	
	component.signal = Signal.new()
end)

return component