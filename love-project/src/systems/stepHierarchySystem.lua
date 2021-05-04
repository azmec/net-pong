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
		entity.step.signal:register("value_changed", function(current_value, previous_value)
			local step = entity.step
			local hierarchy = entity.hierarchy
			local selection = entity.selection

			selection.selected = hierarchy.children[step.value]
			--local child = selection.selected
			--child.button.is_selected = true
		end)
		entity.selection.signal:register("selection_changed", function(current_value, previous_selection)
			local selection = entity.selection
			current_value.button.is_selected = true

			local children = entity.hierarchy.children
			for _, child in ipairs(children) do
				if child ~= current_value then
					child.button.is_selected = false
				end
			end
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