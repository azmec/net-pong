local Concord = require "libs.concord"

local component = Concord.component("rect", function(component, x, y, w, h)
	component.x = x or 0 
	component.y = y or 0
	component.width = w or 0 
	component.height = h or 0
end)

return component