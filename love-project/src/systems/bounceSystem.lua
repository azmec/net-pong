-- Reflects the velocity of entities with a "bounce"
-- component based on normals.

local sin, cos = math.sin, math.cos

local Signal = require "libs.hump.signal"
local Pool = require "libs.concord.pool"
local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local bounceSystem = Concord.system({
	pool = {"bounce", "velocity", "position", "physics"}
})

-- We want to calculate a general angle using entity's 
-- position relative to what it's colliding with.
local function get_bounce_angle(entity, other)
	-- Getting the entity's position relative to the other
	local other_middle = other.collision.height / 2
	local relative_y = (other.position.y + other_middle) - entity.position.y
	local normalized_relative_y = relative_y / other_middle
	local bounce_angle = normalized_relative_y * entity.bounce.MAXIMUM_ANGLE

	return bounce_angle
end

function bounceSystem:init(world)
	-- We're discerning what kind object we're hitting (paddle or wall)
	-- based on the collision normal. We only do this because we can; 
	-- it's not necessarily a good idea.
	Signal.register("bounce", function(entity, other, normal)
		-- If we're bouncing against a paddle.
		if normal.x ~= 0 then
			local paddle_bounce_angle = get_bounce_angle(entity, other)
			entity.velocity.x = entity.physics.max_speed.x * cos(paddle_bounce_angle) * normal.x
			entity.velocity.y = entity.physics.max_speed.y * -sin(paddle_bounce_angle)
		end

		-- If we're bouncing against a wall.		
		if normal.y ~= 0 then
			-- Calculate random y trajectory and set the direction to the normal
			local bounce_direction = math.random(0.7, 1) * normal.y
			entity.velocity.y = bounce_direction * entity.physics.max_speed.y
		end
	end)
end

return bounceSystem