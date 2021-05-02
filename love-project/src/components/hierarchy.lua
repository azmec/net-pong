local Concord = require "libs.concord"

local component = Concord.component("hierarchy", function(component, ...)
	component.children = {}

	local args = {...}
	for i, v in ipairs(args) do
		component.children[i] = v
	end
end)

return component