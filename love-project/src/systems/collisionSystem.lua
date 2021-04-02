local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local simple = require "src.simplem"

local collisionSystem = Concord.system({
	pool = {"collision", "position", "velocity"}
})

function collisionSystem:update(delta)
	-- I'm realizing now that ECS might have been the wrong
	-- move for a project this small. Normally, I'd use a 
	-- spacial hash, but that seems a bit overkill for
	-- Pong, right? We're using a n^2 method here.

	for _, entity in ipairs(self.pool) do
		for _, entity2 in ipairs(self.pool) do
			if entity ~= entity2 then 
				local x1, y1 = entity.position.x, entity.position.y
				local w1, h1 = entity.collision.w, entity.collision.h

				local x2, y2 = entity2.position.x, entity2.position.y
				local w2, h2 = entity2.collision.w, entity2.collision.h

				if simple.isColliding(x1, y1, w1, h1, x2, y2, w2, h2) then
					if entity.collision.response == "stop" then
						print("Stopped!")
					elseif entity.collision.response == "bounce" then
						print("Bounced!")
					end 
				end
			end
		end
	end
end

return collisionSystem