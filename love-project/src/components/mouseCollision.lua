local Signal = require "libs.hump.signal"
local Concord = require "libs.concord"

local component = Concord.component("mouse_collision", function(component, w, h)
	component.width = w or 10
	component.height = h or 10

	component.is_colliding = false
	component.left_clicked = false
	component.left_released = false
	component.right_clicked = false
	component.right_released = false

	component.signal = Signal.new()
end)

return component