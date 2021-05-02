local Signal = require "libs.hump.signal"
local pprint = require "libs.pprint"
local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local simple = require "src.simplem"
local stepHierarchySystem = Concord.system({
	pool = {"step", "hierarchy", "selection"}
})

local function on_step_value_changed(entity, current_value, previous_value)
	
end

function stepHierarchySystem:init(world)
	local pool = self.pool

	function pool:onEntityAdded(entity)
		entity.step.signal:register("value_changed", function(entity, current_value, previous_value)
			local step = entity.step
			local hierarchy = entity.hierarchy
			local selection = entity.selection

			selection.previously_selected = selection.selected
			selection.selected = hierarchy.children[current_value]

			local child = hierarchy.children[current_value]
			child.button.is_selected = true

			local previous_child = hierarchy.children[previous_value]
			previous_child.is_selected = false
		end)
	end

	--[[
	function pool:onEntityRemoved(entity) 
		Signal:remove("value_changed", on_step_value_changed(entity, current_value, previous_value))
	end
	]]
end

--[[
function stepHierarchySystem:update(delta)
	for _, entity in ipairs(self.pool) do
		local step = entity.step
		local hierarchy = entity.hierarchy
		local selection = entity.selection

		selection.selected = hierarchy.children[step.value]

		-- Hardcoding bad design
		local button = hierarchy.children[step.value]
		button.button.is_selected = true
	end
end  
]]

return stepHierarchySystem