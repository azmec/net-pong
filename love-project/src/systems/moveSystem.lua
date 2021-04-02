local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local pprint = require "libs.pprint"

local moveSystem = Concord.system({
	pool = {"position", "velocity", "collision"}
})

function moveSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		entity.position.x = entity.position.x + entity.velocity.x
		entity.position.y = entity.position.y + entity.velocity.y 
	end
end

return moveSystem