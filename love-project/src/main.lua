-- Welcome to the main loop of the game!

local Concord = require "libs.concord"
local push = require "libs.push"

local Systems = {}
local world = Concord.world()

local gameWidth, gameHeight = 320, 180
local windowWidth, windowHeight = 320 * 4, 180 * 4
local pushParameters = {
	fullscreen = false,
	resizable = true,
	canvas = true,
	pixelperfect = true,
	highdpi = false,
	stretched = false
}

function love.load()
	Concord.utils.loadNamespace("src/systems", Systems)
	world:addSystems(Systems.moveSystem, Systems.drawSystem)

	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, pushParameters)
end

function love.update(delta)
	world:emit("update", delta)
end

function love.draw()
	push:start()

	world:emit("draw")

	push:finish()
end

function love.resize(width, height)
	push:resize(width, height)
end