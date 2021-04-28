-- Component which flags the entity as a "button", 
-- potentially enabling a system to poll if the mouse
-- is over it.

local Concord = require "libs.concord"

local component = Concord.component("button", function(component, text)
	component.is_pressed = false
	component.is_selected = false

	component.text = ""
end)
