local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local pprint = require "libs.pprint"

local inputSystem = Concord.system({
	pool = {"input", "velocity"}
})

function inputSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		if not entity.input.processing then
			return
		end 

		local is_up = love.keyboard.isDown(entity.input.move_up)
		local is_down = love.keyboard.isDown(entity.input.move_down)

		if is_up then
			entity.velocity.y = entity.velocity.y - 1
		end
		if is_down then 
			entity.velocity.y = entity.velocity.y + 1
		end

	end
end

return inputSystem