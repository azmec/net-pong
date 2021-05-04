-- Testing for menu entity

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
		Systems.buttonSystem,
		Systems.selectionSystem,
		Systems.stepSystem,
		Systems.inputStepSystem,
		Systems.stepHierarchySystem)

	local half_gameHeight = gameHeight / 2
	local spacing = 42

	local test_button1 = Concord.entity(world)
	test_button1:assemble(menuButton, gameWidth / 2, half_gameHeight - spacing, true)
	test_button1.button.text = "BUTTON 1"

	local test_button2 = Concord.entity(world)
	test_button2:assemble(menuButton, gameWidth / 2, half_gameHeight, true)
	test_button2.button.text = "BUTTON 2"

	local test_button3 = Concord.entity(world)
	test_button3:assemble(menuButton, gameWidth / 2, half_gameHeight + spacing, true)
	test_button3.button.text = "BUTTON 3"

	local menu = Concord.entity(world)
	menu:give("hierarchy", test_button1, test_button2, test_button3)
	menu:give("selection")
	menu:give("step", 1, 1, #menu.hierarchy.children)
	menu:give("input", 's', 'w')


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