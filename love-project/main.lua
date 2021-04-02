-- Welcome to the main loop of the game!

-----------------------------------------------------------
-- SETUP
-----------------------------------------------------------
local Concord = require "libs.concord"
local palette = require "src.palette"
local pprint = require "libs.pprint"
local push = require "libs.push"

local paddle = require "src.assembleges.paddle"
local ball = require "src.assembleges.ball"

local Systems = {}
local world = Concord.world()

local gameWidth, gameHeight = 640, 360
local windowWidth, windowHeight = 320 * 4, 180 * 4
local pushParameters = {
	fullscreen = false,
	resizable = true,
	pixelperfect = true
}

-----------------------------------------------------------
-- ACTUAL GAME
-----------------------------------------------------------

local playing = false 

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	Concord.utils.loadNamespace("src/systems", Systems)
	world:addSystems(Systems.moveSystem, Systems.drawSystem, Systems.inputSystem)

	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, pushParameters)

	local player1 = Concord.entity(world)
	paddle(player1, gameWidth / 2, gameHeight / 2 + 70)

	local gameBall = Concord.entity(world)
	ball(gameBall, gameWidth / 2, gameHeight / 2) 

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