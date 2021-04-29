-- Component which flags the entity as a "button", 
-- potentially enabling a system to poll if the mouse
-- is over it.

local Concord = require "libs.concord"
local palette = require "src.palette"

local component = Concord.component("button", function(component, text)
	component.is_pressed = false
	component.is_selected = false

	component.default_color = palette.grey
	component.highlighted_color = palette.blue
	component.pressed_color = palette.white

	component.text = ""
	component.text_color = nil
end)
