local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local simple = require "src.simplem"
local pprint = require "libs.pprint"

local inputSystem = Concord.system({
	pool = {"input", "velocity", "physics"}
})

function inputSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		if not entity.input.processing then
			return
		end 

		local is_up = love.keyboard.isDown(entity.input.move_up)
		local is_down = love.keyboard.isDown(entity.input.move_down)

		local y_input = simple.bool_to_num(is_down) - simple.bool_to_num(is_up)

		entity.velocity.y = entity.velocity.y + entity.physics.acceleration * y_input * delta

		if not is_up and not is_down then
			entity.velocity.y = simple.lerp(entity.velocity.y, 0, entity.physics.decceleration * delta)
		end
		
		entity.velocity.y = simple.clamp(entity.velocity.y, -entity.physics.max_speed.y, entity.physics.max_speed.y)
	end
end



return inputSystem