local pool = require "libs.concord.pool"
local pprint = require "libs.pprint"
local bump = require "libs.bump"

local Signal = require "libs.hump.signal"
local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local collisionWorld = bump.newWorld(32)

local moveSystem = Concord.system({
	pool = {"position", "velocity", "collision"}
})

function pool:onEntityAdded(entity)
	if collisionWorld:hasItem(entity) then
		return
	end

	collisionWorld:add(
		entity,
		entity.position.x,
		entity.position.y,
		entity.collision.width,
		entity.collision.height)
end

function pool:onEntityRemoved(entity)
	if not collisionWorld:hasItem(entity) then
		return
	end 
	
	collisionWorld:remove(entity)
end

function moveSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		local newX = entity.position.x + entity.velocity.x
		local newY = entity.position.y + entity.velocity.y 

		local actualX, actualY, cols = collisionWorld:move(entity, newX, newY)

		entity.position.x, entity.position.y = actualX, actualY

		for i = 1, #cols do
			local other = cols[i].other
			local normal = cols[i].normal
			
			if entity:has("bounce") then
				Signal.emit("bounce", entity, other, normal)
			end
		end 
	end
end

return moveSystem