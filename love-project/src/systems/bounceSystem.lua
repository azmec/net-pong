-- Bounces "bounce" objects.

local Signal = require "libs.hump.signal"
local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local bounceSystem = Concord.system({
	pool = {"velocity", "bounce"}
})


function bounceSystem:init(world)
	-- When another system emits this signal, we "bounce" the
	-- relevant entity according to the normal.
	Signal.register("bounce", function(entity, normal)
		if entity.bounce.can_bounce_horizontal then
			entity.velocity.x = entity.velocity.x * entity.bounce.x_bounce *normal.x
		end
		if entity.bounce.can_bounce_horizontal then
			-- Generate a random y_bounce
			local bounce_magnitude = math.random(2, 5)
			entity.velocity.y = bounce_magnitude * normal.y
		end
	end)
end

return bounceSystem