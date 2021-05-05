-- Looking at this, there's probably something to be said
-- for a component that does nothing by itself. Oh well.

local Concord = require "libs.concord"
local palette = require "src.palette"

local confirmed = false
local buttonSystem = Concord.system({
	pool = {"position", "mouse_collision", "sprite", "button"}
})

function buttonSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		local sprite = entity.sprite
		local button = entity.button
		local mouse_collision = entity.mouse_collision

		--button.is_selected = mouse_collision.is_colliding
		if mouse_collision.is_colliding or button.is_selected then
			sprite.color = button.highlighted_color
			button.pressed = mouse_collision.left_clicked

			if mouse_collision.left_released or confirmed then
				button.signal:emit("pressed")
			end
			if button.pressed then
				sprite.color = button.pressed_color
			end
		else
			button.pressed = false
			sprite.color = button.default_color
		end

		if mouse_collision.is_colliding and button.is_selected then
			-- give preference to the mouse
			button.is_selected = false
		end
	end

	confirmed = false
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

function buttonSystem:keyreleased(key, scancode, isrepeat)
	if key == "return" or key == "space" then
		confirmed = true
	end
end

return buttonSystem