local Concord = require "libs.concord"

local component = Concord.component("paddle_ai", function(component, difficulty)
	component.difficulty = difficulty or 0
end)