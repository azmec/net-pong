local Concord = require "libs.concord"

local buttonSystem = Concord.system({
	pool = {"position", "collision", "button"}
})

function buttonSystem:update(delta)
	for _, entity in ipairs(self.pool) do

	end
end  

return buttonSystem