local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local pool = require "libs.concord.pool"

local pprint = require "libs.pprint"

local bump = require "libs.bump"

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

function moveSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		local newX = entity.position.x + entity.velocity.x
		local newY = entity.position.y + entity.velocity.y 

		local actualX, actualY, cols = collisionWorld:move(entity, newX, newY)

		entity.position.x, entity.position.y = actualX, actualY

		for i = 1, #cols do
			local other = cols[i].other
			local normal = cols[i].normal
			
			-- TODO: super scuffed ball-bouncing implementation. 
			-- We should move those to a custom collision response
			-- in bump.lua and generalize it.
			if entity.collision.response == "bounce" then
				if entity.collision.mask == other.collision.layer then
					entity.velocity.x = entity.velocity.x * -1.05
				end

				entity.velocity.y = math.random(2, 5)

				if normal.y ~= 0 then
					entity.velocity.y = entity.velocity.y * normal.y
				end
			end
		end 
	end
end

return moveSystem