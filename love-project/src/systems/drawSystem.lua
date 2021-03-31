local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local drawSystem = Concord.system({
	pool = {"sprite", "position"}
})

function drawSystem:draw()
	for _, entity in ipairs(self.pool) do
		love.graphics.rectangle("fill", entity.position.x, entity.position.y, entity.sprite.width, entity.sprite.height)
	end
end

return drawSystem