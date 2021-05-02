local Concord = require "libs.concord"

local component = Concord.component("input_step", function(component, step, up, down)
	component.step = step or 1)
	component.count = 0

	-- LOVE keybindings; pressing these ought to increment
	-- the count in their respective direction
	component.up = up or "right"
	component.down = down or "left"

	-- Seconds that have to pass until we consider one "press"
	-- as a "repeat"
	component.initial_delay = 0.1
	component.repeat_delay = 0.5
end)

return component