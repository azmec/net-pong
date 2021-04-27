local Concord = require "libs.concord"

local component = Concord.component("bounce", function(component)
	-- 75 degrees for reference
	component.MAXIMUM_ANGLE =  5 * math.pi / 12
end)