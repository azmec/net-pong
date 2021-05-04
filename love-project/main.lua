-- Welcome to the main loop of the game!

-----------------------------------------------------------
-- SETUP
-----------------------------------------------------------
local Signal = require "libs.hump.signal"
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
local mainMenu = require "src.gamestates.mainMenu"
local testScene = require "src.gamestates.testScene"

-----------------------------------------------------------
-- ACTUAL GAME
-----------------------------------------------------------

function love.load()
	math.randomseed(os.time())

	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setBackgroundColor(palette.black.r, palette.black.g, palette.black.b)

	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, pushParameters)
	
	Gamestate.switch(mainMenu)

	-- This block doesn't work unless we load mainMenu first.
	-- Seems like bad design to me; fix later
	mainMenu.signal:register("start_button_pressed", function()
		Gamestate.switch(localGame)
	end)
	mainMenu.signal:register("settings_button_pressed", function()

	end)
	mainMenu.signal:register("quit_button_pressed", function()
		love.event.push("quit", 0)
	end)
end

function love.update(delta)
	Gamestate.update(delta)
end

function love.draw()
	push:start()

	Gamestate.draw() 

	push:finish()
end

function love.keypressed(key, scancode, isrepeat)
	Gamestate.keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode, isrepeat)
	Gamestate.keyreleased(key, scancode, isrepeat)
end

function love.mousepressed(x, y, button)
	Gamestate.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	Gamestate.mousereleased(x, y, button)
end

function love.resize(width, height)
	push:resize(width, height)
end
