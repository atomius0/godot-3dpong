extends Node

var sensitivity = 0.15
var movement = Vector2()

onready var is_html5_version = (OS.get_name() == "HTML5")

func _ready():
	set_process_input(true)
	
	if not is_html5_version:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _exit_tree():
	# disable mouse capture when this node gets deleted.
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _input(event):
	if (event.type == InputEvent.MOUSE_MOTION):
		movement = event.relative_pos * Vector2(1.0, -1.0) * sensitivity
		
	elif (is_html5_version and event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT):
		# capturing the mouse in HTML5 works only during an input callback.
		#print("capturing mouse...")
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _get_movement():
	# return movement and reset it.
	var r = movement
	movement = Vector2()
	return r
