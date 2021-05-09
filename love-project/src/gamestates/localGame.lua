-- Local multiplayer gamestate.

local Concord = require "libs.concord"
local pprint = require "libs.pprint"

local palette = require "src.palette"

local pong = require "src.pong"

-- Table for hump.gamestate
local localGame = {}

local localWorld = nil
local localSystems = {}

local gameWidth, gameHeight = 640, 360

local roundStarted = false
local displayMessage = "Press 'space' to start!"

local marginFactor = 32
local gameBall = nil
local player1 = nil
local player2 = nil

local player1Score = 0
local player2Score = 0

-- Reinits the world and gives the pall to the
-- 'winningPlayer'.
local function startNewRound(winningPlayer)
	-- Clearing the world and readding entities.
	player1, player2, gameBall = pong.newRound(localWorld, player1, player2, gameBall)

	if winningPlayer == 1 then
		gameBall.velocity.x = -3
		displayMessage = "Player 1 scored!\nPress 'space' to start!"
	else
		gameBall.velocity.x = 3
		displayMessage = "Player 2 scored!\nPress 'space' to start!"
	end

	roundStarted = false
end

function localGame:init()
	local font = love.graphics.newFont("assets/renogare-regular.otf", 16)
	love.graphics.setFont(font)

	localWorld = Concord.world()
	Concord.utils.loadNamespace("src/systems", localSystems)
	localWorld:addSystems(localSystems.moveSystem, localSystems.bounceSystem, localSystems.drawSystem, localSystems.inputSystem)

	startNewRound(1)
end

function localGame:update(delta)
	if not roundStarted then
		if love.keyboard.isDown('space') then
			roundStarted = true
		end
	end 

	if roundStarted then
		-- '-10' so the ball goes completely off the screen
		-- before being considered 'out.'
		if gameBall.position.x < -10 then
			player2Score = player2Score + 1
			startNewRound(2)
		end

		if gameBall.position.x > gameWidth then
			player1Score = player1Score + 1
			startNewRound(1)
		end

		localWorld:emit("update", delta)
	end
end

function localGame:draw()
	local fps = "FPS: " ..  tostring(love.timer.getFPS())
	love.graphics.setColor(
		palette.white.r,
		palette.white.g,
		palette.white.b)
	love.graphics.printf(fps, 20, 20, gameWidth, "left")

	love.graphics.printf(tostring(player1Score), gameWidth / 3, gameHeight / 2, gameWidth, "left")
	love.graphics.printf(tostring(player2Score), 427, gameHeight / 2, gameWidth, "left")

	if not roundStarted then
		love.graphics.printf(displayMessage, 0, gameHeight / 3, gameWidth, "center")
	end
	localWorld:emit("draw")
end

return localGame