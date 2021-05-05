-- We're doing a lot of hardcoding here because this
-- is a bastardization of how ECS is supposed to be used.
-- Menus might just be the wrong job.

local Signal = require "libs.hump.signal"
local pprint = require "libs.pprint"
local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local simple = require "src.simplem"
local stepHierarchySystem = Concord.system({
	pool = {"step", "hierarchy", "selection"}
})

function stepHierarchySystem:init(world)
	local pool = self.pool

	function pool:onEntityAdded(entity)
		entity.step.signal:register("value_changed", function(current_value, previous_value)
			print("foo1")
			local step = entity.step
			local hierarchy = entity.hierarchy
			local selection = entity.selection

			selection.selected = hierarchy.children[step.value]
			--local child = selection.selected
			--child.button.is_selected = true
		end)
		entity.selection.signal:register("selection_changed", function(current_value, previous_selection)
			print("foo2")
			local selection = entity.selection
			current_value.button.is_selected = true

			-- Holy fuck this is terrible
			local children = entity.hierarchy.children
			for _, child in ipairs(children) do
				if child ~= current_value then
					child.button.is_selected = false
				end
			end
		end)
	end

	function pool:onEntityRemoved(entity) 
		local step, selection = entity.step, entity.selection
		step.signal:clear("value_changed")
		selection.signal:clear("selection_changed")
	end
	
end

return stepHierarchySystem