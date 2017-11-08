extends "res://scripts/InputHandler/Gamepad_base.gd"

func _ready():
	joy_device   = 1
	button_up    = JOY_DPAD_UP
	button_left  = JOY_DPAD_LEFT
	button_down  = JOY_DPAD_DOWN
	button_right = JOY_DPAD_RIGHT
	axis_x       = JOY_ANALOG_0_X
	axis_y       = JOY_ANALOG_0_Y
