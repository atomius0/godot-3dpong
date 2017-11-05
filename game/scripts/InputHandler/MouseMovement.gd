extends Node

var sensitivity = 0.15
var move_to = Vector2()

func _ready():
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if (event.type == InputEvent.MOUSE_MOTION):
		move_to = move_to + (event.relative_pos * Vector2(1.0, -1.0) * sensitivity)


func _get_movement():
	return move_to
