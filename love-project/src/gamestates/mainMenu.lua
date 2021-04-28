-- The mainMenu gamestate.

local Concord = require "libs.concord"
local Systems = {}
local world = nil

local menuButton = require "src.assembleges.menuButton"
local start_button = nil
--local settings_button = nil
--local quit_button = nil

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

	start_button = Concord.entity(world)
	menuButton(start_button, gameWidth / 2, gameHeight / 2, true)
	

end

function mainMenu:update(delta)
	world:emit("update", delta)
end

function mainMenu:draw()
	world:emit("draw")
end

return mainMenu
