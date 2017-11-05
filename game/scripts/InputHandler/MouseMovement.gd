extends Node

# TODO: disable mouse capture when this node gets deleted!

var sensitivity = 0.15
var movement = Vector2()

func _ready():
	set_process_input(true)
	# there is a bug, that apparently makes it impossible to hide the mouse when it is captured...
	# https://github.com/godotengine/godot/issues/5051
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED | Input.MOUSE_MODE_HIDDEN)
	# these two overwrite each other:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# so let's just hide the mouse and "capture" it via code (in _input):
	# -> nope. capturing via code causes input events, which calls _input(), which causes an infinite loop...
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	# Workaround: capture the mouse and define a custom cursor, which is invisible.
	#TODO: try this!


func _input(event):
	if (event.type == InputEvent.MOUSE_MOTION):
		movement = event.relative_pos * Vector2(1.0, -1.0) * sensitivity


func _get_movement():
	# return movement and reset it.
	var r = movement
	movement = Vector2()
	return r
