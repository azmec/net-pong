local Concord = "lib.Concord"
local simple = require "src.simple"
local push = require "libs.push"

local menu = {}

local function button(entity, x, y, w, h)
	entity
	:give("position", x, y)
	:give("collision", w, h)

local function mouseInRect(x, y, w, h)
	local mouseX, mouseY = love.mouse.getPosition() 
	local realX, realY = push:toGame(mouseX, mouseY)
	local mouseWidth, mouseHeight = 5, 5

	return simple.isColliding(
		realX, realY, mouseWidth, mouseHeight,
		x, y, w, h)
end

function menu:init()
	
end

function menu:update()

end

function menu:draw()

end

function menu:keyreleased()

end

function menu:mousepressed()

end


return menu