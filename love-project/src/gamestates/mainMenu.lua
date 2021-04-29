-- The mainMenu gamestate.

local Concord = require "libs.concord"
local Systems = {}
local world = nil

local menuButton = require "src.assembleges.menuButton"
local start_button = nil
local settings_button = nil
local quit_button = nil

local gameWidth, gameHeight = 640, 360

local font_path = "assets/renogare-regular.otf"
local font_size = 16
local font = nil

local mainMenu = {}

function mainMenu:init()
	Concord.utils.loadNamespace("src/systems", Systems)

	world = Concord.world()
	world:addSystems(Systems.drawSystem, Systems.buttonSystem)

	font = love.graphics.newFont(font_path, font_size)
	love.graphics.setFont(font)

	local half_gameHeight = gameHeight / 2
	local spacing = 42

	start_button = Concord.entity(world)
	menuButton(start_button, gameWidth / 2, half_gameHeight - spacing, true)
	start_button.button.text = "START"

	settings_button = Concord.entity(world)
	menuButton(settings_button, gameWidth / 2, half_gameHeight, true)
	settings_button.button.text = "SETTINGS"

	quit_button = Concord.entity(world)
	menuButton(quit_button, gameWidth / 2, half_gameHeight + spacing, true)
	quit_button.button.text = "QUIT"
end

function mainMenu:update(delta)
	world:emit("update", delta)
end

function mainMenu:draw()
	world:emit("draw")
end

function mainMenu:mousepressed(x, y, button)
	world:emit("mousepressed", x, y, button)
end

function mainMenu:mousereleased(x, y, button)
	world:emit("mousereleased", x, y, button)
end

return mainMenu
