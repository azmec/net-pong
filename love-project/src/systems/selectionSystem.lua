local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local selectionSystem = Concord.system({
	pool = {"selection"}
})

function selectionSystem:update(delta)
	for _, entity in ipairs(self.pool) do
		local selection = entity.selection

		local previous_selection = selection.previously_selected
		local current_selection = selection.selected

		if current_selection ~= previous_selection then
			selection.signal:emit("selection_changed", current_selection, previous_selection)
			selection.previously_selected = current_selection
		end
	end
end

return selectionSystem