local Signal = require "libs.hump.signal"
local Concord = require "libs.concord"

local compoennt = Concord.component("selection", function(component)
	component.selected = nil
	component.previously_selected = nil
	component.signal = Signal.new()
end)

return component