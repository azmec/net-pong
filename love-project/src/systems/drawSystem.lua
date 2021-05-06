-- We're not using "real" sprites, just shapes.
-- Cycles through all entities with a "sprite" component
-- and draws a rectangle at their position.

local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local drawSystem = Concord.system({
	pool = {"sprite", "position"}
})

function drawSystem:draw()
	for _, entity in ipairs(self.pool) do
		-- We make use of "palette" here.
		love.graphics.setColor(entity.sprite.color.r,
								entity.sprite.color.g,
							entity.sprite.color.b)
		love.graphics.rectangle("fill", entity.position.x, entity.position.y, entity.sprite.width, entity.sprite.height)
	end
end

return drawSystem