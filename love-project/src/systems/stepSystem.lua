-- There's certain behaviors we want to exhibit in
-- *all* instances of a step component, such as emitting
-- signals when the value is changed.

local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local stepSystem = Concord.system({
	pool = {"step"}
})

function stepSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		local step = entity.step
		local current_value = step.value

		-- Emitting signal whenever value changes
		if current_value ~= step.previous_value then
			step.signal:emit("value_changed", current_value, step.previous_value)
			step.previous_value = current_value
		end
	end
end

return stepSystem