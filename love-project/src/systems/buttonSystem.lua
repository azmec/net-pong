local Concord = require "libs.concord"
local palette = require "src.palette"

local buttonSystem = Concord.system({
	pool = {"position", "mouse_collision", "button"}
})

function buttonSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		local button = entity.button
		local mouse_collision = entity.mouse_collision

		button.is_selected = mouse_collision.is_colliding
		if mouse_collision.is_colliding then
			if mouse_collision.left_released then
				
			end
		end
	end
end  

function buttonSystem:draw()
	local font = love.graphics.newFont("assets/renogare-regular.otf", 16)
	love.graphics.setFont(font)
	love.graphics.setColor(
		palette.white.r,
		palette.white.g,
		palette.white.b)

	for _, entity in ipairs(self.pool) do
		-- Drawing button text
		love.graphics.printf(entity.button.text, entity.position.x, entity.position.y + (entity.mouse_collision.height / 4), entity.mouse_collision.width, "center")
	end
end

return buttonSystem