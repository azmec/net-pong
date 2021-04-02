local simple = {}

function simple.bool_to_num(value)
	return value and 1 or 0
end

function simple.clamp(value, min, max)
	return math.max(math.min(value, max), min)
end

function simple.lerp(low, high, progress)
	return low * (1 - progress) + high * progress
end

return simple