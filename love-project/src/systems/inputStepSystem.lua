local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local start = nil

local inputStepSystem = Concrod.system({
	pool = {"input_step"}
})

local function inptuStepSystem:update(delta)

end

local function inputStepSystem:keypressed(key, scancode, isrepeat)

end

local function inputStepSystem:keyreleased(key, scancode, isrepeat)

end

return inputStepSystem