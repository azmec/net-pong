local Concord = require "libs.concord"
local Color = require "src.color"

local component = Concord.component("sprite", function(component, width, height, color)
	component.width = width or 10
	component.height = height or 10
	component.color = color or Color(1, 1, 1)
end)

return component