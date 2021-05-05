local pprint = require "libs.pprint"
local bump = require "libs.bump"
local simple = require "src.simplem"

local Signal = require "libs.hump.signal"
local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")


local moveSystem = Concord.system({
	moving_pool = {"position", "velocity", "collision"},
	stationary_pool = {"position", "collision"}
})

-------------
-- BUMP WORLD
-------------

local collisionWorld = bump.newWorld(32)

local function add_to_collisionWorld(entity)
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

local function remove_from_collisionWorld(entity)
	if not collisionWorld:hasItem(entity) then
		return
	end 
	collisionWorld:remove(entity)
end

-----------------
-- END BUMP WORLD
-----------------

function moveSystem:init(world)
	-- As a note, this isn't particularly efficient. We're checking
	-- twice per entity added to account for something as simple as
	-- immovable walls, but it's not too detrimental.
	local moving_pool = self.moving_pool
	function moving_pool:onEntityAdded(entity)
		add_to_collisionWorld(entity)
	end
	function moving_pool:onEntityRemoved(entity)
		remove_from_collisionWorld(entity)
	end

	local stationary_pool = self.stationary_pool
	function stationary_pool:onEntityAdded(entity)
		add_to_collisionWorld(entity)
	end
	function stationary_pool:onEntityRemoved(entity)
		remove_from_collisionWorld(entity)
	end
end

function moveSystem:update(delta)
	for _, entity in ipairs(self.moving_pool) do
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