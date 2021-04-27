-- Bounces "bounce" objects.

local sin, cos = math.sin, math.cos

local Signal = require "libs.hump.signal"
local Pool = require "libs.concord.pool"
local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local bounceSystem = Concord.system({
	pool = {"bounce", "velocity", "position", "physics"}
})

local function get_bounce_angle(entity, other)
	-- Getting the entity's position relative to the other
	local other_middle = other.collision.height / 2
	local relative_y = (other.position.y + other_middle) - entity.position.y
	local normalized_relative_y = relative_y / other_middle
	local bounce_angle = normalized_relative_y * entity.bounce.MAXIMUM_ANGLE

	return bounce_angle
end

local function bounce(entity, other)
	if not pool:eligible(entity) then
		return
	end
	
	local bounce_angle = get_bounce_angle(entity, other)
	entity.velocity.x = entity.physics.max_speed.x * cos(bounce_angle)
	entity.velocity.y = entity.physics.max_speed.y * sin(bounce_angle)

end

function bounceSystem:init(world)
	Signal.register("bounce", bounce(entity, other))
end

return bounceSystem