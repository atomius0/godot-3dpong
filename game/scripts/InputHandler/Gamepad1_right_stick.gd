extends "res://scripts/InputHandler/Gamepad_base.gd"

func _ready():
	joy_device   = 0
	button_up    = JOY_SNES_X
	button_left  = JOY_SNES_Y
	button_down  = JOY_SNES_B
	button_right = JOY_SNES_A
	axis_x       = JOY_ANALOG_1_X
	axis_y       = JOY_ANALOG_1_Y
