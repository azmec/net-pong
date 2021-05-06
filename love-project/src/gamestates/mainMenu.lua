-- The mainMenu gamestate.

local Signal = require "libs.hump.signal"
local Concord = require "libs.concord"
local Systems = {}
local world = nil

local menuButton = require "src.assembleges.menuButton"
local start_button = nil
local quit_button = nil

local gameWidth, gameHeight = 640, 360

local font_path = "assets/renogare-regular.otf"
local font_size = 16
local font = nil

-- Table for hump.gamestate
local mainMenu = {}

function mainMenu:init()
	-- Setting up a unique signal
	mainMenu.signal = Signal.new()

	Concord.utils.loadNamespace("src/systems", Systems)

	world = Concord.world()
	world:addSystems(Systems.drawSystem, Systems.buttonSystem, Systems.mouseCollisionSystem, Systems.selectionSystem, Systems.stepSystem, Systems.inputStepSystem, Systems.stepHierarchySystem)

	font = love.graphics.newFont(font_path, font_size)
	love.graphics.setFont(font)

	-- Setting up for button positions
	local half_gameHeight = gameHeight / 2
	local spacing = 42

	start_button = Concord.entity(world)
	menuButton(start_button, gameWidth / 2, half_gameHeight - (spacing / 2), true)
	start_button.button.text = "START"
	start_button.button.signal:register("pressed", function()
		self.signal:emit("start_button_pressed")
	end)
	quit_button = Concord.entity(world)
	menuButton(quit_button, gameWidth / 2, half_gameHeight + (spacing / 2), true)
	quit_button.button.text = "QUIT"
	quit_button.button.signal:register("pressed", function()
		self.signal:emit("quit_button_pressed")
	end)

	-- Creating the faux menu entity
	local menu = Concord.entity(world)
	menu:give("hierarchy", start_button, quit_button)
	menu:give("selection")
	menu:give("step", 1, 1, #menu.hierarchy.children)
	menu:give("input", 's', 'w')

	menu.selection.selected = start_button
end

function mainMenu:update(delta)
	world:emit("update", delta)
end

function mainMenu:draw()
	world:emit("draw")
end

function mainMenu:keyreleased(key, scancode, isrepeat)
	world:emit("keyreleased", key, scancode, isrepeat)
end

function mainMenu:mousepressed(x, y, button)
	world:emit("mousepressed", x, y, button)
end

function mainMenu:mousereleased(x, y, button)
	world:emit("mousereleased", x, y, button)
end

return mainMenu
