-- Moves the relevant paddle to bounce the ball back
-- in an "agressive" manner.

local simple = require "src.simplem"
local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local aiSystem = Concord.system({
	paddle_pool = {"position", "velocity", "collision", "paddle_ai"},
	ball_pool = {"position", "velocity", "collision", "bounce"}
})

function aiSystem:update(delta)
	-- Probably a better way somewhere in the ether.
	local ball = self.ball_pool[1]
	local ball_position = ball.position

	for _, paddle in ipairs(self.paddle_pool) do
		local paddle_position = paddle.position
		local paddle_physics = paddle.physics
		
		paddle_position.y = simple.lerp(paddle_position.y, ball_position.y, paddle_physics.acceleration * delta)
	end
end

return aiSystem