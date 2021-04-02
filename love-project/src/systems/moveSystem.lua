local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local pool = require "libs.concord.pool"

local shash = require "libs.shash"
local pprint = require "libs.pprint"

local collisionWorld = shash.new(32)

local moveSystem = Concord.system({
	pool = {"position", "velocity", "collision"}
})

function pool:onEntityAdded(entity)
	pprint(entity)
end

function moveSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		entity.position.x = entity.position.x + entity.velocity.x
		entity.position.y = entity.position.y + entity.velocity.y 
	end
end

return moveSystem