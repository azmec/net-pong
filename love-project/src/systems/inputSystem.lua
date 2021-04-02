local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local simple = require "src.simplem"
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

		local y_input = simple.bool_to_num(is_up) - simple.bool_to_num(is_down)

		if is_up then
			entity.velocity.y = entity.velocity.y - entity.input.speed * y_input
		end
		if is_down then 
			entity.velocity.y = entity.velocity.y - entity.input.speed * y_input
		end

		if not is_up and not is_down then
			entity.velocity.y = 0
		end
		
		entity.velocity.y = simple.clamp(entity.velocity.y, -1, 1)
	end
end



return inputSystem