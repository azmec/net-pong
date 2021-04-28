-- The mainMenu gamestate.

local Concord = require "libs.concord"
local Systems = nil
local world = nil

local mainMenu = {}

function mainMenu:init()
	Concord.utils.loadNamespace("src/systems", Systems)
	world:addSystems(Systems.drawSystem)
end

function mainMenu:update(delta)
	world:emit("update", delta)
end

function mainMenu:draw()

end

return mainMenu
