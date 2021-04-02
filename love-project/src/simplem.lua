-- A collection of simple math functions that I add as needed.
-- Some I just expect in the future.

local simple = {}

-- Converts a boolean value to an integer
-- i.e. true = 1, false = 0
function simple.bool_to_num(value)
	return value and 1 or 0
end

-- Returns a value within the specified range.
function simple.clamp(value, min, max)
	return math.max(math.min(value, max), min)
end

-- Linearly interpolates the given value.
function simple.lerp(low, high, progress)
	return low * (1 - progress) + high * progress
end

-- Returns the length of a line.
function simple.length(x1, y1, x2, x1)
	local dx, dy = x1 - x2, y1 - y2
	return math.sqrt(dx * dx + dy * dy)
end

-- Returns the midpoint of a line.
function simple.midpoint(x1, y1, x2, y2)
	return (x1 + x2) / 2, (y1 + y2) / 2
end 

-- Returns the angle of three points.
-- We're pushing the "simple" mantra here.
function simple.angle(x1, y1, x2, y2, x3, y3)
	local a = simple.length(x3, y3, x2, y2)
	local b = simple.length(x1, y1, x2, y2)
	local c = simple.length(x1, y1, x3, y3)

	return math.acos((a * a + b * b - c * c) / (2 * a * b))
end

-- Returns if two axis-aligned rectangles are colliding.
-- On the very cusp of "simple."
function simple.isColliding(x1, y1, w1, h1, x2, y2, w2, h2)
	return 	x1 < x2 + w2 and
			x2 < x1 + w1 and
			y1 < y2 + h2 and
			y2 < y1 + h1
end

return simple