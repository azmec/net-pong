local simple = require "src.simplem"
local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local mouse_left_clicked = false
local mouse_right_clicked = true
local mouse_left_released = false
local mouse_right_released = false

local mouseCollisionSystem = Concord.system({
	pool = {"mouse_collision", "position"}
})

function mouseCollisionSystem:update(delta)
	local mouse_x, mouse_y = love.mouse.getPosition()
	local mouse_w, mouse_h = 1, 1 

	for _, entity in ipairs(self.pool) do
		local mouse_collision = entity.mouse_collision
		local position = entity.position

		local width, height = mouse_collision.width, mouse_collision.height
		local x, y = position.x, position.y

		mouse_collision.is_colliding = simple.isColliding(mouse_x, mouse_y, mouse_w, mouse_h, x, y, width, height)
		if mouse_collision.is_colliding then
			mouse_collision.left_clicked = mouse_left_clicked
			mouse_collision.left_clicked = mouse_left_clicked
			mouse_collision.right_clicked = mouse_right_clicked
			mouse_collision.right_released = mouse_right_released
		end
	end
end

function mouseCollisionSystem:mousepressed(x, y, mousebutton)
	mouse_left_clicked = (mousebutton == 1)
	mouse_right_clicked = (mouse_button == 2)
end

function mouseCollisionSystem:mousereleased(x, y, mousebutton)
	if mouse_button == 1 then
		mouse_left_clicked = false
		mouse_left_released = true
	elseif mouse_button == 2 then
		mouse_right_clicked = false
		mouse_right_released = true
	end
end

return mouseCollisionSystem
