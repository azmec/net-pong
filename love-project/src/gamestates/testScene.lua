-- Testing for menu entity

local palette = require "src.palette"
local pprint = require "libs.pprint"
local Concord = require "libs.concord"
local Systems = {}
local world = nil

local menuButton = require "src.assembleges.menuButton" 

local gameWidth, gameHeight = 640, 360

local testScene = {}

function testScene:init()
	Concord.utils.loadNamespace("src/systems", Systems)
	Concord.utils.loadNamespace("src/components")

	world = Concord.world()
	world:addSystems(
		Systems.drawSystem,
		Systems.mouseCollisionSystem,
		Systems.buttonSystem,
		Systems.selectionSystem,
		Systems.stepSystem,
		Systems.inputStepSystem,
		Systems.stepHierarchySystem)

	local entity1 = Concord.entity(world)
	entity1
	:give("position", 100, 100)
	:give("sprite", 20, 20, palette.red)
	:give("mouse_collision", 20, 20)
	:give("button")

	entity1.button.signal:register("pressed", function()
		print("Pressed!")
	end)
end

function testScene:enter(previous)

end

function testScene:update(delta)
	world:emit("update", delta)
end

function testScene:draw()
	world:emit("draw")
end

function testScene:keypressed(key, scancode, isrepeat)
	world:emit("keypressed", key, scancode, isrepeat)
end

function testScene:keyreleased(key, scancode, isrepeat)
	world:emit("keyreleased", key, scancode, isrepeat)
end

function testScene:mousepressed(x, y, button)
	world:emit("mousepressed", x, y, button)
end

function testScene:mousereleased(x, y, button)
	world:emit("mousereleased", x, y, button)
end

function testScene:leave()

end

return testScene