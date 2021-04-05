-- Local multiplayer gamestate.
-- This is my first attempt at using hump.gamestate,
-- so I'm ultimately unsure as to how to decouple the
-- various aspects of the game. TODO: properly couple.

local Concord = require "libs.concord"
local pprint = require "libs.pprint"

local palette = require "src.palette"

local paddle = require "src.assembleges.paddle"
local ball = require "src.assembleges.ball"
local wall = require "src.assembleges.wall"

local localGame = {}

local localWorld = Concord.world()
local localSystems = {}

local gameWidth, gameHeight = 640, 360

function localGame:enter(previous)
	local font = love.graphics.newFont("assets/nokiafc22.ttf", 8)
	love.graphics.setFont(font)

	Concord.utils.loadNamespace("src/components")
	Concord.utils.loadNamespace("src/systems", localSystems)
	localWorld:addSystems(localSystems.moveSystem, localSystems.drawSystem, localSystems.inputSystem)

	pprint(Concord.components)
	--createBorderWalls()

	local player1 = Concord.entity(localWorld)
	paddle(player1, gameWidth / 8, gameHeight / 2)

	local player2 = Concord.entity(localWorld)
	paddle(player2, gameWidth - (gameWidth / 8), gameHeight / 2)
	player2.input.move_up = 'up'
	player2.input.move_down = 'down'

	local gameBall = Concord.entity(localWorld)
	ball(gameBall, gameWidth / 2, gameHeight / 2) 

	gameBall.velocity.x = -3
end

function localGame:update(delta)
	localWorld:emit("update", delta)
end

function localGame:draw()
	local fps = "FPS: " ..  tostring(love.timer.getFPS())
	love.graphics.setColor(
		palette.white.r,
		palette.white.g,
		palette.white.b)
	love.graphics.printf(fps, 20, 20, gameWidth, "left")

	localWorld:emit("draw")
end

return localGame