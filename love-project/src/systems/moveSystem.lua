local pool = require "libs.concord.pool"
local pprint = require "libs.pprint"
local bump = require "libs.bump"
local simple = require "src.simplem"

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
		-- Clamping velocity before doing any math
		entity.velocity.x = simple.clamp(entity.velocity.x, -entity.physics.max_speed.x, entity.physics.max_speed.x)
		entity.velocity.y = simple.clamp(entity.velocity.y, -entity.physics.max_speed.y, entity.physics.max_speed.y)

		-- Calculating current frame's new position
		local newX = entity.position.x + entity.velocity.x
		local newY = entity.position.y + entity.velocity.y 

		-- Moving entities to new position and getting their realized positions
		local actualX, actualY, cols = collisionWorld:move(entity, newX, newY)

		-- Setting positions to realized positions
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