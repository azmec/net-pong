local Concord = require "libs.concord"

local compoennt = Concord.component("selection", function(component)
	component.selected = nil
	component.previously_selected = nil
end)

return component