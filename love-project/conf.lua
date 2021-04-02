-- Configurations specific to LOVE2D.
-- Nothing really interesting here.

function love.conf(t)
	t.version = "11.3"
	t.console = false

	t.window.title = "Net Pong 0.0.3"
	t.window.icon = nil	

	t.modules.joystick = false
	t.modules.touch = false 
end