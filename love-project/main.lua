-- Welcome to the main loop of the game!

-----------------------------------------------------------
-- SETUP
-----------------------------------------------------------
local Concord = require "libs.concord"
local palette = require "src.palette"
local pprint = require "libs.pprint"
local push = require "libs.push"
local profi = require "libs.profi"

local paddle = require "src.assembleges.paddle"
local ball = require "src.assembleges.ball"
local wall = require "src.assembleges.wall"

local Systems = {}
local world = Concord.world()

local gameWidth, gameHeight = 640, 360
local windowWidth, windowHeight = 320 * 4, 180 * 4
local pushParameters = {
	fullscreen = false,
	resizable = true,
	pixelperfect = true,
}

local function createBorderWalls()
	local topWall = Concord.entity(world)
	wall(topWall, 0, 0, gameWidth, 2)

	local bottomWall = Concord.entity(world)
	wall(bottomWall, 0, gameHeight - 2, gameWidth, 2)

	local leftWall = Concord.entity(world)
	wall(leftWall, 0, 0, 2, gameHeight)
	leftWall.collision.layer = 1

	local rightWall = Concord.entity(world)
	wall(rightWall, gameWidth - 2, 0, 2, gameHeight) 
	rightWall.collision.layer = 1
end
-----------------------------------------------------------
-- ACTUAL GAME
-----------------------------------------------------------

local playing = false 

function love.load()
	--profi:start()
	
	math.randomseed(os.time())

	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setBackgroundColor(palette.black.r, palette.black.g, palette.black.b)

	local font = love.graphics.newFont("assets/nokiafc22.ttf", 8)
	love.graphics.setFont(font)

	Concord.utils.loadNamespace("src/systems", Systems)
	world:addSystems(Systems.moveSystem, Systems.drawSystem, Systems.inputSystem)

	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, pushParameters)

	createBorderWalls()

	local player1 = Concord.entity(world)
	paddle(player1, gameWidth / 8, gameHeight / 2)

	local player2 = Concord.entity(world)
	paddle(player2, gameWidth - (gameWidth / 8), gameHeight / 2)

	local gameBall = Concord.entity(world)
	ball(gameBall, gameWidth / 2, gameHeight / 2) 

	gameBall.velocity.x = -3
end

function love.update(delta)
	world:emit("update", delta)
end

function love.draw()
	push:start()

	local fps = "FPS: " ..  tostring(love.timer.getFPS())
	love.graphics.setColor(
		palette.white.r,
		palette.white.g,
		palette.white.b)
	love.graphics.printf(fps, 20, 20, gameWidth, "left")
	world:emit("draw")

	push:finish()
end

function love.resize(width, height)
	push:resize(width, height)
end

function love.quit()
	--profi:stop()
	--profi:writeReport("report.txt")
end