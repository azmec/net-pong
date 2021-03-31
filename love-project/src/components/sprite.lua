local Concord = require "libs.concord"

local component = Concord.component("sprite", function(component, width, height)
	component.width = width or 10
	component.height = height or 10
end)

return component