-- The mainMenu gamestate.

local Signal = require "libs.hump.signal"
local Concord = require "libs.concord"
local Systems = {}
local world = nil

local menuButton = require "src.assembleges.menuButton"
local local_play_button = nil
local multiplayer_button = nil
local quit_button = nil

local gameWidth, gameHeight = 640, 360

local font_path = "assets/renogare-regular.otf"
local font_size = 16
local font = nil

-- Table for hump.gamestate
local mainMenu = {}
mainMenu.signal = Signal.new()

function mainMenu:init()

	Concord.utils.loadNamespace("src/systems", Systems)

	world = Concord.world()
	world:addSystems(Systems.drawSystem, Systems.buttonSystem, Systems.mouseCollisionSystem, Systems.selectionSystem, Systems.stepSystem, Systems.inputStepSystem, Systems.stepHierarchySystem)

	font = love.graphics.newFont(font_path, font_size)
	love.graphics.setFont(font)

	-- Setting up for button positions
	local half_gameHeight = gameHeight / 2
	local spacing = 42

	local_play_button = Concord.entity(world)
	menuButton(local_play_button, gameWidth / 2, half_gameHeight - spacing, true)
	local_play_button.button.text = "LOCAL PLAY"
	local_play_button.button.signal:register("pressed", function()
		self.signal:emit("local_play_button_pressed")
	end)

	multiplayer_button = Concord.entity(world)
	multiplayer_button:assemble(menuButton, gameWidth / 2, half_gameHeight, true)
	multiplayer_button.button.text = "ONLINE PLAY"
	multiplayer_button.button.signal:register("pressed", function()
		self.signal:emit("multiplayer_button_pressed")
	end)

	quit_button = Concord.entity(world)
	menuButton(quit_button, gameWidth / 2, half_gameHeight + spacing, true)
	quit_button.button.text = "QUIT"
	quit_button.button.signal:register("pressed", function()
		self.signal:emit("quit_button_pressed")
	end)

	-- Creating the faux menu entity
	local menu = Concord.entity(world)
	menu:give("hierarchy", local_play_button, multiplayer_button, quit_button)
	menu:give("selection")
	menu:give("step", 1, 1, #menu.hierarchy.children)
	menu:give("input", 's', 'w')

	menu.selection.selected = local_play_button
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
