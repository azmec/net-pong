-- Moves the relevant ai to bounce the ball back
-- in an "agressive" manner.

local simple = require "src.simplem"
local Concord = require "libs.concord"
Concord.utils.loadNamespace("src/components")

local aiSystem = Concord.system({
	ai_pool = {"position", "velocity", "collision", "paddle_ai"},
	player_pool = {"position", "velocity", "collision", "input"},
	ball_pool = {"position", "velocity", "collision", "bounce"}
})

function aiSystem:update(delta)
	-- Probably a better way somewhere in the ether.
	local player = self.player_pool[1]
	local player_position = player.position
	local ball = self.ball_pool[1]


	for _, ai in ipairs(self.ai_pool) do
		local ai_position = ai.position
		local ai_velocity = ai.velocity
		local ai_physics = ai.physics
		
		---------------------------------
		-- Predicting the ball's position
		---------------------------------
		local ball_position = ball.position
		local ball_velocity = ball.velocity

		-- If the ball is moving away, we can't make any predictions
		-- quite yet.
		if simple.sign(ball_velocity.x) ~= simple.sign(ai_position.x) then
			ai_velocity.y = simple.lerp(ai_velocity.y, 0, ai_physics.decceleration * delta)
			return
		end

		-- Steering the paddle to the ball's position
		ai_velocity.y = simple.lerp(ai_velocity.y, ball_velocity.y, ai_physics.acceleration * delta)
	end
end

return aiSystem