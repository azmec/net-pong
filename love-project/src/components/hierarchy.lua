local Concord = require "libs.concord"

local component = Concord.component("hierarchy", function(component, parent, ...)
	component.parent = parent
	component.children = {}

	for i, v in ipairs(arg) do
		children.v = v
	end
end)

return component