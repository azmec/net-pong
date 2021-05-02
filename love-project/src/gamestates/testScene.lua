-- Testing for menu entity

local Concord = require "libs.concord"
local Systems = {}
local world = nil

local gameWidth, gameHeight = 640, 360

local testScene = {}

function testScene:init()
	Concord.utils.loadNamespace("src/systems", Systems)

	world = Concord.world()
	world:addSystems(
		Systems.drawSystem,
		Systems.buttonSystem,
		Systems.stepSystem,
		Systems.inputStepSystem,
		Systems.stepHierarchySystem)

end

function testScene:enter(previous)

end

function testScene:update(delta)
	world:emit("update", delta)
end

function testScene:draw()
	world:emit("draw")
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