-- Cycles through all entities with a button-like
-- components and checks for their being pressed,
-- hovered, and such.

local Concord = require "libs.concord"
local palette = require "src.palette"

local confirmed = false
local buttonSystem = Concord.system({
	pool = {"position", "mouse_collision", "sprite", "button"}
})

-- Cycling through all relevant entities to
-- determine if they're being selected or pressed.
function buttonSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		local sprite = entity.sprite
		local button = entity.button
		local mouse_collision = entity.mouse_collision

		if mouse_collision.is_colliding or button.is_selected then
			-- Altering button color
			sprite.color = button.highlighted_color
			button.pressed = mouse_collision.left_clicked

			-- If we either release left-click or "return"
			-- while the button is selected
			if mouse_collision.left_released or confirmed then
				-- Emit for other entity to handle.
				button.signal:emit("pressed")
			end
			if button.pressed then
				sprite.color = button.pressed_color
			end
		else
			button.pressed = false
			sprite.color = button.default_color
		end

		-- If the user is hovering and selecting buttons, give
		-- preference to the mouse.
		if mouse_collision.is_colliding and button.is_selected then
			button.is_selected = false
		end
	end

	confirmed = false
end  

-- Drawing the font for each button.
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

-- While we're handling keyinput here, some thought should
-- be given to offloading this behavior.
function buttonSystem:keyreleased(key, scancode, isrepeat)
	if key == "return" or key == "space" then
		confirmed = true
	end
end

return buttonSystem