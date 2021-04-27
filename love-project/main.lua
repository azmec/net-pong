-- Welcome to the main loop of the game!

-----------------------------------------------------------
-- SETUP
-----------------------------------------------------------
local Gamestate = require "libs.hump.gamestate"
local push = require "libs.push"

local gameWidth, gameHeight = 640, 360
local windowWidth, windowHeight = 320 * 4, 180 * 4
local pushParameters = {
	fullscreen = false,
	resizable = true,
	pixelperfect = true,
}

local palette = require 'src.palette'
local localGame = require 'src.gamestates.localGame'

-----------------------------------------------------------
-- ACTUAL GAME
-----------------------------------------------------------

function love.load()
	math.randomseed(os.time())

	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setBackgroundColor(palette.black.r, palette.black.g, palette.black.b)

	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, pushParameters)
	
	Gamestate.switch(localGame)
end

function love.update(delta)
	Gamestate.update(delta)
end

function love.draw()
	push:start()

	Gamestate.draw() 

	push:finish()
end

function love.resize(width, height)
	push:resize(width, height)
end
