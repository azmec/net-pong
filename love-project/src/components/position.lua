local Concord = require "libs.concord"

local component = Concord.component("position", function(component, x, y)
	component.x = x or 0
	component.y = y or 0
end)

return component