local Concord = require "libs.concord"

local component = Concord.component("collision", function(component, width, height, layer, mask)
	component.width = width or 1
	component.height = height or 1

	component.layer = layer or 0
	component.mask = mask or 0
end)


return component