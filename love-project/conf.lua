-- Configurations specific to LOVE2D.
-- Nothing really interesting here.

function love.conf(t)
	t.version = "11.3"
	t.console = false

	t.window.title = "Net Pong 0.1.1"
	t.window.icon = nil	
	t.window.height = 720
	t.window.width = 1080

	t.modules.joystick = false
	t.modules.touch = false 
end