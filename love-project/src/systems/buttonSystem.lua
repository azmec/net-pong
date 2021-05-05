-- Looking at this, there's probably something to be said
-- for a component that does nothing by itself. Oh well.

local Concord = require "libs.concord"
local palette = require "src.palette"

local buttonSystem = Concord.system({
	pool = {"position", "mouse_collision", "sprite", "button"}
})

function buttonSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		local sprite = entity.sprite
		local button = entity.button
		local mouse_collision = entity.mouse_collision

		--button.is_selected = mouse_collision.is_colliding
		if button.is_selected then
			sprite.color = button.highlighted_color
			button.pressed = mouse_collision.left_clicked

			if mouse_collision.left_released then
				button.signal:emit("pressed")
			end
			if button.pressed then
				sprite.color = button.pressed_color
			end
		else
			button.pressed = false
			sprite.color = button.default_color
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