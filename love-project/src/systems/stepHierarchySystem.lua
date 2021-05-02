local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local simple = require "src.simplem"
local stepHierarchySystem = Concord.system({
	pool = {"step", "hierarchy", "selection"}
})

function stepHierarchySystem:update(delta)
	for _, entity in ipairs(self.pool) do
		local step = entity.step
		local hierarchy = entity.hierarchy
		local selection = entity.selection

		step.value = simple.clamp(step.value, 0, #hierarchy.children)

		selection.selected = hierarchy.children[step.value]
	end
end  

return stepHierarchySystem