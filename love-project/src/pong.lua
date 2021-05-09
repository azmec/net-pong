-- Helper functions that are used in all
-- forms of pong (local, online, or AI play).

local pprint = require "libs.pprint"
local Concord = require "libs.concord"

-- Assembleges
local paddle = require "src.assembleges.paddle"
local ball = require "src.assembleges.ball"
local wall = require "src.assembleges.wall"

local gameWidth, gameHeight = 640, 360
local marginFactor = 32

local pong = {}

-- Creates "walls" for the gameBall to bounce of off
-- along the top and bottom of the screen.
local function createBorderWalls(world)
	local topWall = Concord.entity(world)
	topWall:assemble(wall, 0, -2, gameWidth, 2)

	local bottomWall = Concord.entity(world)
	bottomWall:assemble(wall, 2, gameHeight + 2, gameWidth, 2)
end

-- Clears the world and sets it up for a new round.
function pong.newRound(world, player1, player2, gameBall)
	world:clear()

	createBorderWalls(world)

	player1 = Concord.entity(world)
	player1:assemble(paddle, gameWidth / marginFactor, gameHeight / 2)
	
	player2 = Concord.entity(world)
	player2:assemble(paddle, gameWidth - (gameWidth / marginFactor), gameHeight / 2)
	player2.input.move_up = "up"
	player2.input.move_down = "down"

	gameBall = Concord.entity(world)
	gameBall:assemble(ball, gameWidth / 2, gameHeight / 2)

	return player1, player2, gameBall
end

return pong