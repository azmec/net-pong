local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local inputStepSystem = Concord.system({
	pool = {"step", "input"}
})

function inputStepSystem:keyreleased(key, scancode, isrepeat)
	for _, entity in ipairs(self.pool) do
		local step = entity.step
		local input = entity.input

		local current_value = step.value
		if key == input.move_up then
			step.value = current_value + step.step
		end
		if key == input.move_down then
			step.value = current_value - step.step
		end 

	end
end

return inputStepSystem