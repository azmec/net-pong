-- Welcome to the main loop of the game!

local Concord = require "libs.concord"
local palette = require "src.palette"
local pprint = require "libs.pprint"
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

	local foo = Concord.entity(world)
	foo:give("position", 10, 10)
	foo:give("velocity", 1, 0)
	foo:give("sprite", 10, 10, palette.white)

	love.graphics.setBackgroundColor(palette.black.r, palette.black.g, palette.black.b)
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