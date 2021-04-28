local Concord = require "libs.concord"
local simple = require "src.simplem"
local buttonPush = require "libs.push"

local gameWidth, gameHeight = 640, 360
local windowWidth, windowHeight = 320 * 4, 180 * 4
local pushParameters = {
	fullscreen = false,
	resizable = true,
	pixelperfect = true,
}

-- Temp vars
local palette = require "src.palette"
local mouse_x = nil
local mouse_y = nil
local is_colliding = false

local buttonSystem = Concord.system({
	pool = {"position", "collision", "button"}
})

function buttonSystem:init(world)
	-- This is incredibly scuffed.
	-- Creating a new push instance *probably* isn't 
	-- performance intensive, but it's just bad practice. 
	buttonPush:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, pushParameters)
end

function buttonSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		mouse_x, mouse_y = love.mouse.getPosition()

		local button_x, button_y = buttonPush:toReal(entity.position.x, entity.position.y)
		local button_width, button_height = entity.collision.width, entity.collision.height

		-- yeah yeah i know don't worry ab it
		if simple.isColliding(mouse_x, mouse_y, 1, 1, button_x, button_y, button_width, button_height) then
			is_colliding = true
		else
			is_colliding = false
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
	
	local mouse_x_position = ("Mouse X: " .. tostring(mouse_x))
	local mouse_y_position = ("Mouse Y: " .. tostring(mouse_y))
	love.graphics.printf(mouse_x_position, 0, 0, gameWidth)
	love.graphics.printf(mouse_y_position, 0, 18, gameWidth)

	local is_colliding_message = ("Is Colliding: " .. tostring(is_colliding))
	love.graphics.printf(is_colliding_message, 0, 36, gameWidth)
end

return buttonSystem