-- We're just containing our color palette in here so we can
-- require and pull its contents anywhere we need it. 
-- Keeps any future palette swapping simple. 

local color = require "src.color"

local palette = {
	black = color(25, 25, 33),
	red = color(199, 13, 13),
	white = color(229, 214, 194),
	blue = color(138, 188, 185),
	grey = color(52, 58, 75)
}

return palette